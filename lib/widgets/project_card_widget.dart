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
        final bool isMobile = constraints.maxWidth < 700;
        final double titleSize = isMobile ? 15 : 19;
        final double chipTextSize = isMobile ? 9.8 : 10.8;
        final double descSize = isMobile ? 11 : 12;
        final double paddingV = isMobile ? 10 : 12;
        final double paddingH = isMobile ? 10 : 20;
        final double iconSize = isMobile ? 18 : 22;
        final double chipPaddingV = isMobile ? 1.5 : 2.0;
        final double chipPaddingH = isMobile ? 7.0 : 10.0;
        final double statusIconSize = isMobile ? 8 : 12;

        return InkWell(
          onTap: () => Contents.launch(project.codeUrl),
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
                      : Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),

            padding: EdgeInsets.fromLTRB(
              paddingH,
              paddingV,
              paddingH,
              paddingV - 2,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Row (can wrap if needed)
                // Wrap(
                //   crossAxisAlignment: WrapCrossAlignment.center,
                //   runSpacing: 6,
                //   children: [
                //     Icon(
                //       Icons.folder_open,
                //       color: theme.colorScheme.onSurface.withValues(
                //         alpha: isDark ? 0.7 : 0.6,
                //       ),
                //       size: iconSize,
                //     ),
                //     const SizedBox(width: 7),
                //     SizedBox(
                //       width: isMobile ? 110 : 160,
                //       child: Text(
                //         project.name,
                //         overflow: TextOverflow.ellipsis,
                //         style: theme.textTheme.titleMedium?.copyWith(
                //           color: theme.colorScheme.onSurface,
                //           fontSize: titleSize,
                //           fontWeight: FontWeight.bold,
                //           letterSpacing: -0.5,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 4),
                //     Spacer(),
                //     Container(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: chipPaddingH,
                //         vertical: chipPaddingV,
                //       ),
                //       decoration: BoxDecoration(
                //         color: theme.colorScheme.surfaceContainer,
                //         border: Border.all(
                //           color: theme.dividerColor.withValues(
                //             alpha: isDark ? 0.4 : 0.3,
                //           ),
                //         ),
                //         borderRadius: BorderRadius.circular(25),
                //       ),
                //       child: Text(
                //         project.isPrivate ?? false ? "Private" : "Public",
                //         style: TextStyle(
                //           color: theme.colorScheme.onSurface.withValues(
                //             alpha: isDark ? 0.8 : 0.7,
                //           ),
                //           fontSize: chipTextSize,
                //           overflow: TextOverflow.ellipsis,
                //           fontWeight: FontWeight.w600,
                //           letterSpacing: 0.15,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 5),
                //     Icon(
                //       Icons.more_vert,
                //       color: theme.colorScheme.onSurface.withValues(
                //         alpha: isDark ? 0.6 : 0.5,
                //       ),
                //       size: iconSize - 3,
                //     ),
                //   ],
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: isDark ? 0.7 : 0.6,
                      ),
                      size: iconSize,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      project.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(), // Pushes remaining items to end
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
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        project.isPrivate ?? false ? "Private" : "Public",
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: isDark ? 0.8 : 0.7,
                          ),
                          fontSize: chipTextSize,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.more_vert,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: isDark ? 0.6 : 0.5,
                      ),
                      size: iconSize - 3,
                    ),
                  ],
                ),

                SizedBox(height: isMobile ? 7 : 10),

                /// Description - Shows full text without overflow
                if (project.description != null &&
                    project.description!.isNotEmpty)
                  Text(
                    project.description!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: descSize,
                      height: 1.45,
                    ),
                  ),

                SizedBox(height: isMobile ? 8 : 12),

                /// Bottom Row (can wrap if needed)
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 6,
                  children: [
                    if (project.languageColor != null) ...[
                      Icon(
                        Icons.circle,
                        color: project.languageColor,
                        size: statusIconSize,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        project.language,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: isDark ? 0.7 : 0.6,
                          ),
                          fontSize: isMobile ? 11 : 13,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Icon(
                      Icons.star_border,
                      color: isDark ? Colors.amber[400] : Colors.amber[700],
                      size: isMobile ? 12 : 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${project.stars}",
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: isDark ? 0.8 : 0.7,
                        ),
                        fontSize: isMobile ? 11 : 12.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
