import 'package:flutter/material.dart';

import '../../../core/contents.dart';
import '../../../core/responsive_utility.dart';
import '../../../widgets/education_card_widget.dart';
import '../../../widgets/social_icon_asset_widget.dart';

class AboutSectionWidget extends StatelessWidget {
  const AboutSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = ResponsiveStyles.isMobile(constraints.maxWidth);

        // Main content (about intro)
        Widget aboutTextSection = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Using shared section header widget
            WidgetBuilders.sectionHeader(
              context: context,
              isMobile: isMobile,
              icon: Icons.person,
              title: "Behind the Code",
            ),

            SizedBox(height: Dimensions.sectionSpacing(isMobile)),

            Text(
              "Software Developer | Cross-Platform & Backend Systems",
              style: TypographyStyles.subtitleStyle(context, isMobile),
            ),

            SizedBox(height: Dimensions.smallSpacing(isMobile)),

            Text(
              Contents.aboutMeSectionDescription,
              style: TypographyStyles.bodyStyle(context, isMobile),
            ),

            SizedBox(height: Dimensions.sectionSpacing(isMobile)),

            Row(
              children: [
                SocialIconAsset(
                  assetPath: Contents.githubMarkAssetPath,
                  url: Contents.myGithubUrl,
                  size: isMobile ? 26 : 32,
                ),
                const SizedBox(width: 16),
                SocialIconAsset(
                  assetPath: Contents.linkedInLogoMarkAssetPath,
                  url: Contents.myLinkedInUrl,
                  size: isMobile ? 26 : 32,
                ),
              ],
            ),
          ],
        );

        // Education column as a widget
        Widget educationSection = Column(
          children: [
            const EducationCardWidget(
              university: "JSS Science and Technology University",
              degree: 'Master of Computer Applications (MCA) ',
              institution: 'Sri Jayachamarajendra College of Engineering',
              location: "Mysuru, Karnataka",
              duration: '2023 – 2025',
            ),
            const SizedBox(height: 22),
            const EducationCardWidget(
              university: "University of Mysore (UoM)",
              degree: 'B.Sc. Computer Science',
              institution: "St. Joseph's First Grade College",
              location: "Mysuru, Karnataka",
              duration: '2019 – 2022',
            ),
            const SizedBox(height: 22),
            const EducationCardWidget(
              university: "Central Board of Secondary Education",
              degree: 'HSS, PMCs',
              institution: "Ahalia Public School",
              location: "Palakkad, Kerala",
              duration: '2017 – 2019',
            ),
          ],
        );

        // Using shared container wrapper
        return WidgetBuilders.sectionContainer(
          context: context,
          isMobile: isMobile,
          horizontalPadding: isMobile ? 16.0 : 32,
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    aboutTextSection,
                    SizedBox(height: Dimensions.mediumSpacing(isMobile)),
                    educationSection,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: aboutTextSection),
                    SizedBox(width: Dimensions.largeSpacing(isMobile)),
                    Expanded(flex: 1, child: educationSection),
                  ],
                ),
        );
      },
    );
  }
}
