import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';
import 'package:portfolio_app/core/util.dart';
import '../core/models/project.dart';

class ResponsiveProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onTap;

  const ResponsiveProjectCard({super.key, required this.project, this.onTap});

  @override
  State<ResponsiveProjectCard> createState() => _ResponsiveProjectCardState();
}

class _ResponsiveProjectCardState extends State<ResponsiveProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _shadowAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsiveConfig = _getResponsiveConfig(constraints.maxWidth);

        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: MouseRegion(
                onEnter: (_) => _onHoverChanged(true),
                onExit: (_) => _onHoverChanged(false),
                child: GestureDetector(
                  onTap:
                      widget.onTap ??
                      () => Utils.launch(widget.project.codeUrl),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        responsiveConfig.borderRadius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black.withValues(
                                  alpha: 0.3 * _shadowAnimation.value,
                                )
                              : Colors.black.withValues(
                                  alpha: 0.1 * _shadowAnimation.value,
                                ),
                          blurRadius: 8 * _shadowAnimation.value,
                          offset: Offset(0, 4 * _shadowAnimation.value),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        responsiveConfig.borderRadius,
                      ),
                      child: _buildCard(context, responsiveConfig),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, ResponsiveConfig config) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark
        ? theme.colorScheme.surface
        : theme.colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: isDark ? 0.2 : 0.15),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(config.borderRadius),
        gradient: _isHovered
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  surfaceColor,
                  isDark
                      ? theme.colorScheme.surfaceContainer
                      : theme.colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.3,
                        ),
                ],
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(config.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(theme, isDark, config),
            SizedBox(height: config.spacing),
            _buildDescription(theme, isDark, config),
            const Spacer(),
            _buildFooter(theme, isDark, config),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isDark, ResponsiveConfig config) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(config.iconPadding),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(config.iconBorderRadius),
          ),
          child: Icon(
            _getProjectIcon(),
            size: config.iconSize,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(width: config.spacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.project.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: config.titleSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                  height: 1.2,
                  color: theme.colorScheme.onSurface,
                ),
                maxLines: config.titleMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
              if (config.showSubtitle) ...[
                const SizedBox(height: 2),
                _buildStatusChip(theme, isDark, config),
              ],
            ],
          ),
        ),
        if (!config.showSubtitle) _buildStatusChip(theme, isDark, config),
      ],
    );
  }

  Widget _buildStatusChip(
    ThemeData theme,
    bool isDark,
    ResponsiveConfig config,
  ) {
    final isPrivate = widget.project.isPrivate ?? false;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: config.chipPadding,
        vertical: config.chipPadding * 0.6,
      ),
      decoration: BoxDecoration(
        color: isPrivate
            ? theme.colorScheme.errorContainer.withValues(alpha: 0.8)
            : theme.colorScheme.primaryContainer.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(config.chipBorderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPrivate ? Icons.lock : Icons.public,
            size: config.chipIconSize,
            color: isPrivate
                ? theme.colorScheme.onErrorContainer
                : theme.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            isPrivate ? "Private" : "Public",
            style: TextStyle(
              fontSize: config.chipTextSize,
              fontWeight: FontWeight.w600,
              color: isPrivate
                  ? theme.colorScheme.onErrorContainer
                  : theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(
    ThemeData theme,
    bool isDark,
    ResponsiveConfig config,
  ) {
    if (widget.project.description == null ||
        widget.project.description!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      widget.project.description!,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontSize: config.descriptionSize,
        height: 1.4,
        color: theme.colorScheme.onSurface.withValues(
          alpha: isDark ? 0.8 : 0.7,
        ),
        letterSpacing: 0.1,
      ),
      maxLines: config.descriptionMaxLines,
      overflow: TextOverflow.fade,
    );
  }

  Widget _buildFooter(ThemeData theme, bool isDark, ResponsiveConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.project.languageColor != null) ...[
          Row(
            children: [
              Container(
                width: config.languageDotSize,
                height: config.languageDotSize,
                decoration: BoxDecoration(
                  color: widget.project.languageColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.project.language,
                  style: TextStyle(
                    fontSize: config.metadataSize,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withValues(
                      alpha: isDark ? 0.7 : 0.6,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: config.spacing * 0.5),
        ],
        Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              size: config.metadataIconSize,
              color: Colors.amber[600],
            ),
            const SizedBox(width: 4),
            Text(
              "${widget.project.stars}",
              style: TextStyle(
                fontSize: config.metadataSize,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withValues(
                  alpha: isDark ? 0.8 : 0.7,
                ),
              ),
            ),
            const Spacer(),
            if (_isHovered)
              Icon(
                Icons.launch_rounded,
                size: config.metadataIconSize,
                color: theme.colorScheme.primary.withValues(alpha: 0.8),
              ),
          ],
        ),
      ],
    );
  }

  IconData _getProjectIcon() {
    final lang = widget.project.language.toLowerCase();
    switch (lang) {
      case 'dart':
      case 'flutter':
        return Icons.phone_android;
      case 'javascript':
      case 'typescript':
        return Icons.code;
      case 'python':
        return Icons.smart_toy;
      case 'java':
        return Icons.coffee;
      case 'swift':
        return Icons.phone_iphone;
      case 'kotlin':
        return Icons.android;
      default:
        return Icons.folder_open_rounded;
    }
  }

  ResponsiveConfig _getResponsiveConfig(double width) {
    if (width < 480) {
      // Mobile
      return ResponsiveConfig(
        padding: 12.0,
        spacing: 8.0,
        borderRadius: 12.0,
        iconSize: 20.0,
        iconPadding: 8.0,
        iconBorderRadius: 8.0,
        titleSize: 14.0,
        titleMaxLines: 2,
        descriptionSize: 12.0,
        descriptionMaxLines: 8,
        metadataSize: 10.0,
        metadataIconSize: 12.0,
        chipTextSize: 9.0,
        chipIconSize: 10.0,
        chipPadding: 6.0,
        chipBorderRadius: 6.0,
        languageDotSize: 8.0,
        showSubtitle: true,
      );
    } else if (width < 768) {
      // Tablet
      return ResponsiveConfig(
        padding: 16.0,
        spacing: 12.0,
        borderRadius: 16.0,
        iconSize: 24.0,
        iconPadding: 10.0,
        iconBorderRadius: 10.0,
        titleSize: 16.0,
        titleMaxLines: 2,
        descriptionSize: 13.0,
        descriptionMaxLines: 8,
        metadataSize: 11.0,
        metadataIconSize: 14.0,
        chipTextSize: 10.0,
        chipIconSize: 11.0,
        chipPadding: 8.0,
        chipBorderRadius: 8.0,
        languageDotSize: 10.0,
        showSubtitle: false,
      );
    } else {
      // Desktop
      return ResponsiveConfig(
        padding: 20.0,
        spacing: 16.0,
        borderRadius: 20.0,
        iconSize: 28.0,
        iconPadding: 12.0,
        iconBorderRadius: 12.0,
        titleSize: 18.0,
        titleMaxLines: 2,
        descriptionSize: 14.0,
        descriptionMaxLines: 5,
        metadataSize: 12.0,
        metadataIconSize: 16.0,
        chipTextSize: 11.0,
        chipIconSize: 12.0,
        chipPadding: 10.0,
        chipBorderRadius: 10.0,
        languageDotSize: 12.0,
        showSubtitle: false,
      );
    }
  }
}

