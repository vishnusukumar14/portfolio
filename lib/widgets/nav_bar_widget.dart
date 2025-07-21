import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onExperiencePressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onSkillsPressed;
  final VoidCallback onContactPressed;

  const NavBarWidget({
    super.key,
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onExperiencePressed,
    required this.onProjectsPressed,
    required this.onSkillsPressed,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildNavItem('Home', onHomePressed),
        _buildNavItem('About', onAboutPressed),
        _buildNavItem('Internships', onExperiencePressed),
        _buildNavItem('Projects', onProjectsPressed),
        _buildNavItem('Skills', onSkillsPressed),
        _buildNavItem('Contact', onContactPressed),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildNavItem(String title, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
