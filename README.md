# Quantum IT Assignment by Yashwanth

A Flutter assignment containing Firebase "email & password" and Google authentications, News API fetching.
Please find the [APK](https://drive.google.com/file/d/1v1uP0mw_IYdWUv0QBwinc5LyH9_FTB-j/view?usp=sharing) for testing.

### Project Structure

This project is structured in modules. The main app is present in apps directory. All the implementation code is in `core` and `core_ui` packages under packages directory.
The core package contains all the non UI related code.
The core_ui package contains all the UI related code.
###### Advantages of this code architecture
Code resuability and code organisation. The same packages can be imported to n number of apps.

### Third party packages used:
- **flutter_bloc**: Used for state management.
- **equatable**: Used for comparing objects (especially bloc states).
- **firebase_auth**: Firebase authentication for email and password login and signup.
- **firebase_core**: Supporting package for firebase auth package.
- **google_sign_in**: Used for Google login
- **http**: Used for calling APIs
- **loader_overlay**: Used for displaying progress loader. This will engage user while API is getting called. So that user will not move away or click something while we are fetching data from API.
- **intl**: Used for parsing date from string format.

### TODOs
- Facebook login.
- Adding shell scripts to automate running commands under each package in terminal. Now we have to maually go to each package directory and run commands like `flutter pub get`

### Instructions to run this project
Import this project from root i.e, we should see apps and packages directory in IDE.
then run `flutter pub get` under packages/core and packages/core_ui directories. Then run `flutter pub get` under apps/quantum_it_assignment
Check the configuration file in IDE that should point to `../apps/quantum_it_assignment/lib/main.dart`
Then run the app normaly.