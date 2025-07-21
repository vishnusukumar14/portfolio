import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';

import '../../../widgets/project_card_widget.dart';

class ProjectSectionWithNote extends StatelessWidget {
  const ProjectSectionWithNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = MediaQuery.of(context).size.width < 700;

        final leftNote = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.format_quote_rounded,
              size: isMobile ? 32 : 48,
              color: theme.colorScheme.primary,
            ),
            SizedBox(height: isMobile ? 8 : 18),
            Text(
              Contents.projectSectionDescription,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(
                  alpha: isDark ? 0.9 : 0.87,
                ),
                fontSize: isMobile ? 13 : 15.5,
                height: 1.4,
              ),
            ),
            SizedBox(height: isMobile ? 10 : 18),
            Text(
              "- Vishnu S Nair",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(
                  alpha: isDark ? 0.7 : 0.6,
                ),
                fontSize: isMobile ? 12 : 14.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );

        final projectsHeader = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard,
              size: isMobile ? 22 : 36,
              color: theme.iconTheme.color,
            ),
            SizedBox(width: isMobile ? 8 : 16),
            Text(
              "Projects",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: isMobile ? 20 : 36,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
                letterSpacing: -1.5,
              ),
            ),
          ],
        );

        return Container(
          color: theme.colorScheme.surface,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 20 : 64,
            horizontal: isMobile ? 16 : 32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isMobile ? 700 : 1300),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        leftNote,
                        const SizedBox(height: 32),
                        projectsHeader,
                        const SizedBox(height: 18),
                        ResponsiveProjectGrid(projects: Contents.allProjects),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT: Personal Note
                        Expanded(flex: 1, child: leftNote),
                        const SizedBox(width: 88),
                        // RIGHT: Projects grid
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              projectsHeader,
                              const SizedBox(height: 32),
                              ResponsiveProjectGrid(
                                projects: Contents.allProjects,
                              ),
                            ],
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
