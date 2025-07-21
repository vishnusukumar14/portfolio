import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/experience.dart';
import 'models/project.dart';

class Contents {
  static const aboutMeSectionDescription =
      """I'm an enthusiastic Flutter developer with a strong interest in building smooth, scalable, and user-friendly cross-platform applications. During my academic projects and internship experience, I've worked with Flutter & Dart, focusing on clean architecture and efficient state management using tools like Riverpod, Bloc, and Provider.
I've gained hands-on experience integrating REST APIs, Firebase, and MongoDB, and have built secure login systems and real-time features. I'm also familiar with Android development using Kotlin and Jetpack Compose, and have explored backend development using Python and Django.

I enjoy debugging tough issues, optimizing performance, and crafting polished UI/UX. I'm eager to learn, build, and grow as a Flutter developer in a challenging and collaborative environment.

Oh, and by the way—this entire website is built with Flutter too!""";

  static const projectSectionDescription =
      "Hey! Here you'll find a collection of my personal experiments and projects — "
      "ranging from Flutter apps to native Kotlin applications. "
      "Many of these are integrated with Firebase, MongoDB, "
      "Maps API, gRPC, and other modern tools. I enjoy "
      "exploring new technologies and building apps with "
      "clean architecture and smooth UX. For more, feel free to check out my GitHub.";

  static final experiences = [
    Experience(
      title: "Software Developer Intern",
      company: "Swagino’s",
      companyProfileUrl:
          "https://www.linkedin.com/company/swaginos/posts/?feedView=all",
      duration: "Feb 2025 – June 2025",
      location: "Remote",
      highlights: [
        "Led development of cross-platform apps using Flutter & Dart, focusing on high-performance, scalable, and responsive UIs.",
        "Contributed to backend systems built with Python, Django, and gRPC.",
        "Utilized Firebase, FCM, and REST APIs for real-time features and backend integration.",
        "Collaborated remotely using Git for version control and team coordination.",
      ],
      techStack: [
        "Flutter",
        "Dart",
        "Kotlin",
        "Jetpack Compose",
        "Python",
        "Django",
        "gRPC",
        "Firebase",
        "FCM",
        "REST APIs",
        "Git",
      ],
    ),
    Experience(
      title: "Product Development – Voigo (Hyperlocal Delivery Platform)",
      company:
          "Sri Jayachamarajendra College of Engineering, Mysuru, Karnataka",
      companyProfileUrl:
          "https://www.linkedin.com/school/sri-jayachamarajendra-college-of-engineering/",
      duration: "Sep 2024 – Jan 2025",
      location: "Onsite",
      highlights: [
        "Worked under faculty mentorship to develop Voigo, a hyperlocal platform connecting users with nearby kirana stores.",
        "Bypassed traditional data storage via real-time order/inventory management.",
        "Built full-stack applications using Kotlin and Python Django; integrated Google Maps & live tracking.",
        "Implemented pilot deployments, conducted usability testing, and improved system based on feedback.",
      ],
      techStack: [
        "Kotlin",
        "Java",
        "Django",
        "Firebase",
        "MongoDB",
        "REST APIs",
        "Google Maps API",
        "Git",
      ],
    ),
  ];

  static final List<Project> allProjects = [
    Project(
      name: "Connexy",
      description:
          "Connexy is a Flutter-based mobile application that combines QR-code-based authentication with real-time messaging. "
          "Designed using clean architecture and Riverpod for scalable state management, the app provides a seamless and secure communication experience.",
      codeUrl: "https://github.com/vishnusukumar14/connexy",
      stars: 2,
      language: "Dart",
      languageColor: Colors.greenAccent,
      isPrivate: true,
    ),
    Project(
      name: "vSuper",
      description:
          "A todo app, with CI/CD automation and Firebase integration.",
      codeUrl: "",
      stars: 4,
      language: "Dart",
      languageColor: Colors.greenAccent,
    ),
    Project(
      name: "QuickGO",
      description:
          "QuickGO is a Kotlin/Java based Android application designed for hyperlocal delivery services, connecting nearby vendors and customers for fast and efficient last-mile delivery. "
          "Built with a focus on real-time order tracking, smooth UI, and reliable backend integration, QuickGO provides a seamless experience for both customers and delivery partners.",
      codeUrl: "https://github.com/vishnusukumar14/quickgo-clients",
      stars: 5,
      language: "Kotlin, Java",
      languageColor: Colors.deepPurpleAccent,
    ),
    Project(
      name: "QuickGO-Backend",
      description:
          "Django backend for QuickGO applications, with advance security and payment integration.",
      codeUrl: "https://github.com/vishnusukumar14/VoiGO-server",
      stars: 5,
      language: "Python, HTML",
      languageColor: Colors.blueAccent,
      isPrivate: true,
    ),

    Project(
      name: "SJCE MAP",
      description:
          "An interactive campus navigation app for SJCE Mysore. Provides real-time location guidance, 360-degree views of campus landmarks.",
      codeUrl: "https://github.com/vishnusukumar14/SJCE-MAP",
      stars: 6,
      language: "Java, XML",
      languageColor: Colors.yellow,
    ),
  ];

  static Future<void> launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Cannot launch URL: $url");
    }
  }
}
