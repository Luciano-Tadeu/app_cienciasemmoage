# 🧪 Ciência sem Moage

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white)

A mobile application designed to demystify and simplify scientific communication. **Ciência sem Moage** brings the general public closer to academic knowledge through an intuitive, dynamic interface focused on rapid video content consumption.

<p align="center">
  <a href="https://www.figma.com/proto/bVGHK5jrEGdaIkFHL4GM1K/App---Ci%C3%AAncia-Sem-Moage?node-id=36-4469" target="_blank">
    <img src="https://i.imgur.com/1gVxSsv.png" alt="Click to see the prototype" width="300"/>
  </a>
  <br><br>
  <a href="https://www.figma.com/proto/bVGHK5jrEGdaIkFHL4GM1K/App---Ci%C3%AAncia-Sem-Moage?node-id=36-4469" target="_blank">
    <img src="https://img.shields.io/badge/👆_Interactive_Demonstration-1E1E1E?style=for-the-badge&logo=figma&logoColor=F24E1E" alt="Demonstration Button"/>
  </a>
</p>

## 🚀 Features

* **Dynamic Video Feed:** Fluid media consumption tailored for science popularization.
* **Optimized UX/UI:** Interface entirely prototyped and pre-tested in Figma, with a strong focus on user retention and experience.
* **High Responsiveness:** Built with the Flutter rendering engine to ensure native-like performance across various screen sizes and devices.

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** Dart
* **Design & Prototyping:** Figma

## 📁 Project Structure

## 📁 Project Structure

The project architecture follows a **Feature-First** approach, a modern Flutter best practice for maintainability and separation of concerns:

* `/lib`: Contains the main Dart source code.
  * `/core`: Core configurations and app-wide constants, such as dynamic theming and customized color palettes (`/theme`).
  * `/features`: Encapsulates the application's functionalities by domain (e.g., `home`, `navigation`, `search`, `video_feed`). Each feature is completely independent, containing its own specific `/screens`, `/widgets`, and local logic.
  * `/models`: Data structures and business objects, such as the `Video` entity used for API serialization.
  * `/shared`: Global, reusable UI components (like custom headers, state controllers, and common badges) that are utilized across multiple different features.
  * `main.dart`: The entry point of the application.
* `/assets`: Static images, fonts, and icons used throughout the app.

## ⚙️ Getting Started

To run this project locally, you will need the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine, along with an emulator (Android/iOS) or a physical device configured for debugging.

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/Luciano-Tadeu/Ciencia-sem-Moage.git](https://github.com/Luciano-Tadeu/Ciencia-sem-Moage.git)
