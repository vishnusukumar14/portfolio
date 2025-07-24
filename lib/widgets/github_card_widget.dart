import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';
import 'package:portfolio_app/core/util.dart';

class GitHubCardWidget extends StatelessWidget {
  final bool? isMobile;

  const GitHubCardWidget({super.key, this.isMobile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isResponsiveMobile =
        isMobile ?? MediaQuery.of(context).size.width < 768;

    final double contentPadding = isResponsiveMobile ? 16.0 : 20.0;

    return InkWell(
      onTap: () {
        Utils.launch(Contents.myGithubUrl);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0D1117) : theme.cardColor,
          borderRadius: BorderRadius.circular(isResponsiveMobile ? 8 : 12),
          border: Border.all(
            color: isDark ? const Color(0xFF30363D) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Focusing
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
              child: Row(
                children: [
                  Icon(
                    Icons.golf_course_rounded,
                    // color: theme.primaryColor,
                    size: 12,
                  ),
                  const SizedBox(width: 6),
                  const Text("Focusing", style: TextStyle(fontSize: 11)),
                ],
              ),
            ),

            Divider(
              color: theme.primaryColor.withValues(alpha: 0.4),
              thickness: 0.5,
              height: 1,
            ),

            Padding(
              padding: EdgeInsets.all(contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: isResponsiveMobile ? 20.0 : 28.0,
                        backgroundImage: const AssetImage(
                          'assets/images/spiderman.jpg',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'vishnusukumar14',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: isResponsiveMobile ? 16 : 18,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'vishnu s · he/him',
                              style: TextStyle(
                                fontSize: isResponsiveMobile ? 12 : 14,
                                color: isDark
                                    ? const Color(0xFF8B949E)
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    'Flutter | Android Native | Dart | Kotlin | Python | gRpc | GO | MongoDB | Firebase Firestore | Tech Enthusiast',
                    style: TextStyle(
                      fontSize: isResponsiveMobile ? 11 : 12,
                      color: isDark
                          ? const Color(0xFF8B949E)
                          : Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 18),

                  _infoRow(
                    icon: Icons.location_on_outlined,
                    text: 'India',
                    isDark: isDark,
                    isResponsiveMobile: isResponsiveMobile,
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    icon: Icons.people,
                    text: '1 Followers • 0 Following',
                    isDark: isDark,
                    isResponsiveMobile: isResponsiveMobile,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String text,
    required bool isDark,
    required bool isResponsiveMobile,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: isResponsiveMobile ? 14 : 16,
          color: isDark ? const Color(0xFF8B949E) : Colors.grey.shade600,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: isResponsiveMobile ? 12 : 14,
            color: isDark ? const Color(0xFF8B949E) : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