class ResponsiveConfig {
  final double padding;
  final double spacing;
  final double borderRadius;
  final double iconSize;
  final double iconPadding;
  final double iconBorderRadius;
  final double titleSize;
  final int titleMaxLines;
  final double descriptionSize;
  final int descriptionMaxLines;
  final double metadataSize;
  final double metadataIconSize;
  final double chipTextSize;
  final double chipIconSize;
  final double chipPadding;
  final double chipBorderRadius;
  final double languageDotSize;
  final bool showSubtitle;

  const ResponsiveConfig({
    required this.padding,
    required this.spacing,
    required this.borderRadius,
    required this.iconSize,
    required this.iconPadding,
    required this.iconBorderRadius,
    required this.titleSize,
    required this.titleMaxLines,
    required this.descriptionSize,
    required this.descriptionMaxLines,
    required this.metadataSize,
    required this.metadataIconSize,
    required this.chipTextSize,
    required this.chipIconSize,
    required this.chipPadding,
    required this.chipBorderRadius,
    required this.languageDotSize,
    required this.showSubtitle,
  });
}

// Grid Layout Helper Widget
class ResponsiveProjectGrid extends StatelessWidget {
  final List<Project> projects;
  final EdgeInsets? padding;
  final double? spacing;

  const ResponsiveProjectGrid({
    super.key,
    required this.projects,
    this.padding,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final config = _getGridConfig(constraints.maxWidth);

        return Padding(
          padding: padding ?? EdgeInsets.all(config.padding),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: config.crossAxisCount,
              crossAxisSpacing: spacing ?? config.spacing,
              mainAxisSpacing: spacing ?? config.spacing,
              childAspectRatio: config.aspectRatio,
            ),
            itemCount: projects.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ResponsiveProjectCard(project: projects[index]);
            },
          ),
        );
      },
    );
  }

  GridConfig _getGridConfig(double width) {
    if (width < 480) {
      // Mobile: 1 column
      return const GridConfig(
        crossAxisCount: 1,
        aspectRatio: 1.2,
        spacing: 12.0,
        padding: 16.0,
      );
    } else if (width < 768) {
      // Tablet: 2 columns
      return const GridConfig(
        crossAxisCount: 2,
        aspectRatio: 1.0,
        spacing: 16.0,
        padding: 20.0,
      );
    } else if (width < 1200) {
      // Small Desktop: 3 columns
      return const GridConfig(
        crossAxisCount: 3,
        aspectRatio: 0.9,
        spacing: 20.0,
        padding: 24.0,
      );
    } else {
      // Large Desktop: 4 columns
      return const GridConfig(
        crossAxisCount: 4,
        aspectRatio: 0.85,
        spacing: 24.0,
        padding: 32.0,
      );
    }
  }
}

class GridConfig {
  final int crossAxisCount;
  final double aspectRatio;
  final double spacing;
  final double padding;

  const GridConfig({
    required this.crossAxisCount,
    required this.aspectRatio,
    required this.spacing,
    required this.padding,
  });
}
