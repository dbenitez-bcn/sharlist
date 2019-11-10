# Sharlist

Dynamic shopping lists

## Getting Started

- Clone repo from github
- Install dependencies
    > flutter packages get
- Add firebase files
    - Android
        - Go to firebase console and download google-services.json
        - Paste the file inside android/app
    - iOS
        - Go to firebase console and download GoogleServices-info.plist
        - Paste the file inside Runner/Runner
- Add run environment configuration
    - Run > Edit configurations
    - Click on the + button
    - Select flutter
    - Add a name: Run &#60;ENVIRONMENT&#62;
    - Add a dart entrypoint: $PROJECT_PATH/lib/main_&#60;environment&#62;.dart
    - Click on apply and OK
- Add run tests configuration
    - Run > Edit configurations
    - Click on the + button
    - Select flutter test
    - Add a name: Run all test;
    - Set scope as 'All in directory'
    - Add a test directory: $PROJECT_PATH/test/
    - Click on apply and OK
- Run the application

## Build for Android
    > flutter build --apk -t lib/main_<environment>.dart --release
    
## Build for iOS
    > flutter build --ios -t lib/main_<environment>.dart --release
 
