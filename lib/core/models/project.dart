import 'package:flutter/material.dart';

class Project {
  final String name;
  final String? description;
  final int stars;
  final String codeUrl;
  final String language;
  final bool? isPrivate;
  final Color? languageColor;

  Project({
    required this.name,
    this.description,
    required this.stars,
    required this.codeUrl,
    required this.language,
    this.languageColor,
    this.isPrivate,
  });
}
