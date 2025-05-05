# Movie Matcher

## Table of contents
- [About](#about)
    - [Key features](#key-features)
    - [Backend](#backend)
- [Getting started](#getting-started)
  - [Dependencies](#dependencies)
  - [Dev setup step-by-step](#dev-setup-step-by-step)


## About

This project is a cross-platform mobile application build with Flutter. It fetches popular movies from [The Movie Database](https://www.themoviedb.org/) and presents them in a swipeable card interface. Users can swipe cards to express interest, and matching preferences between users are detected in real time using a custom Dart-based gRPC backend. The project was developed as part of the Cross-platform Mobile Application Development course at Lapland University of Applied Sciences.

With this exercise we practiced:
- Cross-platform mobile application development
- Setting up a Flutter application
- Fetching and parsing data from a REST API
- Implementing real-time communication with gRPC

### Key Features
- **Swipeable Cards**: Browse popular movies and swipe to like or skip.
- **Favourites Matching**: When two users like the same movie, both are notified of the match via a live backend.
- **Environment Configuration**: Uses `.env` files to securely manage API keys.

### Backend

The application includes a gRPC backend written in Dart. The server, defined in `server/server.dart`, listens on port 50051 and handles real-time communication between clients using a bidirectional stream. This backend was originally generated with the help of AI and provided as part of the course.

## Getting started

Instructions on how to set up and run the project.

### Dependencies

This project relies on the following dependencies:

- **flutter**: The core Flutter SDK used to build the application.
- **provider**: ^6.1.2 – A state management solution widely used in Flutter apps.
- **flutter_dotenv**: ^5.2.1 – Loads environment variables from a `.env` file, useful for API keys and configuration.
- **http**: ^1.3.0 – A package for making HTTP requests and handling responses.
- **flutter_card_swiper**: ^7.0.2 – A UI package for creating swipeable cards, similar to Tinder.
- **grpc**: ^4.0.3 – Enables communication with gRPC services using efficient and structured messaging.
- **protobuf**: ^4.0.0 – Supports protocol buffer serialization, often used with gRPC.

Ensure these dependencies are installed to ensure smooth execution of the project.

### Dev Setup Step-by-Step

1. Clone the project
2. Install dependencies with command `flutter pub get`
3. Run the project with two terminals
   - Start the server with command `dart run .\server\server.dart`
   - Start the frontend with command `flutter run`

## Compiling Proto

protoc --dart_out=grpc:lib/generated -Iprotos protos/moviematch.proto