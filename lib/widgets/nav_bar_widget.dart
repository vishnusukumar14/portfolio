import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onExperiencePressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onJourneyRoadMapPressed;
  final VoidCallback onContactPressed;
  final String? activeSection;

  const NavBarWidget({
    super.key,
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onExperiencePressed,
    required this.onProjectsPressed,
    required this.onJourneyRoadMapPressed,
    required this.onContactPressed,
    this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = MediaQuery.of(context).size.width < 700;

        if (isMobile) {
          return _buildMobileNav(context, colorScheme);
        } else {
          return _buildDesktopNav(context, colorScheme);
        }
      },
    );
  }

  Widget _buildMobileNav(BuildContext context, ColorScheme colorScheme) {
    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                colorScheme.primaryContainer.withValues(alpha: 0.1),
                colorScheme.secondaryContainer.withValues(alpha: 0.1),
              ],
            ),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _showMobileNavSheet(context),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.menu_rounded,
                  color: colorScheme.onSurface,
                  size: 18,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopNav(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildNavItem(
          context,
          'Home',
          Icons.home_rounded,
          onHomePressed,
          'Home',
        ),
        _buildNavItem(
          context,
          'About',
          Icons.person_rounded,
          onAboutPressed,
          'About',
        ),
        _buildNavItem(
          context,
          'Experience',
          Icons.work_rounded,
          onExperiencePressed,
          'Experience',
        ),
        _buildNavItem(
          context,
          'Projects',
          Icons.folder_rounded,
          onProjectsPressed,
          'Projects',
        ),
        // _buildNavItem(
        //   context,
        //   'Skills',
        //   Icons.code_rounded,
        //   onSkillsPressed,
        //   'Skills',
        // ),
        _buildNavItem(
          context,
          'Contact',
          Icons.mail_rounded,
          onContactPressed,
          'Contact',
        ),
        PopupMenuButton(
          position: PopupMenuPosition.under,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: onJourneyRoadMapPressed,
              child: Row(
                children: const [
                  Icon(Icons.join_full_rounded, size: 18),
                  SizedBox(width: 8),
                  Text('My Journey'),
                ],
              ),
            ),
            if (kDebugMode)
              PopupMenuItem(
                onTap: () {}, // e.g., open blog/resume
                child: Row(
                  children: const [
                    Icon(Icons.article_rounded, size: 18),
                    SizedBox(width: 8),
                    Text('Blog'),
                  ],
                ),
              ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  Icon(Icons.more_horiz, size: 18, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'More',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
    String section,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isActive = activeSection == section;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: isActive
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    border: Border.all(color: colorScheme.primary, width: 1),
                  )
                : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isActive
                      ? colorScheme.primary
                      : colorScheme.primary.withValues(alpha: 0.8),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    // color: isActive ? colorScheme.primary : Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileNavSheet(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          gradient: LinearGradient(
            colors: [
              colorScheme.surface,
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: _MobileNavSheet(
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
          onJourneyRoadMapPressed: () {
            Navigator.pop(context);
            onJourneyRoadMapPressed();
          },
          onContactPressed: () {
            Navigator.pop(context);
            onContactPressed();
          },
          activeSection: activeSection,
        ),
      ),
    );
  }
}

class _MobileNavSheet extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onExperiencePressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onJourneyRoadMapPressed;
  final VoidCallback onContactPressed;
  final String? activeSection;

  const _MobileNavSheet({
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onExperiencePressed,
    required this.onProjectsPressed,
    required this.onJourneyRoadMapPressed,
    required this.onContactPressed,
    this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 24),
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: colorScheme.outline.withValues(alpha: 0.4),
            ),
          ),

          // Navigation items
          ..._buildNavItems(context),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context) {
    final items = [
      _NavItemData('Home', Icons.home_rounded, onHomePressed),
      _NavItemData('About', Icons.person_rounded, onAboutPressed),
      _NavItemData('Internships', Icons.work_rounded, onExperiencePressed),
      _NavItemData('Projects', Icons.folder_rounded, onProjectsPressed),
      // _NavItemData('Skills', Icons.code_rounded, onSkillsPressed),
      _NavItemData('Contact', Icons.mail_rounded, onContactPressed),
      _NavItemData(
        'My Journey',
        Icons.join_full_rounded,
        onJourneyRoadMapPressed,
      ),
      if (kDebugMode)
        _NavItemData('Blog', Icons.article_rounded, () {
          // Add your blog link or resume
        }),
    ];

    return items.map((item) => _buildMobileNavItem(context, item)).toList();
  }

  Widget _buildMobileNavItem(BuildContext context, _NavItemData item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isActive = activeSection == item.title;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isActive
            ? LinearGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: 0.1),
                  colorScheme.secondary.withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        border: isActive
            ? Border.all(
                color: colorScheme.primary.withValues(alpha: 0.2),
                width: 1,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: item.onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isActive
                        ? colorScheme.primary.withValues(alpha: 0.2)
                        : colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.5,
                          ),
                  ),
                  child: Icon(
                    item.icon,
                    size: 18,
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const _NavItemData(this.title, this.icon, this.onPressed);
}
