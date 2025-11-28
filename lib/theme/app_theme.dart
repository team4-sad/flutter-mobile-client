enum AppTheme {
  light(0, "Светлая"),
  dark(1, "Темная");

  final int value;
  final String name;
  const AppTheme(this.value, this.name);

  static AppTheme defaultTheme() => AppTheme.light;

  factory AppTheme.fromInt(int value) {
    return AppTheme.values.where((e) => e.value == value).first;
  }

  AppTheme next() {
    return AppTheme.fromInt((value + 1) % AppTheme.values.length);
  }
}
