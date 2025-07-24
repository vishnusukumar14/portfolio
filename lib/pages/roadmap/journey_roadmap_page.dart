import 'package:flutter/material.dart';

class JourneySectionWidget extends StatefulWidget {
  const JourneySectionWidget({super.key});

  @override
  State<JourneySectionWidget> createState() => _JourneySectionWidgetState();
}

class _JourneySectionWidgetState extends State<JourneySectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _hoveredIndex = -1;

  // Cache computed values to avoid recalculation
  late List<JourneyStep> _journeySteps;

  @override
  void initState() {
    super.initState();
    _journeySteps = _getJourneySteps();

    // Reduced animation duration for web
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;
        final bool isTablet =
            constraints.maxWidth >= 700 && constraints.maxWidth < 1024;

        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 80,
              horizontal: isMobile ? 16 : 24,
            ),
            // Simplified gradient for better web performance
            color: isDark ? colorScheme.surface : Colors.grey[50],
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      _buildHeader(theme, isMobile),
                      SizedBox(height: isMobile ? 40 : 60),
                      _buildJourneyTimeline(theme, isMobile, isTablet),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme, bool isMobile) {
    final isDark = theme.brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            '🚀 My Journey',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'From Beginner to Developer',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: 'Bitcount Prop Single',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Every expert was once a beginner. Here\'s my coding journey from the first "Hello World" to building complex applications.',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: isMobile ? 16 : 18,
            color: secondaryTextColor,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildJourneyTimeline(ThemeData theme, bool isMobile, bool isTablet) {
    if (isMobile) {
      return _buildMobileTimeline(theme, _journeySteps);
    } else {
      return _buildDesktopTimeline(theme, _journeySteps, isTablet);
    }
  }

  Widget _buildMobileTimeline(ThemeData theme, List<JourneyStep> steps) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        return _buildMobileTimelineItem(theme, step, index, steps.length);
      }).toList(),
    );
  }

  Widget _buildMobileTimelineItem(
    ThemeData theme,
    JourneyStep step,
    int index,
    int totalSteps,
  ) {
    final isDark = theme.brightness == Brightness.dark;
    final isLast = index == totalSteps - 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line and dot
        SizedBox(
          width: 40,
          child: Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: step.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  // Simplified shadow for web performance
                  boxShadow: [
                    BoxShadow(
                      color: step.color.withValues(alpha: 0.2),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(step.icon, size: 12, color: Colors.white),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 80,
                  // Solid color instead of gradient for better performance
                  color: step.color.withValues(alpha: 0.3),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Content
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? theme.colorScheme.surfaceContainer : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: step.color.withValues(alpha: 0.2),
                width: 1,
              ),
              // Simplified shadow
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black12
                      : Colors.grey.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _buildStepContent(theme, step, true),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopTimeline(
    ThemeData theme,
    List<JourneyStep> steps,
    bool isTablet,
  ) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isLeft = index % 2 == 0;
        return _buildDesktopTimelineItem(
          theme,
          step,
          index,
          steps.length,
          isLeft,
          isTablet,
        );
      }).toList(),
    );
  }

  Widget _buildDesktopTimelineItem(
    ThemeData theme,
    JourneyStep step,
    int index,
    int totalSteps,
    bool isLeft,
    bool isTablet,
  ) {
    final isDark = theme.brightness == Brightness.dark;
    final isLast = index == totalSteps - 1;
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            // Left content
            Expanded(
              child: isLeft
                  ? _buildTimelineCard(
                      theme,
                      step,
                      index,
                      isHovered,
                      isTablet,
                      true,
                    )
                  : const SizedBox(),
            ),
            // Center timeline - simplified animations
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    width: isHovered ? 28 : 24,
                    height: isHovered ? 28 : 24,
                    decoration: BoxDecoration(
                      color: step.color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      // Simplified shadow
                      boxShadow: [
                        BoxShadow(
                          color: step.color.withValues(
                            alpha: isHovered ? 0.3 : 0.2,
                          ),
                          blurRadius: isHovered ? 8 : 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(
                      step.icon,
                      size: isHovered ? 16 : 14,
                      color: Colors.white,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      // Solid color instead of gradient
                      color: step.color.withValues(alpha: 0.4),
                    ),
                ],
              ),
            ),
            // Right content
            Expanded(
              child: !isLeft
                  ? _buildTimelineCard(
                      theme,
                      step,
                      index,
                      isHovered,
                      isTablet,
                      false,
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard(
    ThemeData theme,
    JourneyStep step,
    int index,
    bool isHovered,
    bool isTablet,
    bool isLeft,
  ) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(left: isLeft ? 0 : 20, right: isLeft ? 20 : 0),
      padding: const EdgeInsets.all(24),
      // Removed transform animation for better web performance
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surfaceContainer : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHovered
              ? step.color.withValues(alpha: 0.4)
              : step.color.withValues(alpha: 0.2),
          width: isHovered ? 2 : 1,
        ),
        // Simplified shadow
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? step.color.withValues(alpha: 0.15)
                : (isDark
                      ? Colors.black12
                      : Colors.grey.withValues(alpha: 0.08)),
            blurRadius: isHovered ? 12 : 6,
            offset: Offset(0, isHovered ? 4 : 2),
          ),
        ],
      ),
      child: _buildStepContent(theme, step, false),
    );
  }

  Widget _buildStepContent(ThemeData theme, JourneyStep step, bool isMobile) {
    final isDark = theme.brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: step.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                step.period,
                style: TextStyle(
                  color: step.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            Icon(step.icon, color: step.color, size: 20),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          step.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          step.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: secondaryTextColor,
            height: 1.5,
            fontSize: isMobile ? 14 : 15,
          ),
        ),
        const SizedBox(height: 16),
        // Optimized technology tags with const widgets where possible
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: step.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                tech,
                style: TextStyle(
                  fontSize: 12,
                  color: primaryTextColor.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  List<JourneyStep> _getJourneySteps() {
    return [
      JourneyStep(
        period: '2017-2019',
        title: 'Academic Foundation',
        description:
            'Completed Higher Secondary Studies at Ahalia Public School, Palakkad. Built strong analytical thinking and problem-solving foundation that would later fuel my programming journey.',
        technologies: [
          'Academic Excellence',
          'Problem Solving',
          'Analytical Thinking',
        ],
        icon: Icons.school,
        color: const Color(0xFF6C63FF),
      ),
      JourneyStep(
        period: '2019-2022',
        title: 'Computer Science Fundamentals',
        description:
            'Pursued Bachelor\'s in Computer Science at St. Joseph\'s First Grade College, Mysuru. Learned programming fundamentals, data structures, and core CS concepts. Achieved 85% score.',
        technologies: [
          'Programming Fundamentals',
          'Data Structures',
          'Algorithms',
          'Database Concepts',
        ],
        icon: Icons.laptop_mac,
        color: const Color(0xFF00D4AA),
      ),
      JourneyStep(
        period: '2022-2023',
        title: 'Programming Exploration',
        description:
            'Started exploring modern development technologies. Built first projects with web technologies and began understanding software development lifecycle and version control.',
        technologies: [
          'HTML',
          'CSS',
          'JavaScript',
          'Python',
          'Git',
          'Basic Web Development',
        ],
        icon: Icons.code,
        color: const Color(0xFFFF6B6B),
      ),
      JourneyStep(
        period: '2023-2025',
        title: 'MCA & Advanced Learning',
        description:
            'Pursuing Master\'s in Computer Applications at SJCE, Mysuru (GPA: 8.72/10). Mastered mobile development with Flutter/Dart and Android development with Kotlin. Learned backend development with Django and Go.',
        technologies: [
          'Flutter',
          'Dart',
          'Kotlin',
          'Python',
          'Django',
          'Go',
          'Firebase',
          'MongoDB',
        ],
        icon: Icons.construction,
        color: const Color(0xFFFFD93D),
      ),
      JourneyStep(
        period: 'Sep 2024 - Jan 2025',
        title: 'First Real Project - Voigo',
        description:
            'Developed Voigo, a hyperlocal delivery platform under faculty mentorship. Built full-stack features using Kotlin and Django, integrated Google Maps API, and conducted pilot deployments with usability testing.',
        technologies: [
          'Kotlin',
          'Django',
          'Firebase',
          'MongoDB',
          'Google Maps API',
          'Full-Stack Development',
        ],
        icon: Icons.store,
        color: const Color(0xFF9C27B0),
      ),
      JourneyStep(
        period: 'Personal Projects',
        title: 'Innovation & Problem Solving',
        description:
            'Built Connexy (privacy-first chat app with Go backend) and QuickGO (voice-activated e-grocery platform). Implemented advanced features like QR code scanning, real-time messaging, and KNN-based partner allocation.',
        technologies: [
          'Go',
          'Flutter',
          'Firestore',
          'Firebase Auth',
          'FCM',
          'Riverpod',
          'Voice Recognition',
        ],
        icon: Icons.lightbulb,
        color: const Color(0xFF00BCD4),
      ),
      JourneyStep(
        period: 'Feb 2025 - June 2025',
        title: 'Professional Experience',
        description:
            'Software Developer Intern at Swagino\'s. Building cross-platform apps with Flutter, developing backend services in Go and Django, and implementing gRPC-based real-time communication systems.',
        technologies: [
          'Flutter',
          'Kotlin',
          'Jetpack Compose',
          'Go',
          'Django',
          'gRPC',
          'CI/CD',
          'GitHub Actions',
        ],
        icon: Icons.work,
        color: const Color(0xFF4CAF50),
      ),
      JourneyStep(
        period: '2025-Present',
        title: 'Continuous Growth',
        description:
            'Focused on clean architecture, scalable systems, and production-ready code. Exploring advanced topics in mobile development, backend optimization, and DevOps practices while contributing to the developer community.',
        technologies: [
          'Clean Architecture',
          'MVVM',
          'Advanced Flutter',
          'Cloud Architecture',
          'Performance Optimization',
        ],
        icon: Icons.auto_awesome,
        color: const Color(0xFFE91E63),
      ),
    ];
  }
}

class JourneyStep {
  final String period;
  final String title;
  final String description;
  final List<String> technologies;
  final IconData icon;
  final Color color;

  const JourneyStep({
    required this.period,
    required this.title,
    required this.description,
    required this.technologies,
    required this.icon,
    required this.color,
  });
}
