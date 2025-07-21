import 'package:flutter/material.dart';
import 'package:portfolio_app/core/utils.dart';

import '../../../widgets/internship_card_widget.dart';

class InternshipsSectionWidget extends StatelessWidget {
  const InternshipsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      // height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.work, size: 36),
                  SizedBox(width: 16),
                  Text(
                    "Internships",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: -1.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              ListView.separated(
                itemCount: Utils.experiences.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (c, i) => SizedBox(height: 28),
                itemBuilder: (c, i) =>
                    InternshipCard(experience: Utils.experiences[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
