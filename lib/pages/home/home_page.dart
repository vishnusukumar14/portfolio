import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/home/sections/internships_section.dart';
import 'package:portfolio_app/pages/home/sections/project_section.dart';

import '../../core/analytics_service.dart';
import '../../widgets/contact_section_widget.dart';
import '../../widgets/nav_bar_widget.dart';
import 'sections/about_section.dart';
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

  @override
  void initState() {
    super.initState();
    // Track user visit when page loads
    _trackUserVisit();
  }

  Future<void> _trackUserVisit() async {
    // Small delay to ensure page is fully loaded
    await Future.delayed(Duration(milliseconds: 500));
    await AnalyticsService.trackUserVisit();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 80,
            floating: true,
            pinned: true,
            backgroundColor: Color(0xFF720102),
            elevation: 2,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [Colors.blue.shade50, Colors.white],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                ),
              ),
            ),
            leading: Icon(Icons.handshake, color: Colors.white),
            titleSpacing: 0,
            title: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            actions: [
              NavBarWidget(
                onHomePressed: () => _scrollToSection(_homeKey),
                onAboutPressed: () => _scrollToSection(_aboutKey),
                onExperiencePressed: () => _scrollToSection(_experienceKey),
                onProjectsPressed: () => _scrollToSection(_projectsKey),
                onSkillsPressed: () => _scrollToSection(_skillsKey),
                onContactPressed: () => _scrollToSection(_contactKey),
              ),
            ],
          ),
          // Home Section
          SliverToBoxAdapter(
            child: Container(
              key: _homeKey,
              child: HeroSectionWidget(
                onGetInTouchPressed: () {
                  _scrollToSection(_contactKey);
                },
                onBrowseProjectPressed: () {
                  _scrollToSection(_projectsKey);
                },
              ),
            ),
          ),
          // About Section
          SliverToBoxAdapter(
            child: Container(key: _aboutKey, child: AboutSectionWidget()),
          ),
          // Experience Section
          SliverToBoxAdapter(
            child: Container(
              key: _experienceKey,
              child: InternshipsSectionWidget(),
            ),
          ),
          // Projects Section
          SliverToBoxAdapter(
            child: Container(
              key: _projectsKey,
              child: ProjectSectionWithNote(),
            ),
          ),
          // Contact Section
          SliverToBoxAdapter(
            child: Container(key: _contactKey, child: ContactSectionWidget()),
          ),
        ],
      ),
    );
  }
}
