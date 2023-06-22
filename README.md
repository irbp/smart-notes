<p align="center">
  <img src="images/smart_notes_logo.png" alt="Smart Notes Logo" width="200">
</p>

# Smart Notes 📝

Smart Notes is a Flutter project developed for learning purposes. It allows users to create and view notes through a list-based interface. The app also features a Dark Mode for enhanced user experience.

## Architecture 🏛️

The project follows the principles of Clean Architecture, separating it into three layers: domain, data, and presentation.

### Domain Layer 🧠

The domain layer contains the core business logic of the application. It includes the following components:

- **Entities**: Define the data models and business entities of the application.
- **Use Cases**: Implement the application's business rules and orchestrate data flow.

### Data Layer 💾

The data layer is responsible for handling data persistence and storage. It includes the following components:

- **Repositories**: Provide an abstraction for data access and define the contract for interacting with data sources.
- **Data Sources**: Implement the specific data storage mechanisms, such as local databases or APIs.
- **Models**: Define the data models used for serialization and deserialization.

### Presentation Layer 🖥️

The presentation layer manages the user interface and user interactions. It includes the following components:

- **Pages**: Display the UI to the user and handle user input.
- **BLoCs**: Manage the state and business logic for each screen using the BLoC pattern.
- **Views**: Reusable UI components used across screens.

## Packages Used 📦

The following packages were used in this project:

- **[mocktail](https://pub.dev/packages/mocktail)**: A package for mocking dependencies during unit tests.
- **[hive](https://pub.dev/packages/hive)**: A lightweight and fast key-value database for data persistence.
- **[bloc](https://pub.dev/packages/bloc)** and **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: Packages for state management using the BLoC pattern.
- **[bloc_test](https://pub.dev/packages/bloc_test)**: A package for testing BLoCs and their interactions.
- **[get_it](https://pub.dev/packages/get_it)**: A package for dependency injection and service location.

## Screenshots 📷

Add screenshots or GIFs showcasing your app's features. You can include code snippets as well.

## Installation ⚙️

1. Clone the repository:

```console
git clone https://github.com/irbp/smart-notes
```

2. Navigate to the project directory:

```console
cd smart_note
```

3. Install the dependencies:

```console
flutter pub get
```

4. Run the app:

```console
flutter run
```

## Testing 🧪

To run the unit tests, use the following command:

```console
flutter test
```

## Contributing 🤝

Contributions are welcome! If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request.
