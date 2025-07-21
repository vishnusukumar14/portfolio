import 'package:flutter/material.dart';
import 'package:portfolio_app/core/utils.dart';

import '../core/models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 400;
        final double titleSize = isMobile ? 15 : 19;
        final double chipTextSize = isMobile ? 9.8 : 10.8;
        final double descSize = isMobile ? 11 : 12;
        final double paddingV = isMobile ? 12 : 18;
        final double paddingH = isMobile ? 10 : 20;
        final double iconSize = isMobile ? 18 : 22;
        final double chipPaddingV = isMobile ? 1.5 : 2.0;
        final double chipPaddingH = isMobile ? 7.0 : 10.0;
        final double statusIconSize = isMobile ? 8 : 12;

        return InkWell(
          onTap: () => Utils.launch(project.codeUrl),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200, width: 1.3),
            ),
            padding: EdgeInsets.fromLTRB(
              paddingH,
              paddingV,
              paddingH,
              paddingV - 2,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Row (can wrap if needed)
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 6,
                  children: [
                    Icon(
                      Icons.folder_open,
                      color: Colors.grey[600],
                      size: iconSize,
                    ),
                    SizedBox(width: 7),
                    SizedBox(
                      width: isMobile ? 110 : 160,
                      child: Text(
                        project.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: chipPaddingH,
                        vertical: chipPaddingV,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        project.isPrivate ?? false ? "Private" : "Public",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: chipTextSize,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.more_vert,
                      color: Colors.grey[500],
                      size: iconSize - 3,
                    ),
                  ],
                ),

                SizedBox(height: isMobile ? 7 : 10),

                /// Description (maxLines for mobile neatness)
                if (project.description != null)
                  Text(
                    project.description ?? "",
                    maxLines: isMobile ? 3 : 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
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
                      SizedBox(width: 7),
                      Text(
                        project.language,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: isMobile ? 11 : 13,
                        ),
                      ),
                      SizedBox(width: 12),
                    ],
                    Icon(
                      Icons.star_border,
                      color: Colors.amber[700],
                      size: isMobile ? 12 : 15,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${project.stars}",
                      style: TextStyle(
                        color: Colors.grey[700],
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
