# sharlist

Dynamic shopping lists

## Getting Started

- Pull repo from github
- Install dependencies
    > flutter packages get
- Add run environment configuration
    - Run > Edit configurations
    - Click on the + button
    - Select flutter
    - Add a name: Run &#60;ENVIRONMENT&#62;
    - Add a dart entrypoint: $PROJECT_PATH/main_&#60;environment&#62;.dart
    - Click on apply and OK
- Run the application

## Build for Android
    > flutter build --apk -t lib/main_<environment>.dart --release
    
## Build for iOS
    > flutter build --ios -t lib/main_<environment>.dart --release
 