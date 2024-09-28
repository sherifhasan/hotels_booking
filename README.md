# Hotel Booking App <img src="https://img.shields.io/badge/made%20with-dart-blue.svg" alt="made with dart"> <img src="https://img.shields.io/badge/platform-android%20|%20iOS%20|%20macOS-green" alt="platform support">

The **Hotel Booking App** is designed to help users browse, and favorite hotels across various
locations. It follows **Model–view–viewmodel (MVVM)** and **clean architecture** principles for a
modular and scalable structure, **BLoC (Business Logic Component)** pattern for state management,
and **GetIt** for dependency injection. The project is structured around best practices to ensure
maintainability, scalability, and ease of testing.

## Hotel App demo

![AppDemo](demo/demo.gif)

## Key Features

### Hotel Listing

- Displays a comprehensive list of hotels with details like name, price, and room features.

### Hotel Card

Each hotel card includes:

- Hotel name
- Hotel image
- Hotel price (total and per person)
- Room details (e.g., room type, boarding)
- Rating score and number of reviews

### Favorites

- Add hotels to a favorites list by tapping the heart icon.
- Manage your favorite hotels directly from the Favorites tab.
- Persist favorite hotels using **Hive** for local storage.

### Error Handling

- Displays appropriate error messages when hotel data fails to load.

### Empty State

- Shows an empty state when no hotels match the search criteria.

---

## Technical Overview

### Architecture

1. Model-View-ViewModel (MVVM) separates domain logic from framework-specific code, leading to a
   modular and maintainable architecture.
2. Following **clean architecture** principles to ensure scalability, testability, and flexibility.

### State Management

- Using [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management to achieve
  separation of concerns, reactive updates, and a clean codebase.

### Dependency Injection

- **[GetIt](https://pub.dev/packages/get_it)** is used for dependency injection, simplifying the
  management of dependencies and improving testability and modularity.

### JSON Parsing

- [Freezed](https://pub.dev/packages/freezed) is used
  with [JSON Serializable](https://pub.dev/packages/json_serializable) to generate immutable data
  classes and handle serialization/deserialization.

### Testing

- **[Mocktail](https://pub.dev/packages/mocktail)**: Provides an expressive API for creating and
  verifying mock objects in unit tests.
- **[bloc_test](https://pub.dev/packages/bloc_test)**: Simplifies testing BLoC/Cubit logic by
  providing tools to simulate actions and verify state transitions.

### Key Packages

- **flutter_bloc**: For managing state transitions using the BLoC pattern.
- **get_it**: For dependency injection and service locator functionality.
- **freezed**: For creating immutable data classes and handling union types.
- **hive**: For local storage of favorite hotels.

---

## Platforms Tested

This application has been tested on the following platforms:

- **Android**
- **iOS**
- **macOS**

---

## Folder Structure

```bash
.
├── application
│   ├── favourite
│   │   ├── favourite_cubit.dart
│   │   ├── favourite_cubit.freezed.dart
│   │   └── favourite_state.dart
│   └── hotel
│       ├── hotel_cubit.dart
│       ├── hotel_cubit.freezed.dart
│       └── hotel_state.dart
├── domain
│   ├── app_repository.dart
│   ├── entities
│   │   ├── hotel_entity.dart
│   │   └── hotel_entity.freezed.dart
│   ├── failure.dart
│   └── usecases
│       ├── favourite
│       │   ├── add_to_favourites_use_case.dart
│       │   ├── favourite_usecases.dart
│       │   ├── get_favourites_use_case.dart
│       │   └── remove_from_favourites_use_case.dart
│       └── hotel
│           └── fetch_hotels_use_case.dart
├── infrastructure
│   ├── app_repository_imp.dart
│   ├── datasources
│   │   ├── favourite_local_data_source.dart
│   │   └── hotels_remote_data_source.dart
│   ├── dto_models
│   │   ├── hotel_dto.dart
│   │   ├── hotel_dto.freezed.dart
│   │   └── hotel_dto.g.dart
│   ├── error_handlers
│   │   └── dio_error_handler.dart
│   └── storage
│       ├── hotel_database_model.dart
│       └── hotel_database_model.g.dart
├── main.dart
├── presentation
│   ├── app_theme.dart
│   ├── router
│   │   ├── app_router.dart
│   │   └── app_router.gr.dart
│   └── screens
│       ├── account_screen.dart
│       ├── bottom_nav_screen.dart
│       ├── favourites_screen.dart
│       ├── hotels_screen.dart
│       ├── overview_screen.dart
│       ├── screens.dart
│       └── widgets
│           ├── hotel_card.dart
│           ├── hotel_details.dart
│           └── rating_badge.dart
└── setup.dart

```

---

## How to Run the Project

### Prerequisites

- Flutter SDK: Make sure you have [Flutter installed](https://flutter.dev/docs/get-started/install)
  on your machine.

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/hotel_booking_app.git
   cd hotel_booking_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate output files**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```