# Мобильное проиложение МИИГАиК

Мобильное приложение Московского Государственного Университета Геодезии и Картографии

## Технологический стек

- Flutter
- Dart
- Bloc

### Запуск
Предварительно необходимо создать и скопировать содержимое из `config/example.env` в `config/.env`. 
Ключ `APPMETRICA` можно оставить пустым.
```
flutter run --dart-define-from-file=config/.env
```

Для сборки релиза необходимо выполнить команду:
```
flutter build apk --release --obfuscate --dart-define-from-file=config/.env --split-debug-info=build/symbols
```
 
### Зависимости
Перечень основных зависимостей
```
flutter_bloc: ^9.1.1
dio: ^5.9.0
hive: ^2.2.3
easy_localization: ^3.0.8
get_it: ^8.2.0
talker_flutter: ^5.0.1
```
Детальнее про все зависимости можно посмотреть в файле pubspec.yaml

## Функционал
Скоро...

## Разработка

### Запуск
Для запуска исходного кода вам понадобится:
- [Flutter SDK](https://docs.flutter.dev/install) - разработка велась на версии 3.32.8, о работоспособности на других версиях не известно!
- [Android Studio](https://docs.flutter.dev/tools/android-studio) - cреда разработки (разработка велась в Android Studio Narwhal 3 Feature Drop | 2025.1.3, но можно и Visual Studio Code)

Для запуска приложение необходимо установить эмулятор или подключить физическое устройство, [подробнее](https://docs.flutter.dev/platform-integration/android/setup) о настройке Android Studio для разработки под Flutter.

Чтобы запустить приложение необходимо выполнить main.dart, либо через GUI Android Studio, либо командой:
```
flutter run lib/main.dart
```

### Зависимости разрабоки
```
dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^5.0.0
  flutter_launcher_icons: ^0.14.4
  icon_font_generator: ^4.0.0
```
Детальнее про зависимости для разработки можно посмотреть в файле [pubspec.yaml](https://github.com/team4-sad/flutter-mobile-client/blob/main/pubspec.yaml).

### Генерация
В рамках приложения используется генерация иконочного шрифта, иконки приложения и перевода.

#### Иконочный шрифт
Иконочный шрифт генерируется через библиотеку icon_font_generator - преобразование [набора файлов svg](https://github.com/team4-sad/flutter-mobile-client/tree/main/assets/icons/raw) в [шрифт формата otf](https://github.com/team4-sad/flutter-mobile-client/blob/main/assets/icons/icons.otf) c генерацией [dart файла разметки](https://github.com/team4-sad/flutter-mobile-client/blob/main/lib/generated/icons.g.dart).
Конфигурация генерации иконочного шрифта указанна в файле [icon_font.yaml](https://github.com/team4-sad/flutter-mobile-client/blob/main/icon_font.yaml).
Чтобы сгенерировать иконочный шрифт необходимо выполнить команду:
```
dart run icon_font_generator:generator --config-file=icon_font.yaml 
```

#### Иконка приложения
Генерация иконки приложения происходит через бибилотеку flutter_launcher_icons. Конфигурация иконки находится в файле [icon_font.yaml](https://github.com/team4-sad/flutter-mobile-client/blob/main/flutter_launcher_icons).
Генерация иконки позволяет сэкономить время, т.к. иначе приходилось бы самостоятельно редатировать исходный код каждой поддерживаемой платформы, в которых смена иконки реализована по разному.

Для генерации иконки необходимо выполнить команду:
```
dart run flutter_launcher_icons
```
#### Перевод
Для кодогенерации строковых ключей на разных языках используется библиотека easy_localization. [Языковые json файлы](https://github.com/team4-sad/flutter-mobile-client/tree/main/assets/translations) преобразовываются в [dart класс](https://github.com/team4-sad/flutter-mobile-client/blob/main/lib/generated/translations.g.dart) c ключами через команду:
```
dart run easy_localization:generate --source-dir=assets/translations --format=keys --output-dir=lib/generated/ --output-file=translations.g.dart 
```
