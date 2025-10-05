enum AppTheme {
  light(0),
  dark(1);

  final int value;
  const AppTheme(this.value);

  static AppTheme defaultTheme() => AppTheme.light;

  factory AppTheme.fromInt(int value) {
    return AppTheme.values.where((e) => e.value == value).first;
  }

  AppTheme next() {
    return AppTheme.fromInt((value + 1) % AppTheme.values.length);
  }
}
