import 'package:flutter/material.dart';
import 'package:portfolio_app/core/utils.dart';

import '../core/models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Utils.launch(project.codeUrl),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200, width: 1.3),
        ),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ─── Top Row ───
            Row(
              children: [
                Icon(Icons.folder_open, color: Colors.grey[600], size: 22),
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    project.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    project.isPrivate ?? false ? "Private" : "Public",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10.8,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.more_vert, color: Colors.grey[500], size: 19),
              ],
            ),

            SizedBox(height: 10),

            /// ─── Description ───
            if (project.description != null)
              Expanded(
                child: Text(
                  project.description ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),

            SizedBox(height: 12),

            /// ─── Bottom Row ───
            Row(
              children: [
                if (project.languageColor != null) ...[
                  Icon(Icons.circle, color: project.languageColor, size: 12),
                  SizedBox(width: 7),
                  Text(
                    project.language,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  SizedBox(width: 14),
                ],
                Icon(Icons.star_border, color: Colors.amber[700], size: 15),
                SizedBox(width: 4),
                Text(
                  "${project.stars}",
                  style: TextStyle(color: Colors.grey[700], fontSize: 12.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
