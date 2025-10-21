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
                  text: "From ",
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
                  text: "Dev ",
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
                  text: "to ",
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
        // Simple straight line with flowing dots
        Positioned(
          left: 32,
          top: 20,
          bottom: 20,
          child: AnimatedBuilder(
            animation: _threadAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: MobileThreadPainter(
                  progress: _threadAnimation.value,
                  steps: steps,
                  isDark: isDark,
                ),
                size: Size(4, double.infinity),
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

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot - fixed position
          SizedBox(
            width: 64,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
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
                  child: Icon(step.icon, size: 16, color: Colors.white),
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

  Widget _buildDesktopTimeline(
    ThemeData theme,
    List<JourneyStep> steps,
    bool isTablet,
  ) {
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        // Central flowing line with gradient dots
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _threadAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: DesktopThreadPainter(
                  progress: _threadAnimation.value,
                  steps: steps,
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
            'Pursuing Master\'s in Computer Applications at SJCE, Mysuru (GPA: 8.72/10). Mastered mobile development with Flutter/Dart and Android development with Kotlin. Learned backend development with Django.',
        technologies: [
          'Flutter',
          'Dart',
          'Kotlin',
          'Python',
          'Django',
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
            'Built Connexy (privacy-first chat app with Django backend) and QuickGO (voice-activated e-grocery platform). Implemented advanced features like QR code scanning, real-time messaging, and KNN-based partner allocation.',
        technologies: [
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
        period: '2025-Present',
        title: 'Mastering Flutter',
        description:
        'Deepening expertise in Flutter by building real-world projects and exploring advanced topics like state management, animations, and cross-platform performance optimization. Continuously learning to craft beautiful, efficient, and scalable mobile experiences.',
        technologies: [
          'Flutter',
          'Dart',
          'State Management',
          'Animations',
          'Clean Architecture',
        ],
        icon: Icons.flutter_dash,
        color: const Color(0xFF42A5F5),
      ),

    ];
  }
}

// Simple flowing line painter for mobile
class MobileThreadPainter extends CustomPainter {
  final double progress;
  final List<JourneyStep> steps;
  final bool isDark;

  MobileThreadPainter({
    required this.progress,
    required this.steps,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Main line
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Create gradient for the line
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        steps.first.color.withValues(alpha: 0.6),
        ...steps.map((s) => s.color.withValues(alpha: 0.3)),
        steps.last.color.withValues(alpha: 0.6),
      ],
    );

    linePaint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    // Draw main line
    final lineHeight = size.height * progress;
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, lineHeight),
      linePaint,
    );

    // Add flowing dots effect
    final dotPaint = Paint()..style = PaintingStyle.fill;

    final totalDots = 5;
    final dotSpacing = size.height / totalDots;

    for (int i = 0; i < totalDots; i++) {
      final dotProgress = (progress * 2 - i * 0.3).clamp(0.0, 1.0);
      if (dotProgress > 0) {
        final y = i * dotSpacing + (dotSpacing * 0.5);
        final opacity = (dotProgress * (1.0 - i * 0.15)).clamp(0.0, 1.0);

        dotPaint.color = steps[i % steps.length].color.withValues(
          alpha: opacity * 0.7,
        );

        canvas.drawCircle(
          Offset(size.width / 2, y),
          3.0 * dotProgress,
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(MobileThreadPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Elegant curved line painter for desktop
class DesktopThreadPainter extends CustomPainter {
  final double progress;
  final List<JourneyStep> steps;
  final bool isDark;

  DesktopThreadPainter({
    required this.progress,
    required this.steps,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final stepHeight = size.height / (steps.length - 1);

    // Main flowing line
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    // Create gradient
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: steps.map((s) => s.color.withValues(alpha: 0.4)).toList(),
    );

    linePaint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    // Draw smooth curved line through center
    final path = Path();
    path.moveTo(centerX, 0);

    for (int i = 0; i < steps.length; i++) {
      final y = i * stepHeight;
      final currentProgress = (progress * steps.length) - i;

      if (currentProgress > 0) {
        final clampedProgress = currentProgress.clamp(0.0, 1.0);
        final targetY = y + (stepHeight * clampedProgress);

        // Add slight curve for elegance
        final controlOffset = 20.0;
        if (i == 0) {
          path.lineTo(centerX, targetY);
        } else {
          path.quadraticBezierTo(
            centerX + (i % 2 == 0 ? controlOffset : -controlOffset),
            targetY - stepHeight * 0.5,
            centerX,
            targetY,
          );
        }
      }
    }

    canvas.drawPath(path, linePaint);

    // Add subtle glow effect
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);

    canvas.drawPath(path, glowPaint);

    // Add floating particles effect
    final particlePaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < steps.length * 2; i++) {
      final particleProgress = (progress * 1.5 - i * 0.1).clamp(0.0, 1.0);

      if (particleProgress > 0) {
        final y = (i / 2) * stepHeight;
        final opacity = (particleProgress * 0.8).clamp(0.0, 1.0);
        final stepIndex = (i / 2).floor() % steps.length;

        particlePaint.color = steps[stepIndex].color.withValues(alpha: opacity);

        // Create floating effect with slight horizontal offset
        final offsetX = math.sin(i * 0.5) * 15;
        canvas.drawCircle(
          Offset(centerX + offsetX, y),
          2.0 * particleProgress,
          particlePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(DesktopThreadPainter oldDelegate) {
    return oldDelegate.progress != progress;
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
