import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';

import '../../../core/responsive_utility.dart';
import '../../../widgets/internship_card_widget.dart';

class InternshipsSectionWidget extends StatelessWidget {
  const InternshipsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = ResponsiveStyles.isMobile(constraints.maxWidth);

        // Using shared container wrapper with custom padding for internships section
        return WidgetBuilders.sectionContainer(
          context: context,
          isMobile: isMobile,
          verticalPadding: Dimensions.sectionPadding(isMobile),
          horizontalPadding: isMobile ? 16.0 : 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Using shared section header widget with smaller headline style
              WidgetBuilders.sectionHeader(
                context: context,
                isMobile: isMobile,
                icon: Icons.work,
                title: "Experience",
                customStyle: TypographyStyles.smallHeadlineStyle(
                  context,
                  isMobile,
                ),
              ),

              SizedBox(height: Dimensions.mediumSpacing(isMobile)),

              ListView.separated(
                itemCount: Contents.experiences.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (c, i) =>
                    SizedBox(height: Dimensions.cardSpacing(isMobile)),
                itemBuilder: (c, i) => InternshipCard(
                  experience: Contents.experiences[i],
                  isMobile: isMobile,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
