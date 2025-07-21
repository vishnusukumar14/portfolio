import 'package:flutter/material.dart';

import '../../../widgets/education_card_widget.dart';
import '../../../widgets/social_icon_asset_widget.dart';

class AboutSectionWidget extends StatelessWidget {
  const AboutSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;

        // Responsive font sizes
        final headlineSize = isMobile ? 22.0 : 36.0;
        final subTitleSize = isMobile ? 14.0 : 18.0;
        final bodySize = isMobile ? 13.0 : 16.0;

        // Main content (about intro)
        Widget aboutTextSection = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person, size: isMobile ? 24 : 36),
                SizedBox(width: isMobile ? 8 : 16),
                Text(
                  "Behind the Code",
                  style: TextStyle(
                    fontSize: headlineSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: -1.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 14 : 24),
            Text(
              "Flutter Developer (Fresher) | Passionate About Performance, Clean Architecture & Real-Time Apps",
              style: TextStyle(
                color: Color(0xFF4D0202),
                fontWeight: FontWeight.bold,
                fontSize: subTitleSize,
              ),
            ),
            SizedBox(height: isMobile ? 10 : 16),
            Text(
              """I'm an enthusiastic Flutter developer with a strong interest in building smooth, scalable, and user-friendly cross-platform applications. During my academic projects and internship experience, I’ve worked with Flutter & Dart, focusing on clean architecture and efficient state management using tools like Riverpod, Bloc, and Provider.

I’ve gained hands-on experience integrating REST APIs, Firebase, and MongoDB, and have built secure login systems and real-time features. I'm also familiar with Android development using Kotlin and Jetpack Compose, and have explored backend development using Python and Django.

I enjoy debugging tough issues, optimizing performance, and crafting polished UI/UX. I’m eager to learn, build, and grow as a Flutter developer in a challenging and collaborative environment.""",
              style: TextStyle(
                fontSize: bodySize,
                color: Colors.black87,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: isMobile ? 14 : 24),
            Row(
              children: [
                SocialIconAsset(
                  assetPath: 'assets/logos/github_mark.png',
                  url: 'https://github.com/vishnusukumar14',
                  size: isMobile ? 26 : 32,
                ),
                SizedBox(width: 16),
                SocialIconAsset(
                  assetPath: 'assets/logos/li_bug_mark.png',
                  url: "https://www.linkedin.com/in/vishnus14/",
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
          color: Colors.white,
          width: double.infinity,
          // reduce the vertical padding for mobile
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 18 : 48,
            horizontal: isMobile ? 14 : 0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
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
