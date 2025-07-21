import 'package:flutter/material.dart';

class SkillsSectionWidget extends StatelessWidget {
  const SkillsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Technical Skills',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Container(width: 60, height: 4, color: Colors.blue),
          SizedBox(height: 48),
          Container(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildSkillCategory(
                        'Languages',
                        ['Dart', 'Kotlin', 'Python', 'SQL'],
                        Icons.code,
                        Colors.blue,
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: _buildSkillCategory(
                        'Mobile Development',
                        [
                          'Flutter',
                          'Jetpack Compose',
                          'Android Studio',
                          'Room Database',
                          'Material Design',
                        ],
                        Icons.phone_android,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildSkillCategory(
                        'Backend & APIs',
                        ['Django', 'gRPC', 'REST API', 'Firebase', 'MongoDB'],
                        Icons.storage,
                        Colors.orange,
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: _buildSkillCategory(
                        'Tools & Architecture',
                        [
                          'Git',
                          'Clean Architecture',
                          'MVVM',
                          'Dependency Injection',
                          'Hilt/Dagger',
                        ],
                        Icons.build,
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
    String title,
    List<String> skills,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills
                  .map(
                    (skill) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
