import 'dart:math' as math;

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
  late Animation<double> _threadAnimation;
  int _hoveredIndex = -1;

  // Cache computed values to avoid recalculation
  late List<JourneyStep> _journeySteps;

  @override
  void initState() {
    super.initState();
    _journeySteps = _getJourneySteps();

    // Enhanced animation controller for thread effect
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _threadAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                        colorScheme.surface,
                        colorScheme.surface.withValues(alpha: 0.95),
                        Colors.black.withValues(alpha: 0.02),
                      ]
                    : [
                        Colors.grey[50]!,
                        Colors.white.withValues(alpha: 0.8),
                        Colors.blue[50]!.withValues(alpha: 0.3),
                      ],
              ),
            ),
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
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.1),
                theme.colorScheme.secondary.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            'My Journey',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: RichText(
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "From Boy to ",
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontFamily: 'Bitcount Prop Single',
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                    letterSpacing: isMobile ? -0.5 : -1,
                    height: 1.1,
                  ),
                ),
                TextSpan(
                  text: "Dev",
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontFamily: 'Bitcount Prop Single',
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                    letterSpacing: isMobile ? -0.5 : -1,
                    height: 1.1,
                  ),
                ),
                TextSpan(
                  text: "eloper",
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontFamily: 'Bitcount Prop Single',
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                    letterSpacing: isMobile ? -0.5 : -1,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
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
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        // Zigzag background thread for mobile
        Positioned(
          left: 0,
          right: 0,
          top: 10,
          bottom: 0,
          child: AnimatedBuilder(
            animation: _threadAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: ZigzagThreadPainter(
                  progress: _threadAnimation.value,
                  steps: steps,
                  isMobile: true,
                  isDark: isDark,
                ),
              );
            },
          ),
        ),
        // Journey steps
        Column(
          children: steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            return _buildMobileTimelineItem(theme, step, index, steps.length);
          }).toList(),
        ),
      ],
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

    // Calculate zigzag position for mobile
    final double zigzagOffset = _calculateMobileZigzagOffset(index, totalSteps);

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot with dynamic positioning
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: zigzagOffset),
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [step.color, step.color.withValues(alpha: 0.7)],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: step.color.withValues(alpha: 0.4),
                        blurRadius: 12,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(
                          alpha: isDark ? 0.1 : 0.8,
                        ),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(step.icon, size: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Content with enhanced styling
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? theme.colorScheme.surfaceContainer
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: step.color.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: step.color.withValues(alpha: 0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: 3,
                  ),
                  BoxShadow(
                    color: isDark
                        ? Colors.black26
                        : Colors.grey.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _buildStepContent(theme, step, true),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateMobileZigzagOffset(int index, int totalSteps) {
    // Create a zigzag pattern - alternate left and right
    return index % 2 == 0 ? 0.0 : 40.0;
  }

  Widget _buildDesktopTimeline(
    ThemeData theme,
    List<JourneyStep> steps,
    bool isTablet,
  ) {
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        // Zigzag central thread line for desktop
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _threadAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: ZigzagThreadPainter(
                  progress: _threadAnimation.value,
                  steps: steps,
                  isMobile: false,
                  isDark: isDark,
                ),
              );
            },
          ),
        ),
        // Journey steps
        Column(
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
        ),
      ],
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
        margin: const EdgeInsets.symmetric(vertical: 30),
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
            // Center timeline with enhanced dot
            SizedBox(
              width: 100,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isHovered ? 36 : 32,
                  height: isHovered ? 36 : 32,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [step.color, step.color.withValues(alpha: 0.8)],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: isHovered ? 5 : 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: step.color.withValues(
                          alpha: isHovered ? 0.6 : 0.4,
                        ),
                        blurRadius: isHovered ? 20 : 12,
                        spreadRadius: isHovered ? 5 : 3,
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(
                          alpha: isDark ? 0.2 : 0.9,
                        ),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    step.icon,
                    size: isHovered ? 20 : 18,
                    color: Colors.white,
                  ),
                ),
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(left: isLeft ? 0 : 30, right: isLeft ? 30 : 0),
      padding: const EdgeInsets.all(24),
      transform: Matrix4.identity()
        ..translate(0.0, isHovered ? -6.0 : 0.0)
        ..scale(isHovered ? 1.03 : 1.0),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surfaceContainer : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isHovered
              ? step.color.withValues(alpha: 0.6)
              : step.color.withValues(alpha: 0.3),
          width: isHovered ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? step.color.withValues(alpha: 0.25)
                : step.color.withValues(alpha: 0.15),
            blurRadius: isHovered ? 25 : 15,
            offset: Offset(0, isHovered ? 10 : 5),
            spreadRadius: isHovered ? 5 : 3,
          ),
          BoxShadow(
            color: isDark
                ? Colors.black26
                : Colors.grey.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
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
                gradient: LinearGradient(
                  colors: [
                    step.color.withValues(alpha: 0.15),
                    step.color.withValues(alpha: 0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: step.color.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Text(
                step.period,
                style: TextStyle(
                  color: step.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    step.color.withValues(alpha: 0.15),
                    step.color.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: step.color.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(step.icon, color: step.color, size: 22),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          step.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          step.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: secondaryTextColor,
            height: 1.6,
            fontSize: isMobile ? 14 : 15,
          ),
        ),
        const SizedBox(height: 18),
        // Enhanced technology tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: step.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          Colors.white.withValues(alpha: 0.12),
                          Colors.white.withValues(alpha: 0.06),
                        ]
                      : [
                          Colors.grey.withValues(alpha: 0.12),
                          Colors.grey.withValues(alpha: 0.06),
                        ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.25)
                      : Colors.grey.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                tech,
                style: TextStyle(
                  fontSize: 12,
                  color: primaryTextColor.withValues(alpha: 0.85),
                  fontWeight: FontWeight.w600,
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

// Custom painter for zigzag thread connections
class ZigzagThreadPainter extends CustomPainter {
  final double progress;
  final List<JourneyStep> steps;
  final bool isMobile;
  final bool isDark;

  ZigzagThreadPainter({
    required this.progress,
    required this.steps,
    required this.isMobile,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (isMobile) {
      _paintMobileZigzagThread(canvas, size);
    } else {
      _paintDesktopZigzagThread(canvas, size);
    }
  }

  void _paintMobileZigzagThread(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final stepHeight = size.height / (steps.length - 1);

    for (int i = 0; i < steps.length - 1; i++) {
      final currentY = i * stepHeight + 20;
      final nextY = (i + 1) * stepHeight + 20;

      // Calculate zigzag positions
      final currentX = i % 2 == 0 ? 20.0 : 60.0;
      final nextX = (i + 1) % 2 == 0 ? 20.0 : 60.0;

      // Create straight line path
      final path = Path();
      path.moveTo(currentX, currentY);
      path.lineTo(nextX, nextY);

      // Apply gradient effect
      final gradient = LinearGradient(
        colors: [
          steps[i].color.withValues(alpha: 0.8),
          steps[i + 1].color.withValues(alpha: 0.8),
        ],
      );

      final rect = Rect.fromLTWH(
        math.min(currentX, nextX) - 10,
        currentY,
        (currentX - nextX).abs() + 20,
        nextY - currentY,
      );

      paint.shader = gradient.createShader(rect);

      // Draw the current segment if within progress
      final segmentProgress = (progress * (steps.length - 1)) - i;
      if (segmentProgress > 0) {
        final clampedProgress = segmentProgress.clamp(0.0, 1.0);

        // Draw partial line based on progress
        final partialPath = Path();
        partialPath.moveTo(currentX, currentY);

        final partialX = currentX + (nextX - currentX) * clampedProgress;
        final partialY = currentY + (nextY - currentY) * clampedProgress;
        partialPath.lineTo(partialX, partialY);

        canvas.drawPath(partialPath, paint);
      }
    }
  }

  void _paintDesktopZigzagThread(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final centerX = size.width / 2;
    final stepHeight = size.height / (steps.length - 1);

    for (int i = 0; i < steps.length - 1; i++) {
      final currentY = i * stepHeight + 40;
      final nextY = (i + 1) * stepHeight + 40;

      // Create zigzag pattern - alternating sides
      final currentIsLeft = i % 2 == 0;
      final nextIsLeft = (i + 1) % 2 == 0;

      final currentX = currentIsLeft ? centerX - 200 : centerX + 200;
      final nextX = nextIsLeft ? centerX - 200 : centerX + 200;

      // Create straight line path with intermediate point at center
      final path = Path();
      path.moveTo(currentX, currentY);

      // Add intermediate point for zigzag effect
      final midY = currentY + (nextY - currentY) * 0.5;
      path.lineTo(centerX, midY);
      path.lineTo(nextX, nextY);

      // Apply gradient based on step colors
      final gradient = LinearGradient(
        colors: [steps[i].color, steps[i + 1].color],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

      final rect = Rect.fromLTWH(
        centerX - 250,
        currentY,
        500,
        nextY - currentY,
      );

      paint.shader = gradient.createShader(rect);

      // Draw segment based on progress
      final segmentProgress = (progress * (steps.length - 1)) - i;
      if (segmentProgress > 0) {
        final clampedProgress = segmentProgress.clamp(0.0, 1.0);

        final partialPath = Path();
        partialPath.moveTo(currentX, currentY);

        if (clampedProgress <= 0.5) {
          // Draw first half - from current to center
          final partialX =
              currentX + (centerX - currentX) * (clampedProgress * 2);
          final partialY = currentY + (midY - currentY) * (clampedProgress * 2);
          partialPath.lineTo(partialX, partialY);
        } else {
          // Draw full first half, then partial second half
          partialPath.lineTo(centerX, midY);
          final secondHalfProgress = (clampedProgress - 0.5) * 2;
          final partialX = centerX + (nextX - centerX) * secondHalfProgress;
          final partialY = midY + (nextY - midY) * secondHalfProgress;
          partialPath.lineTo(partialX, partialY);
        }

        canvas.drawPath(partialPath, paint);

        // Add glow effect
        final glowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8.0
          ..strokeCap = StrokeCap.round
          ..shader = gradient.createShader(rect)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

        canvas.drawPath(partialPath, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(ZigzagThreadPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isMobile != isMobile ||
        oldDelegate.isDark != isDark;
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
