extension StringExtension on String {
  String get capitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get title => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(' ').map((str) => str.capitalized).join(' ');
}
