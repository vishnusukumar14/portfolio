import 'package:flutter/material.dart';

class EducationCardWidget extends StatelessWidget {
  final String degree;
  final String institution;
  final String duration;
  final String? location;
  final String? university;
  final String? score;

  const EducationCardWidget({
    super.key,
    required this.degree,
    required this.institution,
    required this.duration,
    this.location,
    this.university,
    this.score,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Create enhanced visual hierarchy for better highlighting
    final cardColor = colorScheme.surfaceContainerLow;
    final borderColor = colorScheme.primary.withValues(alpha: 0.2);
    final shadowColor = colorScheme.primary.withValues(alpha: 0.1);

    return Container(
      constraints: BoxConstraints(maxWidth: 500, minWidth: 400),
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 18, offset: Offset(0, 6)),
          // Add subtle inner glow for better highlighting
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Degree title - most prominent
          Text(
            degree,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 6),

          // Institution - secondary prominence
          Text(
            institution,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),

          // University info with icon
          if (university != null) ...[
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.school, size: 16, color: colorScheme.primary),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    university!,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Location info with icon
          if (location != null) ...[
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: colorScheme.primary),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    location!,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: 10),

          // Duration with enhanced styling
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              duration,
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: colorScheme.primary,
              ),
            ),
          ),

          // Score with enhanced highlighting
          if (score != null) ...[
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colorScheme.tertiary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.emoji_events,
                    size: 16,
                    color: colorScheme.tertiary,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Score: ',
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    score!,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
