import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';

import '../core/models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final bool isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 900;

        final double titleSize = isMobile ? 14 : (isTablet ? 16 : 18);
        final double chipTextSize = isMobile ? 9 : (isTablet ? 10 : 11);
        final double descSize = isMobile ? 11 : (isTablet ? 12 : 13);
        final double paddingV = isMobile ? 12 : (isTablet ? 16 : 18);
        final double paddingH = isMobile ? 12 : (isTablet ? 16 : 18);
        final double iconSize = isMobile ? 18 : (isTablet ? 20 : 22);
        final double chipPaddingV = isMobile ? 3.0 : 4.0;
        final double chipPaddingH = isMobile ? 8.0 : 10.0;
        final double statusIconSize = isMobile ? 10 : 12;

        return InkWell(
          onTap: () => Contents.launch(project.codeUrl),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: isDark ? 0.3 : 0.4),
                width: 1.3,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(paddingH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header Row - Properly constrained
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.folder_open,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: isDark ? 0.7 : 0.6,
                        ),
                        size: iconSize,
                      ),
                      const SizedBox(width: 8),

                      /// Flexible title section
                      Expanded(
                        child: Text(
                          project.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                            height: 1.3,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      /// Status chip and menu
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: chipPaddingH,
                              vertical: chipPaddingV,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainer,
                              border: Border.all(
                                color: theme.dividerColor.withValues(
                                  alpha: isDark ? 0.4 : 0.3,
                                ),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              project.isPrivate ?? false ? "Private" : "Public",
                              style: TextStyle(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: isDark ? 0.8 : 0.7,
                                ),
                                fontSize: chipTextSize,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                /// Description - Constrained width
                if (project.description != null &&
                    project.description!.isNotEmpty)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      project.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: isDark ? 0.8 : 0.75,
                        ),
                        fontSize: descSize,
                        height: 1.4,
                        letterSpacing: 0.1,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),

                /// Bottom section - Properly constrained
                SizedBox(
                  width: double.infinity,
                  child: _buildBottomSection(
                    theme: theme,
                    isDark: isDark,
                    isMobile: isMobile,
                    isTablet: isTablet,
                    statusIconSize: statusIconSize,
                    constraints: constraints,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSection({
    required ThemeData theme,
    required bool isDark,
    required bool isMobile,
    required bool isTablet,
    required double statusIconSize,
    required BoxConstraints constraints,
  }) {
    final double fontSize = isMobile ? 10 : (isTablet ? 11 : 12);
    final double iconSize = isMobile ? 12 : 14;

    // Calculate available width for bottom content
    final double availableWidth =
        constraints.maxWidth - (isMobile ? 24 : 36); // Account for padding

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Language section (if exists)
        if (project.languageColor != null)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  color: project.languageColor,
                  size: statusIconSize,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    project.language,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: isDark ? 0.7 : 0.6,
                      ),
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Stars section
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_border,
              color: isDark ? Colors.amber[400] : Colors.amber[600],
              size: iconSize,
            ),
            const SizedBox(width: 4),
            Text(
              "${project.stars}",
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(
                  alpha: isDark ? 0.8 : 0.7,
                ),
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            // Optional arrow indicator
            Icon(
              Icons.arrow_forward_ios,
              size: isMobile ? 10 : 12,
              color: theme.colorScheme.onSurface.withValues(
                alpha: isDark ? 0.4 : 0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Grid Layout Widget for displaying project cards
class ProjectsGrid extends StatelessWidget {
  final List<Project> projects;

  const ProjectsGrid({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;

        if (constraints.maxWidth < 600) {
          // Mobile: 1 column
          crossAxisCount = 1;
          childAspectRatio = 2.0; // Taller cards for mobile
        } else if (constraints.maxWidth < 900) {
          // Tablet: 2 columns
          crossAxisCount = 2;
          childAspectRatio = 1.5;
        } else if (constraints.maxWidth < 1200) {
          // Desktop small: 2-3 columns
          crossAxisCount = 2;
          childAspectRatio = 1.6;
        } else {
          // Desktop large: 3 columns
          crossAxisCount = 3;
          childAspectRatio = 1.4;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ProjectCard(project: projects[index]);
          },
        );
      },
    );
  }
}
