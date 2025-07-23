import 'package:flutter/material.dart';

import 'models/experience.dart';
import 'models/project.dart';

class Contents {
  static const myLinkedInUrl = "https://www.linkedin.com/in/vishnus14/";
  static const myGithubUrl = "https://github.com/vishnusukumar14";
  static const myPhoneNumber = "REMOVED_PHONE";
  static const myEmailId = "REMOVED_EMAIL";

  static const myProfilePhotoAssetPath = "assets/1746809048028.jpeg";
  static const linkedInLogoMarkAssetPath = "assets/logos/li_bug_mark.png";
  static const linkedInLogoAssetPath = "assets/logos/li_logo.png";
  static const githubMarkAssetPath = "assets/logos/github_mark.png";
  static const githubLogoAssetPath = "assets/logos/github_logo.png";

  static const heroSectionDescription =
      "I love building performant and scalable applications—whether in Flutter, native Android, Django, or Go—focusing on clean, production-ready code, smooth user experiences, and maintainable architecture, while leveraging CI/CD workflows to streamline build and deployment.";
  static const aboutMeSectionDescription = """
Hi, I’m a versatile software developer with a passion for building fast, reliable, and beautifully crafted digital experiences. I specialize in cross-platform development using Flutter, creating smooth, scalable apps backed by clean architecture and modern state management tools like Riverpod, Bloc, and Provider.
I’ve worked on everything from academic projects to real-world apps during internships and freelance collaborations. I’ve integrated complex features like real-time messaging, secure authentication, and offline-first data persistence using tools such as REST APIs, Firebase, and MongoDB.

In addition to Flutter, I bring hands-on experience in native Android development with Kotlin and Jetpack Compose, enabling me to optimize for platform-specific performance and deliver a seamless user experience.

I also build backends using Python and Django, designing RESTful APIs with solid authentication systems and scalable data models. More recently, I’ve explored Go (Golang), completing projects that focus on high-performance API services and concurrent processing.

To ensure efficient development workflows, I leverage CI/CD pipelines with GitHub Actions, automating testing, builds, and deployments. This lets me ship with confidence and iterate quickly without compromising stability.

Whether I’m refining UI/UX details, debugging tough runtime issues, or optimizing app performance, I take pride in writing clean, maintainable, and production-ready code. And yes—this entire website was built using Flutter too.""";

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
      company: "Swagino's",
      companyProfileUrl:
          "https://www.linkedin.com/company/swaginos/posts/?feedView=all",
      duration: "Feb 2025 – June 2025",
      location: "Remote",
      highlights: [
        " Built cross-platform apps using Flutter, delivering responsive, high-performance UIs. ",
        "Also developed native Android apps using Kotlin and Jetpack Compose for modern UI experiences.",
        " Designed and implemented backend services in Go and Python (Django), applying clean architecture principles to build scalable, modular systems for production use.",
        "Utilized Firebase, FCM, and REST APIs for real-time features and backend integration.",
        "Integrated gRPC-based backend services with Flutter clients to enable real-time messaging, synchronization, and efficient communication across distributed components.",
      ],
      techStack: [
        "Flutter",
        "Dart",
        "Kotlin",
        "Jetpack Compose",
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
        "Kotlin":
            "https://upload.wikimedia.org/wikipedia/commons/0/06/Kotlin_Icon.svg",
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
        "Jetpack Compose":
            "https://logo.svgcdn.com/d/jetpackcompose-original.svg",
      },
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
        "Bypassed traditional data storage using real-time order and inventory management for faster, more efficient operations",
        "Built full-stack applications using Kotlin and Python Django; integrated Google Maps & live tracking.",
        "Implemented pilot deployments, conducted usability testing, and improved system based on feedback.",
      ],
      techStack: [
        "Kotlin",
        "Java",
        "Django",
        "Firebase",
        "MongoDB",
        "JetBrains",
        "REST APIs",
        "Google Maps API",
        "Git",
      ],
      techStackUrls: {
        "Kotlin":
            "https://upload.wikimedia.org/wikipedia/commons/0/06/Kotlin_Icon.svg",
        "Java":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original.svg",
        "Django":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/django/django-plain.svg",
        "Firebase":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/firebase/firebase-plain.svg",
        "JetBrains": "https://logo.svgcdn.com/l/jetbrains-space-icon.svg",
        "MongoDB":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mongodb/mongodb-original.svg",
        "Git":
            "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg",
        "Google Maps API": "https://logo.svgcdn.com/l/google-maps.svg",
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
