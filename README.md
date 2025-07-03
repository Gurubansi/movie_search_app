
🎬 Movie Search App
Overview
The Movie Search App is a Flutter-based mobile application that allows users to browse popular movies and search for movies by title. The app is designed to work on both iOS and Android platforms, providing a seamless user experience with platform-specific UI elements. It fetches movie data from the IMDb API hosted on RapidAPI, displays movie details such as titles and ratings, and includes a recent searches feature to enhance user interaction.
Features

Browse Popular Movies: View a list of currently popular movies fetched from the IMDb API.
Search Movies: Search for movies by title with results displayed in a grid view.
Recent Searches: Save and display up to 5 recent search queries using SharedPreferences for quick access.
Platform-Specific UI: Utilizes Cupertino widgets for iOS and Material Design for Android, ensuring a native look and feel.
Responsive Design: Grid-based movie display adapts to different screen sizes.
Error Handling: Displays appropriate messages for network errors or when no movies are found.
Image Caching: Uses the cached_network_image package to efficiently load and cache movie poster images.

Android release APK : https://we.tl/t-fDBQmG2qMQ (link is valid for 3 days)

Ios release:- https://we.tl/t-33UOWCT4Bd  
(link is valid for 3 days)

API Usage
The app integrates with the IMDb API hosted on RapidAPI to fetch movie data. The API provides two main endpoints used in this project:

Most Popular Movies: Retrieves a list of popular movies.
Endpoint: https://imdb236.p.rapidapi.com/api/imdb/most-popular-movies

Search Movies: Searches for movies based on the provided title.
Endpoint: https://imdb236.p.rapidapi.com/api/imdb/search?originalTitle={query}&type=movie

Project Structure
The project is organized as follows:

lib/: Contains the main source code.
services/:
models/: Data models for popular movies (popular_movie_model.dart) and search results (search_result_model.dart).
providers/: Contains movie_provider.dart, which handles API calls, state management, and recent searches.
utils/: Includes app_color.dart for app-wide color constants.
main.dart: Entry point of the application.
HomePage.dart: Main UI component for displaying the home screen with search and movie grid.
pubspec.yaml: Lists dependencies such as flutter, provider, http, cached_network_image, and shared_preferences.

Dependencies
The app relies on the following Flutter packages:

flutter: For core Flutter framework.
provider: ^6.0.0: For state management.
http: ^1.0.0: For making HTTP requests to the IMDb API.
cached_network_image: ^3.0.0: For efficient image loading and caching.
shared_preferences: ^2.0.0: For storing recent search queries locally.

To install dependencies, run:
flutter pub get

Prerequisites
To run the project, ensure you have the following:

Flutter SDK: Version 2.17.0 or higher.
Dart: Compatible with the Flutter version.
IDE: Android Studio, VS Code, or any IDE with Flutter support.
Emulator/Simulator or Physical Device: For testing on iOS or Android.
RapidAPI Account: To obtain an API key for IMDb API access.


Usage:
Home Screen: On launch, the app displays a list of popular movies in a grid view.
Search: Enter a movie title in the search bar to fetch and display matching results.
Recent Searches: Tap on a recent search chip to re-run a previous search, or delete a chip to remove it from recent searches.
Platform Differences:
iOS: Uses Cupertino widgets (e.g., CupertinoPageScaffold, CupertinoSearchTextField) for a native iOS experience.
Android: Uses Material Design widgets (e.g., Scaffold, TextField) for a native Android experience.

Screenshots: ( Android )  ![Image](https://github.com/user-attachments/assets/3f2e6904-be02-4249-997c-bbab9f5fe6bf)
![Image](https://github.com/user-attachments/assets/4d252f35-ad0d-4e6c-9708-762ed9fa6ba5)
![Image](https://github.com/user-attachments/assets/76af3a2a-7316-4098-a367-8817658da315)

IOS :- ![Image](https://github.com/user-attachments/assets/c448461d-6224-4659-995d-25e6fe71faef)
<img width="447" alt="Image" src="https://github.com/user-attachments/assets/9e2c9cef-267a-424f-8bfa-c1124eac9099" />


Limitations:
The app is limited by the RapidAPI IMDb API's free tier, which has request quotas.
Only basic movie details (title, rating, poster) are displayed due to API response constraints.
No offline mode is implemented; an internet connection is required.

