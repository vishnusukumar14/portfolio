import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';
import 'package:portfolio_app/pages/home/sections/internships_section.dart';
import 'package:portfolio_app/pages/home/sections/project_section.dart';
import 'package:web/web.dart' as web;

import '../../core/analytics_service.dart';
import '../../widgets/nav_bar_widget.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  _PortfolioHomePageState createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _activeSection = 'Home';

  @override
  void initState() {
    super.initState();
    _trackUserVisit();
    _setupScrollListener();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _trackUserVisit() async {
    await Future.delayed(Duration(milliseconds: 500));
    await AnalyticsService.trackUserVisit();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {});
  }

  void _scrollToSection(GlobalKey key, String sectionName) {
    final context = key.currentContext;
    if (context != null) {
      setState(() {
        _activeSection = sectionName;
      });

      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _onRefresh() async {
    web.window.location.reload();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: RefreshIndicator(
        onRefresh: MediaQuery.of(context).size.width < 800
            ? _onRefresh
            : () async {}, // No-op if not mobile
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Theme-aware App Bar
            SliverAppBar(
              expandedHeight: 80,
              floating: true,
              pinned: true,
              backgroundColor: colorScheme.surface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              systemOverlayStyle: isDark
                  ? theme.appBarTheme.systemOverlayStyle?.copyWith(
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.light,
                    )
                  : theme.appBarTheme.systemOverlayStyle?.copyWith(
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.dark,
                    ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.surface,
                        colorScheme.surface.withValues(alpha: 0.95),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              leading: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.handshake_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              titleSpacing: 0,
              title: Text(
                "Welcome",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: NavBarWidget(
                    activeSection: _activeSection,
                    onHomePressed: () => _scrollToSection(_homeKey, 'Home'),
                    onAboutPressed: () => _scrollToSection(_aboutKey, 'About'),
                    onExperiencePressed: () =>
                        _scrollToSection(_experienceKey, 'Experience'),
                    onProjectsPressed: () =>
                        _scrollToSection(_projectsKey, 'Projects'),
                    onSkillsPressed: () =>
                        _scrollToSection(_skillsKey, 'Skills'),
                    onContactPressed: () =>
                        _scrollToSection(_contactKey, 'Contact'),
                  ),
                ),
              ],
            ),

            // Home Section
            SliverToBoxAdapter(
              child: Container(
                key: _homeKey,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.surface,
                      colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.3,
                      ),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: HeroSectionWidget(
                  onGetInTouchPressed: () {
                    _scrollToSection(_contactKey, 'Contact');
                  },
                  onBrowseProjectPressed: () {
                    _scrollToSection(_projectsKey, 'Projects');
                  },
                ),
              ),
            ),

            // Section Divider
            SliverToBoxAdapter(
              child: Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      colorScheme.outline.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // About Section
            SliverToBoxAdapter(
              child: Container(
                key: _aboutKey,
                decoration: BoxDecoration(color: colorScheme.surface),
                child: AboutSectionWidget(),
              ),
            ),

            // Section Divider
            SliverToBoxAdapter(
              child: Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      colorScheme.outline.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Experience Section
            SliverToBoxAdapter(
              child: Container(
                key: _experienceKey,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.surface,
                      colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.2,
                      ),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: InternshipsSectionWidget(),
              ),
            ),

            // Section Divider
            SliverToBoxAdapter(
              child: Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      colorScheme.outline.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Projects Section
            SliverToBoxAdapter(
              child: Container(
                key: _projectsKey,
                decoration: BoxDecoration(color: colorScheme.surface),
                child: ProjectSectionWithNote(),
              ),
            ),

            // Section Divider
            SliverToBoxAdapter(
              child: Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      colorScheme.outline.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                key: _contactKey,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.surface,
                      colorScheme.surfaceContainer.withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: EnhancedContactSectionWidget(
                  whatsappNumber: Contents.myPhoneNumber,
                  emailAddress: Contents.myEmailId,
                ),
              ),
            ),
          ],
        ),
      ),

      // Contact Section
    );
  }
}
