<h1 align="center">Vishnu S — Portfolio</h1>


<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Framework-Flutter-blue?logo=flutter" /></a>
  <a href="https://firebase.google.com/"><img src="https://img.shields.io/badge/Backend-Firebase-orange?logo=firebase" /></a>
  <a href="https://github.com/vishnus/portfolio/actions"><img src="https://img.shields.io/github/actions/workflow/status/vishnus/portfolio/deploy.yml?label=CI%2FCD&logo=github" /></a>
  <img src="https://img.shields.io/badge/License-MIT-green" />
</p>
<p align="center">
<img width="100%" height="700" alt="image" src="https://github.com/user-attachments/assets/32371ff7-7eac-4c38-8021-81b2f4a48dc6" />
</p>

<p align="center">
  <strong>Responsive portfolio built with Flutter, powered by Firebase — featuring my projects, journey, and modern UI design.</strong>
</p>


---

## About

This is my **personal portfolio** — a fully responsive web app built with **Flutter** and **Firebase**.  
It highlights my projects, technical skills, and career journey, and includes analytics and automated deployment via CI/CD.

### Highlights
- **Beautiful, modern Flutter UI** with smooth animations  
- **Firebase backend** for hosting and visit tracking  
- **Automated CI/CD** with GitHub Actions  
- **Responsive design** for desktop, tablet, and mobile  
- **Modular architecture** for easy updates and scalability  

---

## Tech Stack

| Layer | Technologies |
|--------|---------------|
| **Frontend** | Flutter (Web + Mobile) |
| **Backend / Hosting** | Firebase |
| **Database** | Firestore |
| **State Management** | Riverpod / Provider |
| **CI/CD** | GitHub Actions |
| **Design** | Material 3 + Custom Animations |

---


## Getting Started

### 1️ Clone the repository
```bash
git clone https://github.com/vishnusukumar14/portfolio.git
cd portfolio
flutter pub get
flutter run -d chrome
flutter build web
firebase deploy (optional)
