import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';

import '../../../widgets/project_card_widget.dart';

class ProjectSectionWithNote extends StatelessWidget {
  const ProjectSectionWithNote({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = MediaQuery.of(context).size.width < 700;

        final leftNote = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_quote_rounded, size: isMobile ? 32 : 48),
            SizedBox(height: isMobile ? 8 : 18),
            Text(
              Contents.projectSectionDescription,
              style: TextStyle(
                color: Colors.black87,
                fontSize: isMobile ? 13 : 15.5,
                height: 1.4,
              ),
            ),
            SizedBox(height: isMobile ? 10 : 18),
            Text(
              "- Vishnu S Nair",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: isMobile ? 12 : 14.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );

        final projectsHeader = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.dashboard, size: isMobile ? 22 : 36),
            SizedBox(width: isMobile ? 8 : 16),
            Text(
              "Projects",
              style: TextStyle(
                fontSize: isMobile ? 20 : 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: -1.5,
              ),
            ),
          ],
        );

        final projectsGrid = GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: Contents.allProjects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: isMobile ? 14 : 28,
            mainAxisSpacing: isMobile ? 18 : 28,
            childAspectRatio: isMobile ? 1.1 : 2.0,
          ),
          itemBuilder: (context, i) =>
              ProjectCard(project: Contents.allProjects[i]),
        );

        return Container(
          color: Colors.white,
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
                        SizedBox(height: 32),
                        projectsHeader,
                        SizedBox(height: 18),
                        projectsGrid,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT: Personal Note
                        Expanded(flex: 1, child: leftNote),
                        SizedBox(width: 88),
                        // RIGHT: Projects grid
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              projectsHeader,
                              const SizedBox(height: 32),
                              projectsGrid,
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
