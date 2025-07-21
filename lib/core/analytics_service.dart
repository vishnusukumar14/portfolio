import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;

class UserAnalytics {
  final String userAgent;
  final String platform;
  final String language;
  final DateTime timestamp;
  final String sessionId;

  UserAnalytics({
    required this.userAgent,
    required this.platform,
    required this.language,
    required this.timestamp,
    required this.sessionId,
  });

  Map<String, dynamic> toJson() => {
    'userAgent': userAgent,
    'platform': platform,
    'language': language,
    'timestamp': timestamp.toIso8601String(),
    'sessionId': sessionId,
  };
}

class UserLocationData {
  final String ipAddress;
  final String country;
  final String region;
  final String city;

  UserLocationData({
    required this.ipAddress,
    required this.country,
    required this.region,
    required this.city,
  });
}

class AnalyticsService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collect user analytics
  static UserAnalytics collectUserAnalytics() {
    final userAgent = web.window.navigator.userAgent;
    final platform = web.window.navigator.platform;
    final language = web.window.navigator.language;

    return UserAnalytics(
      userAgent: userAgent,
      platform: platform,
      language: language,
      timestamp: DateTime.now(),
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  // Send analytics to Firebase
  static Future<void> sendAnalyticsToFirebase(
    UserAnalytics analytics,
    UserLocationData location,
  ) async {
    try {
      final sanitizedIp = location.ipAddress.replaceAll('.', '-');
      final docId = sanitizedIp.isNotEmpty ? sanitizedIp : analytics.sessionId;

      await _firestore.collection('portfolio_analytics').doc(docId).set({
        'ipAddress': location.ipAddress,
        'country': location.country,
        'region': location.region,
        'city': location.city,
        'visits': FieldValue.arrayUnion([analytics.toJson()]),
      }, SetOptions(merge: true));

      if (kDebugMode) {
        print('Analytics (with location) appended to Firebase');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending analytics: $e');
      }
    }
  }

  static Future<void> trackUserVisit() async {
    try {
      final analytics = collectUserAnalytics();
      final locationData = await getUserLocationData();

      if (locationData == null) return;

      final location = UserLocationData(
        ipAddress: locationData['ip'],
        country: locationData['country_name'],
        region: locationData['region'],
        city: locationData['city'],
      );

      await sendAnalyticsToFirebase(analytics, location);

      if (kDebugMode) {
        print("User Analytics: ${analytics.toJson()}");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error tracking user visit: $e');
      }
    }
  }

  static Future<Map<String, dynamic>?> getUserLocationData() async {
    try {
      final response = await http.get(Uri.parse('https://ipapi.co/json/'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching IP/location: $e');
      }
    }
    return null;
  }
}
