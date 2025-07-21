import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/models/experience.dart';

class InternshipCard extends StatelessWidget {
  final Experience experience;

  const InternshipCard({super.key, required this.experience});

  void _launchWebsite(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 500;

        // Responsive sizes
        final double logoSize = isMobile ? 48 : 88;
        final double avatarRadius = isMobile ? 16 : 19;
        final double titleFontSize = isMobile ? 15 : 17.2;
        final double companyFontSize = isMobile ? 13.5 : 15.2;
        final double locationFontSize = isMobile ? 10 : 11.5;
        final double chipFontSize = isMobile ? 10.5 : 11.7;
        final double chipIconSize = isMobile ? 11 : 14;
        final double highlightFontSize = isMobile ? 12 : 13.3;
        final double highlightBulletSize = isMobile ? 15 : 19;
        final double durationFontSize = isMobile ? 11.5 : 13.2;
        final double highlightSpacing = isMobile ? 5 : 7;
        final double wrapSpacing = isMobile ? 5 : 8;
        final double wrapRunSpacing = isMobile ? 3 : 5;
        final double paddingV = isMobile ? 12 : 18;
        final double paddingH = isMobile ? 10 : 20;
        final double dividerHeight = isMobile ? 14 : 22;
        final double dividerThick = isMobile ? 0.5 : 1;
        final double headerSpacing = isMobile ? 7 : 13;

        return Container(
          margin: EdgeInsets.symmetric(vertical: isMobile ? 6 : 8),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(isMobile ? 12 : 18),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: isMobile ? 6 : 15,
                offset: Offset(0, isMobile ? 2 : 6),
              ),
            ],
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: isDark ? 0.3 : 0.17),
              width: isMobile ? 0.7 : 1.1,
            ),
          ),
          padding: EdgeInsets.fromLTRB(paddingH, paddingV, paddingH, paddingV),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row: Logo, Title, Location
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo/avatar
                  if (experience.companyLogoUrl != null &&
                      experience.companyLogoUrl!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(isMobile ? 5 : 8),
                      child: Image.network(
                        experience.companyLogoUrl!,
                        width: logoSize,
                        height: logoSize,
                        fit: BoxFit.fitWidth,
                        errorBuilder: (c, e, s) => CircleAvatar(
                          backgroundColor: theme.colorScheme.primaryContainer,
                          radius: avatarRadius,
                          child: Icon(
                            Icons.business,
                            color: theme.colorScheme.onPrimaryContainer,
                            size: isMobile ? 17 : 22,
                          ),
                        ),
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.business,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: isMobile ? 17 : 22,
                      ),
                    ),
                  SizedBox(width: headerSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experience.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                            letterSpacing: -0.2,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: isMobile ? 0.5 : 1),
                        GestureDetector(
                          onTap: () =>
                              _launchWebsite(experience.companyProfileUrl),
                          child: Text(
                            experience.company,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              fontSize: companyFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: isMobile ? 5 : 9),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 7 : 11,
                      vertical: isMobile ? 2 : 3,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer.withValues(
                        alpha: isDark ? 0.3 : 0.7,
                      ),
                      borderRadius: BorderRadius.circular(isMobile ? 8 : 15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: isMobile ? 10 : 13,
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                        SizedBox(width: isMobile ? 2.5 : 4),
                        Text(
                          experience.location,
                          style: TextStyle(
                            color: theme.colorScheme.onSecondaryContainer,
                            fontSize: locationFontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: isMobile ? 6 : 8),

              /// Duration
              Text(
                experience.duration,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: isDark ? 0.7 : 0.6,
                  ),
                  fontSize: durationFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: isMobile ? 7 : 10),

              Divider(
                height: dividerHeight,
                thickness: dividerThick,
                color: theme.dividerColor.withValues(
                  alpha: isDark ? 0.4 : 0.23,
                ),
              ),

              /// Highlights
              ...experience.highlights.asMap().entries.map((entry) {
                final i = entry.key;
                final highlight = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: highlightSpacing),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "•",
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w900,
                          fontSize: highlightBulletSize,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: isMobile ? 5 : 9),
                      Expanded(
                        child: Text(
                          highlight.trim(),
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: highlightFontSize,
                            fontWeight: i == 0
                                ? FontWeight.bold
                                : FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              if (experience.highlights.isNotEmpty)
                SizedBox(height: isMobile ? 8 : 11),

              /// Tech stack chips
              Wrap(
                spacing: wrapSpacing,
                runSpacing: wrapRunSpacing,
                children: experience.techStack
                    .map(
                      (tech) => Chip(
                        label: Text(
                          tech,
                          style: TextStyle(
                            fontSize: chipFontSize,
                            color: theme.colorScheme.onTertiaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        avatar: Icon(
                          Icons.code,
                          size: chipIconSize,
                          color: theme.colorScheme.onTertiaryContainer,
                        ),
                        backgroundColor: theme.colorScheme.tertiaryContainer,
                        side: BorderSide(
                          color: theme.colorScheme.outline.withValues(
                            alpha: isDark ? 0.5 : 0.3,
                          ),
                          width: isMobile ? 0.5 : 0.8,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 6 : 8,
                          vertical: 0,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
