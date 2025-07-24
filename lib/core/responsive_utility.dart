import 'package:flutter/material.dart';

class ResponsiveStyles {
  // Breakpoint for mobile/desktop
  static const double mobileBreakpoint = 700.0;

  // Check if current screen is mobile
  static bool isMobile(double screenWidth) => screenWidth < mobileBreakpoint;
  static bool isTablet(double width) => width >= 700 && width < 1024;

  static bool isDesktop(double width) => width >= 1024;
}

// Common responsive dimensions
class Dimensions {
  // Icon sizes
  static double iconSize(bool isMobile) => isMobile ? 24.0 : 36.0;

  // Padding values
  static double verticalPadding(bool isMobile) => isMobile ? 18.0 : 48.0;
  static double horizontalPadding(bool isMobile) => isMobile ? 14.0 : 0.0;
  static double sectionPadding(bool isMobile) => isMobile ? 24.0 : 56.0;
  static double projectSectionVerticalPadding(bool isMobile) =>
      isMobile ? 20.0 : 64.0;

  static double projectSectionHorizontalPadding(bool isMobile) =>
      isMobile ? 16.0 : 32.0;

  // Spacing values
  static double headerSpacing(bool isMobile) => isMobile ? 8.0 : 16.0;
  static double sectionSpacing(bool isMobile) => isMobile ? 14.0 : 24.0;
  static double cardSpacing(bool isMobile) => isMobile ? 16.0 : 28.0;
  static double smallSpacing(bool isMobile) => isMobile ? 10.0 : 16.0;
  static double mediumSpacing(bool isMobile) => isMobile ? 20.0 : 32.0;
  static double largeSpacing(bool isMobile) => isMobile ? 32.0 : 60.0;
  static double extraLargeSpacing(bool isMobile) => isMobile ? 32.0 : 88.0;

  // Quote-specific sizes
  static double quoteIconSize(bool isMobile) => isMobile ? 32.0 : 48.0;
  static double projectIconSize(bool isMobile) => isMobile ? 22.0 : 36.0;
}

// Typography styles
class TypographyStyles {
  static TextStyle? headlineStyle(BuildContext context, bool isMobile) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return isMobile
        ? textTheme.headlineSmall?.copyWith(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
            color: colorScheme.onSurface,
          )
        : textTheme.headlineMedium?.copyWith(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
            color: colorScheme.onSurface,
          );
  }

  static TextStyle? smallHeadlineStyle(BuildContext context, bool isMobile) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return isMobile
        ? textTheme.headlineSmall?.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
            color: colorScheme.onSurface,
          )
        : textTheme.headlineMedium?.copyWith(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
            color: colorScheme.onSurface,
          );
  }

  static TextStyle? subtitleStyle(BuildContext context, bool isMobile) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return isMobile
        ? textTheme.bodyMedium?.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          )
        : textTheme.titleMedium?.copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          );
  }

  static TextStyle? bodyStyle(BuildContext context, bool isMobile) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return isMobile
        ? textTheme.bodySmall?.copyWith(
            fontSize: 13.0,
            height: 1.4,
            color: colorScheme.onSurface.withValues(alpha: 0.87),
          )
        : textTheme.bodyMedium?.copyWith(
            fontSize: 16.0,
            height: 1.4,
            color: colorScheme.onSurface.withValues(alpha: 0.87),
          );
  }

  static TextStyle? quoteStyle(BuildContext context, bool isMobile) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: isDark ? 0.9 : 0.87),
      fontSize: isMobile ? 13.0 : 15.5,
      height: 1.4,
    );
  }

  static TextStyle? attributionStyle(BuildContext context, bool isMobile) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: isDark ? 0.7 : 0.6),
      fontSize: isMobile ? 12.0 : 14.5,
      fontStyle: FontStyle.italic,
    );
  }
}

// Common widget builders
class WidgetBuilders {
  static Widget sectionHeader({
    required BuildContext context,
    required bool isMobile,
    required IconData icon,
    required String title,
    TextStyle? customStyle,
  }) {
    final theme = Theme.of(context);
    final style =
        customStyle ?? TypographyStyles.headlineStyle(context, isMobile);

    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: Dimensions.iconSize(isMobile),
                color: theme.iconTheme.color,
              ),
              SizedBox(height: Dimensions.headerSpacing(isMobile)),
              Text(title, style: style),
            ],
          )
        : Row(
            children: [
              Icon(
                icon,
                size: Dimensions.iconSize(isMobile),
                color: theme.iconTheme.color,
              ),
              SizedBox(width: Dimensions.headerSpacing(isMobile)),
              Text(title, style: style),
            ],
          );
  }

  static Widget sectionContainer({
    required BuildContext context,
    required bool isMobile,
    required Widget child,
    double maxWidth = 1200.0,
    double? verticalPadding,
    double? horizontalPadding,
  }) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding ?? Dimensions.verticalPadding(isMobile),
        horizontal: horizontalPadding ?? Dimensions.horizontalPadding(isMobile),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }

  static Widget customSectionContainer({
    required BuildContext context,
    required bool isMobile,
    required Widget child,
    double? verticalPadding,
    double? horizontalPadding,
    double? maxWidth,
    Color? backgroundColor,
  }) {
    final theme = Theme.of(context);

    return Container(
      color: backgroundColor ?? theme.colorScheme.surface,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding ?? (isMobile ? 20.0 : 64.0),
        horizontal: horizontalPadding ?? (isMobile ? 16.0 : 32.0),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? (isMobile ? 700.0 : 1200.0),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Creates a quote widget with consistent styling
  // static Widget quoteWidget({
  //   required BuildContext context,
  //   required bool isMobile,
  //   required String quote,
  //   required String attribution,
  //   IconData? quoteIcon,
  //   Color? quoteIconColor,
  // }) {
  //   final theme = Theme.of(context);
  //   final isDark = theme.brightness == Brightness.dark;
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Icon(
  //         quoteIcon ?? Icons.format_quote_rounded,
  //         size: isMobile ? 32.0 : 48.0,
  //         color: quoteIconColor ?? theme.colorScheme.primary,
  //       ),
  //       SizedBox(height: isMobile ? 8.0 : 18.0),
  //       Text(
  //         quote,
  //         style: theme.textTheme.bodyMedium?.copyWith(
  //           color: theme.colorScheme.onSurface.withValues(
  //             alpha: isDark ? 0.9 : 0.87,
  //           ),
  //           fontSize: isMobile ? 13.0 : 15.5,
  //           height: 1.4,
  //         ),
  //       ),
  //       SizedBox(height: isMobile ? 10.0 : 18.0),
  //       Text(
  //         attribution,
  //         style: theme.textTheme.bodyMedium?.copyWith(
  //           color: theme.colorScheme.onSurface.withValues(
  //             alpha: isDark ? 0.7 : 0.6,
  //           ),
  //           fontSize: isMobile ? 12.0 : 14.5,
  //           fontStyle: FontStyle.italic,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
