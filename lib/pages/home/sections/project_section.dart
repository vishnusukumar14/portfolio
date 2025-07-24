import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';

import '../../../core/responsive_utility.dart';
import '../../../widgets/github_card_widget.dart';
import '../../../widgets/project_card_widget.dart';

class ProjectSectionWithNote extends StatelessWidget {
  const ProjectSectionWithNote({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = ResponsiveStyles.isMobile(constraints.maxWidth);

        // Projects header using custom icon size
        final projectsHeader = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard,
              size: Dimensions.projectIconSize(isMobile),
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(width: Dimensions.headerSpacing(isMobile)),
            Text(
              "Projects",
              style: TypographyStyles.smallHeadlineStyle(context, isMobile),
            ),
          ],
        );

        // Using custom section container with project-specific padding
        return WidgetBuilders.customSectionContainer(
          context: context,
          isMobile: isMobile,
          verticalPadding: Dimensions.projectSectionVerticalPadding(isMobile),
          horizontalPadding: Dimensions.projectSectionHorizontalPadding(
            isMobile,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GitHubCardWidget(isMobile: isMobile),
                    SizedBox(height: Dimensions.mediumSpacing(isMobile)),
                    projectsHeader,
                    const SizedBox(height: 18),
                    ResponsiveProjectGrid(projects: Contents.allProjects),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT: Personal Note + GitHub Card
                    Expanded(
                      flex: 1,
                      child: GitHubCardWidget(isMobile: isMobile),
                    ),
                    SizedBox(width: Dimensions.extraLargeSpacing(isMobile)),
                    // RIGHT: Projects grid
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          projectsHeader,
                          SizedBox(height: Dimensions.mediumSpacing(isMobile)),
                          ResponsiveProjectGrid(projects: Contents.allProjects),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
