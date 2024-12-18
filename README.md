# advocate_mobile

advocateMobile

## Getting Started

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:

## Build generated files command line

```shell
flutter clean 
flutter pub get
flutter pub run build_runner build # for building generated classes 
```

In conflict run this command -> `--delete-conflicting-outputs`

```shell
# Assume conflicting outputs in the users package are from previous builds,
# and skip the user prompt that would usually be provided.
flutter pub run build_runner build --delete-conflicting-outputs
```

## Run tests

```shell
flutter test
```


### Libraries & Tools Used

* [State Management](https://pub.dev/packages/get) - GetX
* [HTTP Client](https://github.com/flutterchina/dio) - Dio
* [Retrofit](https://github.com/trevorwang/retrofit.dart/) - Dio client generator
* [Json Serialization](https://github.com/dart-lang/json_serializable)
* [RxDart](https://github.com/ReactiveX/rxdart)
* [GoogleFonts](https://github.com/material-foundation/google-fonts-flutter/)
* [Logging](https://pub.dev/packages/get)
* [Freezed](https://github.com/rrousselGit/freezed)

### Folder Structure

Here is the folder structure we have been using in this project

```
lib/
|- data/
    |- server/
        |- api
    |- storage
        |- auth_holder/
        |- app_holder/
        |- tools/
            |- extensions/
            |- styles/
|- domain/
    |- entities/
    |- repositories/
    |- usecases/
|- provider/
    ..
    |- base/
|- views/
    |- pages
    |- widgets
|- injection.dart
|- main.dart
```