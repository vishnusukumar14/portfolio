import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';

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

    // Enhanced theme-aware colors with better contrast
    final primaryTextColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark
        ? Colors.white70
        : Colors.black87.withValues(alpha: 0.6);
    final accentColor = colorScheme.primary;
    final backgroundColor = isDark ? colorScheme.surface : Colors.white;

    // Profile image styling with enhanced contrast
    final profileBgColor = isDark
        ? colorScheme.surfaceContainerHighest
        : Colors.grey[100];
    final profileBorderColor = isDark ? Colors.white24 : Colors.grey[300];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;
        final bool isTablet =
            constraints.maxWidth >= 700 && constraints.maxWidth < 1024;
        final screenHeight = MediaQuery.of(context).size.height;
        final availableHeight =
            screenHeight -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom;

        // Responsive sizing with overflow prevention
        final double headlineSize = isMobile
            ? 24
            : isTablet
            ? 32
            : 42;
        final double subHeadSize = isMobile
            ? 13
            : isTablet
            ? 16
            : 18;
        final double bodySize = isMobile
            ? 12
            : isTablet
            ? 14
            : 15;
        final double profileImgSize = isMobile
            ? 120
            : isTablet
            ? 160
            : 200;

        Widget profileImage = Container(
          width: profileImgSize,
          height: profileImgSize,
          decoration: BoxDecoration(
            color: profileBgColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: profileBorderColor ?? Colors.grey[300]!,
              width: 2.0,
            ),
            // Enhanced shadow for better depth
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black26
                    : Colors.grey.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              Contents.myProfilePhotoAssetPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: profileBgColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.blueAccent.withValues(
                                alpha: 0.5,
                              ), // subtle glow
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    size: profileImgSize * 0.5,
                    color: isDark ? Colors.white54 : Colors.grey[600],
                  ),
                );
              },
            ),
          ),
        );

        Widget textContent = Column(
          crossAxisAlignment: isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Hey, I'm Vishnu 👋",
              style: textTheme.titleMedium?.copyWith(
                fontSize: subHeadSize,
                fontWeight: FontWeight.w500,
                color: primaryTextColor,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: isMobile ? 6 : 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Software",
                      style: textTheme.displaySmall?.copyWith(
                        fontFamily: 'Bitcount Prop Single',
                        fontSize: headlineSize,
                        fontWeight: FontWeight.w600,
                        color: primaryTextColor,
                        letterSpacing: isMobile ? -0.5 : -1,
                        height: 1.1,
                      ),
                    ),
                    TextSpan(
                      text: "\nDev",
                      style: textTheme.displayMedium?.copyWith(
                        fontFamily: 'Bitcount Prop Single',
                        fontSize: headlineSize,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                        letterSpacing: isMobile ? -0.5 : -1,
                        height: 1.1,
                      ),
                    ),
                    TextSpan(
                      text: "eloper",
                      style: textTheme.displayMedium?.copyWith(
                        fontFamily: 'Bitcount Prop Single',
                        fontSize: headlineSize,
                        fontWeight: FontWeight.w600,
                        color: primaryTextColor,
                        letterSpacing: isMobile ? -0.5 : -1,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
                child: Text(
                  Contents.heroSectionDescription,
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: bodySize,
                    color: secondaryTextColor,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  // Removed maxLines and overflow to show full text
                ),
              ),
            ),
            SizedBox(height: isMobile ? 16 : 20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 400,
              ),
              child: Wrap(
                alignment: isMobile
                    ? WrapAlignment.center
                    : WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: [
                  SizedBox(
                    width: isMobile ? 140 : 150,
                    child: ElevatedButton(
                      onPressed: onGetInTouchPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        disabledBackgroundColor: Colors.grey[400],
                        disabledForegroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: isMobile ? 12 : 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                        shadowColor: Colors.black26,
                      ),
                      child: FittedBox(
                        child: Text(
                          'Get In Touch',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 14 : 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isMobile ? 140 : 150,
                    child: OutlinedButton(
                      onPressed: onBrowseProjectPressed,
                      style:
                          OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isDark
                                  ? Colors.white38
                                  : Colors.grey[400]!,
                              width: 1.5,
                            ),
                            foregroundColor: primaryTextColor,
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: isMobile ? 12 : 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ).copyWith(
                            overlayColor: WidgetStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(WidgetState.hovered)) {
                                return primaryTextColor.withValues(alpha: 0.05);
                              }
                              if (states.contains(WidgetState.pressed)) {
                                return primaryTextColor.withValues(alpha: 0.1);
                              }
                              return null;
                            }),
                            side: WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.focused) ||
                                  states.contains(WidgetState.hovered)) {
                                return BorderSide(
                                  color: colorScheme.primary,
                                  width: 2.0,
                                );
                              }
                              return BorderSide(
                                color: isDark
                                    ? Colors.white38
                                    : Colors.grey[400]!,
                                width: 1.5,
                              );
                            }),
                          ),
                      child: FittedBox(
                        child: Text(
                          'Browse Projects',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 14 : 15,
                            color: primaryTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        return Container(
          color: backgroundColor,
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 56,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 16 : 24,
            horizontal: isMobile ? 16 : 24,
          ),
          child: Center(
            child: isMobile
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      minHeight: MediaQuery.of(context).size.height - 56,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profileImage,
                        const SizedBox(height: 16),
                        // const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: textContent,
                        ),
                      ],
                    ),
                  )
                : ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: textContent),
                        const SizedBox(width: 24),
                        Flexible(
                          child: Container(
                            alignment: Alignment.center,
                            child: profileImage,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
