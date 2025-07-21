import 'package:flutter/material.dart';

class HeroSectionWidget extends StatelessWidget {
  final VoidCallback onGetInTouchPressed;
  final VoidCallback onBrowseProjectPressed;

  const HeroSectionWidget({
    super.key,
    required this.onGetInTouchPressed,
    required this.onBrowseProjectPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    // Fully theme-aware colors
    final primaryTextColor = colorScheme.onSurface;
    final secondaryTextColor = colorScheme.onSurface.withValues(alpha: 0.7);
    final accentColor = colorScheme.primary;
    final backgroundColor = colorScheme.surface;

    // Profile image styling with theme awareness
    final profileBgColor = isDark
        ? colorScheme.surfaceContainerHighest
        : colorScheme.primaryContainer;
    final profileBorderColor = colorScheme.outline.withValues(alpha: 0.3);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;
        final double headlineSize = isMobile ? 34 : 64;
        final double subHeadSize = isMobile ? 14 : 22;
        final double bodySize = isMobile ? 13 : 18;
        final double profileImgSize = isMobile ? 120 : 280;

        Widget profileImage = Center(
          child: Container(
            width: profileImgSize,
            height: profileImgSize,
            decoration: BoxDecoration(
              color: profileBgColor,
              shape: BoxShape.circle,
              border: Border.all(color: profileBorderColor, width: 1.0),
              // Add subtle shadow for depth, respecting theme
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(
                    alpha: isDark ? 0.2 : 0.1,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/1746809048028.jpeg',
                fit: BoxFit.cover, // Better fit for profile images
                errorBuilder: (context, error, stackTrace) {
                  // Fallback with theme-aware placeholder
                  return Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.person,
                      size: profileImgSize * 0.5,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
          ),
        );

        Widget textContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hey, I'm Vishnu 👋",
              style: textTheme.titleMedium?.copyWith(
                fontSize: subHeadSize,
                fontWeight: FontWeight.w400,
                color: primaryTextColor,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Software",
                    style: textTheme.displaySmall?.copyWith(
                      fontFamily: 'Bitcount Prop Single',
                      fontSize: headlineSize,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                      letterSpacing: isMobile ? 0 : -2,
                      height: 1.1,
                    ),
                  ),
                  TextSpan(
                    text: "\nDev",
                    style: textTheme.displaySmall?.copyWith(
                      fontFamily: 'Bitcount Prop Single',
                      fontSize: headlineSize,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      letterSpacing: isMobile ? 0 : -2,
                      height: 1.1,
                    ),
                  ),
                  TextSpan(
                    text: "eloper",
                    style: textTheme.displaySmall?.copyWith(
                      fontFamily: 'Bitcount Prop Single',
                      fontSize: headlineSize,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                      letterSpacing: isMobile ? 0 : -2,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isMobile ? 14 : 24),
            Text(
              "I love building apps that are fast, clean, and a joy to use—whether in Flutter or native Android—with a strong focus on smooth user experience and scalable architecture",
              style: textTheme.bodyLarge?.copyWith(
                fontSize: bodySize,
                color: secondaryTextColor,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: isMobile ? 18 : 32),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: onGetInTouchPressed,
                  style:
                      ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        disabledBackgroundColor: colorScheme.onSurface
                            .withValues(alpha: 0.12),
                        disabledForegroundColor: colorScheme.onSurface
                            .withValues(alpha: 0.38),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 18 : 28,
                          vertical: isMobile ? 13 : 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: isDark ? 1 : 2,
                        shadowColor: colorScheme.shadow,
                      ).copyWith(
                        // Add hover and focus effects that respect theme
                        overlayColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.hovered)) {
                            return colorScheme.onPrimary.withValues(
                              alpha: 0.08,
                            );
                          }
                          if (states.contains(WidgetState.focused)) {
                            return colorScheme.onPrimary.withValues(
                              alpha: 0.12,
                            );
                          }
                          if (states.contains(WidgetState.pressed)) {
                            return colorScheme.onPrimary.withValues(
                              alpha: 0.12,
                            );
                          }
                          return null;
                        }),
                      ),
                  child: Text(
                    'Get In Touch',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onBrowseProjectPressed,
                  style:
                      OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: colorScheme.outline,
                          width: 1.0,
                        ),
                        foregroundColor: colorScheme.onSurface,
                        disabledForegroundColor: colorScheme.onSurface
                            .withValues(alpha: 0.38),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 14 : 24,
                          vertical: isMobile ? 13 : 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ).copyWith(
                        // Theme-aware hover and focus effects
                        overlayColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.hovered)) {
                            return colorScheme.onSurface.withValues(
                              alpha: 0.04,
                            );
                          }
                          if (states.contains(WidgetState.focused)) {
                            return colorScheme.onSurface.withValues(
                              alpha: 0.12,
                            );
                          }
                          if (states.contains(WidgetState.pressed)) {
                            return colorScheme.onSurface.withValues(
                              alpha: 0.12,
                            );
                          }
                          return null;
                        }),
                        side: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.focused)) {
                            return BorderSide(
                              color: colorScheme.primary,
                              width: 2.0,
                            );
                          }
                          if (states.contains(WidgetState.hovered)) {
                            return BorderSide(
                              color: colorScheme.onSurface,
                              width: 1.0,
                            );
                          }
                          return BorderSide(
                            color: colorScheme.outline,
                            width: 1.0,
                          );
                        }),
                      ),
                  child: Text(
                    'Browse Projects',
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: isMobile ? 14 : 16,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );

        return Container(
          color: backgroundColor,
          width: double.infinity,
          height: isMobile ? null : MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 20 : 64,
            horizontal: isMobile ? 16 : 32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isMobile ? 700 : 1300),
              child: isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profileImage,
                        SizedBox(height: 18),
                        textContent,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 2, child: textContent),
                        Expanded(flex: 1, child: profileImage),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
