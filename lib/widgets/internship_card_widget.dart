import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/models/experience.dart';

class InternshipCard extends StatelessWidget {
  final Experience experience;
  final bool isMobile;

  const InternshipCard({
    required this.experience,
    required this.isMobile,
    super.key,
  });

  Widget _buildTechIcon(String tech, ThemeData theme) {
    // Get custom URL from the experience model
    String? customUrl = experience.getTechUrl(tech);

    // Convert tech name to lowercase and replace spaces with underscores for asset naming
    String assetName = tech
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(' api', '_api')
        .replaceAll('.', '_')
        .replaceAll('-', '_');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
      child: Tooltip(
        message: tech,
        child: Container(
          width: isMobile ? 28 : 32,
          height: isMobile ? 28 : 32,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: _buildTechImage(tech, customUrl, assetName, theme),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechImage(
    String tech,
    String? customUrl,
    String assetName,
    ThemeData theme,
  ) {
    // If custom URL is provided, try to load from URL first
    if (customUrl != null && customUrl.isNotEmpty) {
      // Check if the URL is an SVG
      bool isSvg = customUrl.toLowerCase().endsWith('.svg');

      if (isSvg) {
        return SvgPicture.network(
          customUrl,
          fit: BoxFit.contain,
          placeholderBuilder: (context) => Center(
            child: SizedBox(
              width: isMobile ? 10 : 12,
              height: isMobile ? 10 : 12,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          // If SVG fails, fallback to asset
          // Note: SvgPicture.network doesn't have errorBuilder, so we'll handle this differently
        );
      } else {
        // Handle regular image formats (PNG, JPG, etc.)
        return Image.network(
          customUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // If URL fails, fallback to asset
            return _buildAssetImage(assetName, theme, tech);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                width: isMobile ? 10 : 12,
                height: isMobile ? 10 : 12,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: theme.colorScheme.primary,
                ),
              ),
            );
          },
        );
      }
    }

    // If no custom URL, try asset first
    return _buildAssetImage(assetName, theme, tech);
  }

  Widget _buildAssetImage(String assetName, ThemeData theme, String tech) {
    // Check if the asset is SVG or regular image
    return Image.asset(
      'assets/images/tech/$assetName.svg',
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Try SVG asset if PNG fails
        return _buildSvgAsset(assetName, theme, tech);
      },
    );
  }

  Widget _buildSvgAsset(String assetName, ThemeData theme, String tech) {
    return SvgPicture.asset(
      'assets/images/tech/$assetName.svg',
      fit: BoxFit.contain,
      // If SVG asset also fails, show generic icon
      placeholderBuilder: (context) =>
          Icon(Icons.image, size: isMobile ? 12 : 14, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (_, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Left section (75%)
              Expanded(
                flex: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.work_outline,
                          size: isMobile ? 20 : 24,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            experience.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 14 : 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Company & Duration with Location
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${experience.company} • ${experience.duration}",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: isMobile ? 12 : 13,
                              color: theme.textTheme.bodySmall?.color
                                  ?.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Location if available
                    if (experience.location?.isNotEmpty == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: isMobile ? 12 : 14,
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.7,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              experience.location!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: isMobile ? 11 : 12,
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.8,
                                ),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 8),

                    // Highlights List
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: experience.highlights.map((point) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "• ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: isMobile ? 13 : 14,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  point,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: isMobile ? 13 : 14,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(width: isMobile ? 12 : 16),

              /// Right section (25%) - Tech Stack
              Expanded(
                flex: 25,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tech Stack Header
                      Text(
                        "Tech Stack",
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: isMobile ? 10 : 11,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Tech Icons
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 2,
                        runSpacing: 2,
                        children: experience.techStack.map((tech) {
                          return _buildTechIcon(tech, theme);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
