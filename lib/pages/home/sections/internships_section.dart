import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';

import '../../../widgets/internship_card_widget.dart';

class InternshipsSectionWidget extends StatelessWidget {
  const InternshipsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;
        final double headingSize = isMobile ? 22 : 36;
        final double iconSize = isMobile ? 24 : 36;
        final double verticalPadding = isMobile ? 24 : 56;
        final double headerSpacing = isMobile ? 10 : 16;
        final double cardsSpacing = isMobile ? 16 : 28;

        Widget sectionHeader = isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.work, size: iconSize),
                  SizedBox(height: headerSpacing),
                  Text(
                    "Internships",
                    style: TextStyle(
                      fontSize: headingSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: -1.5,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Icon(Icons.work, size: iconSize),
                  SizedBox(width: headerSpacing),
                  Text(
                    "Internships",
                    style: TextStyle(
                      fontSize: headingSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: -1.5,
                    ),
                  ),
                ],
              );

        return Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: isMobile ? 12 : 0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionHeader,
                  SizedBox(height: isMobile ? 20 : 32),
                  ListView.separated(
                    itemCount: Contents.experiences.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (c, i) => SizedBox(height: cardsSpacing),
                    itemBuilder: (c, i) =>
                        InternshipCard(experience: Contents.experiences[i]),
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
