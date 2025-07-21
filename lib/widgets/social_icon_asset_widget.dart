import 'package:flutter/material.dart';
import 'package:portfolio_app/core/utils.dart';

class SocialIconAsset extends StatelessWidget {
  final String assetPath;
  final String url;
  final double size;

  const SocialIconAsset({
    super.key,
    required this.assetPath,
    required this.url,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Utils.launch(url),
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(assetPath, width: size, height: size),
    );
  }
}
