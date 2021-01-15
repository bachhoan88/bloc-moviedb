# Flutter Movie App
The design copied from `Lisa Martinovska`
![alt text](https://cdn.dribbble.com/users/1567880/screenshots/5026483/dribbble.png "Resoure")

## Assets (Design & API)
- [Design](https://dribbble.com/shots/5026483-Netflix-Mobile-App-Redesign/attachments)
- [API](https://developers.themoviedb.org/3/movies/get-movie-images)

## Architecture
Project using BLoC Design Pattern
- [BloC](https://bloclibrary.dev/#/)
- [CookBook](https://flutter.dev/docs/cookbook)

### Building
- Work from Android Studio 3.5 and above
- Using AndroidX for Android
- Using the Material Design

### Run Test & Coverage
- Run Unit Test
`flutter test --coverage ./lib`

- Using the [LCOV][17] for calculate code coverage

```genhtml -o coverage coverage/lcov.info
open coverage/index-sort-l.html```

### Libraries used
- [Resource localizations][10] . the user’s preferred language
- [Cupertino Icons][11] . Default icons asset for Cupertino widgets based on Apple styled icons
- [Shared preferences][12] . Flutter plugin for reading and writing simple key-value pairs. Wraps NSUserDefaults on iOS and SharedPreferences on Android.
- [SQL][13] . self-contained, high-reliability, embedded, SQL database engine.
- [Permission][14] . This plugin provides a cross-platform (iOS, Android) API to request and check permissions.
- [Connectivy][15] . Discovering the state of the network (WiFi & mobile/cellular) connectivity on Android and iOS.
- [Carousel Slider][16] . A carousel slider widget, support infinite scroll and custom child widget.

[10]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[11]: https://pub.dev/packages/cupertino_icons
[12]: https://pub.dev/packages/shared_preferences
[13]: https://pub.dev/packages/sqflite
[14]: https://pub.dev/packages/permission_handler
[15]: https://pub.dev/packages/connectivity
[16]: https://pub.dev/packages/carousel_slider
[17]: https://github.com/linux-test-project/lcov