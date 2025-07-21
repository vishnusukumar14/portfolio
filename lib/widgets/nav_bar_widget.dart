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
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = MediaQuery.of(context).size.width < 700;
        if (isMobile) {
          // On mobile, show a hamburger icon that opens a drawer
          return Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  // Rounded TopCorners
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (context) => _MobileNavSheet(
                    onHomePressed: () {
                      Navigator.pop(context);
                      onHomePressed();
                    },
                    onAboutPressed: () {
                      Navigator.pop(context);
                      onAboutPressed();
                    },
                    onExperiencePressed: () {
                      Navigator.pop(context);
                      onExperiencePressed();
                    },
                    onProjectsPressed: () {
                      Navigator.pop(context);
                      onProjectsPressed();
                    },
                    onSkillsPressed: () {
                      Navigator.pop(context);
                      onSkillsPressed();
                    },
                    onContactPressed: () {
                      Navigator.pop(context);
                      onContactPressed();
                    },
                  ),
                ),
              );
            },
          );
        } else {
          // On larger screens, show as a Row of buttons as before
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
      },
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
            color: Colors.grey.shade200,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// This widget is used for the mobile nav sheet
class _MobileNavSheet extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onExperiencePressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onSkillsPressed;
  final VoidCallback onContactPressed;

  const _MobileNavSheet({
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
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: onHomePressed,
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('About'),
            onTap: onAboutPressed,
          ),
          ListTile(
            leading: Icon(Icons.work_outline),
            title: Text('Internships'),
            onTap: onExperiencePressed,
          ),
          ListTile(
            leading: Icon(Icons.folder_open),
            title: Text('Projects'),
            onTap: onProjectsPressed,
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Skills'),
            onTap: onSkillsPressed,
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact'),
            onTap: onContactPressed,
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
