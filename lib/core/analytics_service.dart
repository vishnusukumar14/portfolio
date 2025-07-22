// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:web/web.dart' as web;
//
// class UserAnalytics {
//   final String userAgent;
//   final String platform;
//   final String language;
//   final DateTime timestamp;
//   final String sessionId;
//
//   UserAnalytics({
//     required this.userAgent,
//     required this.platform,
//     required this.language,
//     required this.timestamp,
//     required this.sessionId,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'userAgent': userAgent,
//     'platform': platform,
//     'language': language,
//     'timestamp': timestamp.toIso8601String(),
//     'sessionId': sessionId,
//   };
// }
//
// class UserLocationData {
//   final String ipAddress;
//   final String country;
//   final String region;
//   final String city;
//
//   UserLocationData({
//     required this.ipAddress,
//     required this.country,
//     required this.region,
//     required this.city,
//   });
// }
//
// class AnalyticsService {
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Collect user analytics
//   static UserAnalytics collectUserAnalytics() {
//     final userAgent = web.window.navigator.userAgent;
//     final platform = web.window.navigator.platform;
//     final language = web.window.navigator.language;
//
//     return UserAnalytics(
//       userAgent: userAgent,
//       platform: platform,
//       language: language,
//       timestamp: DateTime.now(),
//       sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
//     );
//   }
//
//   // Send analytics to Firebase
//   static Future<void> sendAnalyticsToFirebase(
//     UserAnalytics analytics,
//     UserLocationData location,
//   ) async {
//     try {
//       final sanitizedIp = location.ipAddress.replaceAll('.', '-');
//       final docId = sanitizedIp.isNotEmpty ? sanitizedIp : analytics.sessionId;
//
//       await _firestore.collection('portfolio_analytics').doc(docId).set({
//         'ipAddress': location.ipAddress,
//         'country': location.country,
//         'region': location.region,
//         'city': location.city,
//         'visits': FieldValue.arrayUnion([analytics.toJson()]),
//       }, SetOptions(merge: true));
//
//       if (kDebugMode) {
//         print('Analytics (with location) appended to Firebase');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error sending analytics: $e');
//       }
//     }
//   }
//
//   static Future<void> trackUserVisit() async {
//     try {
//       final analytics = collectUserAnalytics();
//       final locationData = await getUserLocationData();
//
//       if (locationData == null) return;
//
//       final location = UserLocationData(
//         ipAddress: locationData['ip'],
//         country: locationData['country_name'],
//         region: locationData['region'],
//         city: locationData['city'],
//       );
//
//       await sendAnalyticsToFirebase(analytics, location);
//
//       if (kDebugMode) {
//         print("User Analytics: ${analytics.toJson()}");
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error tracking user visit: $e');
//       }
//     }
//   }
//
//   static Future<Map<String, dynamic>?> getUserLocationData() async {
//     try {
//       final response = await http.get(Uri.parse('https://ipapi.co/json/'));
//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching IP/location: $e');
//       }
//     }
//     return null;
//   }
// }

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

  Map<String, dynamic> toJson() => {
    'ipAddress': ipAddress,
    'country': country,
    'region': region,
    'city': city,
  };
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

  // Send analytics to Firebase with nested structure
  static Future<void> sendAnalyticsToFirebase(
    UserAnalytics analytics,
    UserLocationData location,
  ) async {
    try {
      // Sanitize IP address for document ID (replace dots with dashes)
      final sanitizedIp = location.ipAddress.replaceAll('.', '-');
      final docId = sanitizedIp.isNotEmpty ? sanitizedIp : 'unknown-ip';

      // Create/update the main IP document with location data
      await _firestore
          .collection('portfolio_analytics')
          .doc(docId)
          .set(location.toJson(), SetOptions(merge: true));

      // Add session data to the nested sessions subcollection
      await _firestore
          .collection('portfolio_analytics')
          .doc(docId)
          .collection('sessions')
          .doc(analytics.sessionId)
          .set(analytics.toJson());

      if (kDebugMode) {
        print('Analytics saved to Firebase with structure:');
        print('portfolio_analytics/$docId -> ${location.toJson()}');
        print(
          'portfolio_analytics/$docId/sessions/${analytics.sessionId} -> ${analytics.toJson()}',
        );
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

      if (locationData == null) {
        if (kDebugMode) {
          print('Could not fetch location data');
        }
        return;
      }

      final location = UserLocationData(
        ipAddress: locationData['ip'] ?? 'unknown',
        country: locationData['country_name'] ?? 'unknown',
        region: locationData['region'] ?? 'unknown',
        city: locationData['city'] ?? 'unknown',
      );

      await sendAnalyticsToFirebase(analytics, location);

      if (kDebugMode) {
        print("User Analytics tracked successfully");
        print("Session: ${analytics.sessionId}");
        print(
          "Location: ${location.city}, ${location.region}, ${location.country}",
        );
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
      } else {
        if (kDebugMode) {
          print('HTTP error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching IP/location: $e');
      }
    }
    return null;
  }

  // Helper method to get all sessions for a specific IP
  static Future<List<Map<String, dynamic>>> getSessionsForIp(
    String ipAddress,
  ) async {
    try {
      final sanitizedIp = ipAddress.replaceAll('.', '-');
      final sessionsSnapshot = await _firestore
          .collection('portfolio_analytics')
          .doc(sanitizedIp)
          .collection('sessions')
          .orderBy('timestamp', descending: true)
          .get();

      return sessionsSnapshot.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching sessions: $e');
      }
      return [];
    }
  }

  // Helper method to get analytics summary
  static Future<Map<String, dynamic>> getAnalyticsSummary() async {
    try {
      final analyticsSnapshot = await _firestore
          .collection('portfolio_analytics')
          .get();

      int totalVisitors = analyticsSnapshot.docs.length;
      int totalSessions = 0;
      Map<String, int> countryCounts = {};

      for (final doc in analyticsSnapshot.docs) {
        final data = doc.data();
        final country = data['country'] ?? 'Unknown';

        // Count sessions for this IP
        final sessionsSnapshot = await doc.reference
            .collection('sessions')
            .get();
        totalSessions += sessionsSnapshot.docs.length;

        // Count countries
        countryCounts[country] = (countryCounts[country] ?? 0) + 1;
      }

      return {
        'totalVisitors': totalVisitors,
        'totalSessions': totalSessions,
        'topCountries': countryCounts,
        'lastUpdated': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      if (kDebugMode) {
        print('Error getting analytics summary: $e');
      }
      return {};
    }
  }
}
