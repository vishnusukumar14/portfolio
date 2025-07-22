import 'package:flutter/material.dart';

import '../../../core/contents.dart';
import '../../../widgets/education_card_widget.dart';
import '../../../widgets/social_icon_asset_widget.dart';

class AboutSectionWidget extends StatelessWidget {
  const AboutSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;

        // Responsive font sizes based on theme text styles
        final headlineStyle = isMobile
            ? textTheme.headlineSmall?.copyWith(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.5,
                color: colorScheme.onSurface,
              )
            : textTheme.headlineMedium?.copyWith(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.5,
                color: colorScheme.onSurface,
              );

        final subTitleStyle = isMobile
            ? textTheme.bodyMedium?.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              )
            : textTheme.titleMedium?.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              );

        final bodyStyle = isMobile
            ? textTheme.bodySmall?.copyWith(
                fontSize: 13.0,
                height: 1.4,
                color: colorScheme.onSurface.withValues(alpha: 0.87),
              )
            : textTheme.bodyMedium?.copyWith(
                fontSize: 16.0,
                height: 1.4,
                color: colorScheme.onSurface.withValues(alpha: 0.87),
              );

        // Main content (about intro)
        Widget aboutTextSection = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: isMobile ? 24 : 36,
                  color: colorScheme.primary,
                ),
                SizedBox(width: isMobile ? 8 : 16),
                Text("Behind the Code", style: headlineStyle),
              ],
            ),
            SizedBox(height: isMobile ? 14 : 24),
            Text(
              "Flutter Developer (Fresher) | Passionate About Performance, Clean Architecture & Real-Time Apps",
              style: subTitleStyle,
            ),
            SizedBox(height: isMobile ? 10 : 16),
            Text(Contents.aboutMeSectionDescription, style: bodyStyle),

            SizedBox(height: isMobile ? 14 : 24),
            Row(
              children: [
                SocialIconAsset(
                  assetPath: Contents.githubMarkAssetPath,
                  url: Contents.myGithubUrl,
                  size: isMobile ? 26 : 32,
                ),
                SizedBox(width: 16),
                SocialIconAsset(
                  assetPath: Contents.linkedInLogoMarkAssetPath,
                  url: Contents.myLinkedInUrl,
                  size: isMobile ? 26 : 32,
                ),
              ],
            ),
          ],
        );

        // Education column as a widget (so we can move it easily)
        Widget educationSection = Column(
          children: [
            EducationCardWidget(
              university: "JSS Science and Technology University",
              degree: 'MCA, Computer Applications',
              institution: 'Sri Jayachamarajendra College of Engineering',
              location: "Mysuru, Karnataka",
              duration: '2023 – 2025',
            ),
            SizedBox(height: 22),
            EducationCardWidget(
              university: "University of Mysore (UoM)",
              degree: 'B.Sc. Computer Science',
              institution: "St. Joseph's First Grade College",
              location: "Mysuru, Karnataka",
              duration: '2019 – 2022',
            ),
            SizedBox(height: 22),
            EducationCardWidget(
              university: "Central Board of Secondary Education",
              degree: 'HSS, PMCs',
              institution: "Ahalia Public School",
              location: "Palakkad, Kerala",
              duration: '2017 – 2019',
            ),
          ],
        );

        return Container(
          color: colorScheme.surface,
          width: double.infinity,
          height: isMobile ? null : MediaQuery.of(context).size.height,
          // reduce the vertical padding for mobile
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 18 : 48,
            horizontal: isMobile ? 14 : 0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1300),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        aboutTextSection,
                        SizedBox(height: 32),
                        educationSection,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: aboutTextSection),
                        SizedBox(width: 60),
                        Expanded(flex: 1, child: educationSection),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
