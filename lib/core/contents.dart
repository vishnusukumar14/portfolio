import 'package:flutter/material.dart';
import 'package:portfolio_app/core/constants.dart';

import 'models/experience.dart';
import 'models/project.dart';

class Contents {
  static const myLinkedInUrl = "https://www.linkedin.com/in/vishnus14/";
  static const myGithubUrl = "https://github.com/vishnusukumar14";
  static const myPhoneNumber = Constants.myPhoneNumber;
  static const myEmailId = Constants.myEmailId;

  static const myProfilePhotoAssetPath = "assets/images/1746809048028.jpeg";
  static const linkedInLogoMarkAssetPath = "assets/logos/li_bug_mark.png";
  static const linkedInLogoAssetPath = "assets/logos/li_logo.png";
  static const githubMarkAssetPath = "assets/logos/github_mark.png";
  static const githubLogoAssetPath = "assets/logos/github_logo.png";

  static const heroSectionDescription =
      "I love building performant and scalable applications—whether in Flutter, native Android, Django, on clean, production-ready code, smooth user experiences, and maintainable architecture, while leveraging CI/CD workflows to streamline build and deployment.";
  static const aboutMeSectionDescription = """
Hi, I’m a versatile software developer with a passion for building fast, reliable, and beautifully crafted digital experiences. I specialize in cross-platform development using Flutter, creating smooth, scalable apps backed by clean architecture and modern state management tools like Riverpod, Bloc, and Provider.
I’ve worked on everything from academic projects to real-world apps during internships and freelance collaborations. I’ve integrated complex features like real-time messaging, secure authentication, and offline-first data persistence using tools such as REST APIs, Firebase, and MongoDB.

I also build backends using Python and Django, designing RESTful APIs with solid authentication systems and scalable data models. More recently, exploring Go (Golang), completing projects that focus on high-performance API services and concurrent processing.

To ensure efficient development workflows, I leverage CI/CD pipelines with GitHub Actions, automating testing, builds, and deployments. This lets me ship with confidence and iterate quickly without compromising stability.

Whether I’m refining UI/UX details, debugging tough runtime issues, or optimizing app performance, I take pride in writing clean, maintainable, and production-ready code. And yes—this entire website was built using Flutter too.""";

  static const projectSectionDescription =
      "Explore my personal projects — from Flutter apps to native Kotlin builds, often using Firebase, MongoDB, Maps API, and gRPC. I focus on clean architecture and smooth UX. Check out more on my GitHub.";

  static final experiences = [
    Experience(
      title: "Freelance Developer",
      company: "Remote",
      duration: "Feb 2025 – June 2025",
      location: "Remote",
      highlights: [
        " Built cross-platform apps using Flutter, delivering responsive, high-performance UIs. ",
        " Designed and implemented backend services in Python (Django), applying clean architecture principles to build scalable, modular systems for production use.",
        "Utilized Firebase, FCM, and REST APIs for real-time features and backend integration.",
      ],
      techStack: [
        "Flutter",
        "Dart",
        "Python",
        "Django",
        "Git Actions",
        "gRPC",
        "Firebase",
        "Git",
      ],
      // Custom URLs for tech stack icons with fallback to assets
      techStackUrls: {
        "Flutter":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg",
        "Dart":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg",
        "Python":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg",
        "Git Actions": "https://logo.svgcdn.com/l/github-actions.svg",
        "Django":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/django/django-plain.svg",
        "Firebase":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/firebase/firebase-plain.svg",
        "Git":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg",
        "gRPC": "https://logo.svgcdn.com/l/grpc.svg",
      },
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
      name: "Portfolio Web App",
      description:
          "A responsive portfolio built with Flutter, powered by Firebase. Features smooth animations, modern UI, project showcases, contact form, visit tracking, and mobile-first design. CI/CD pipeline enabled for automated build and deploy.",
      codeUrl: "https://github.com/vishnusukumar14/portfolio",
      stars: 12,
      language: "Dart, HTML",
      languageColor: Colors.greenAccent,
    ),
    Project(
      name: "QuickGO",
      description:
          "QuickGO is a Kotlin/Java based Android application designed for hyperlocal delivery services, connecting nearby vendors and customers for fast and efficient last-mile delivery. "
          "QuickGO provides a seamless experience for both customers and delivery partners.",
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
}
