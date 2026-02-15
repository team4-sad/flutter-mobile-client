class Config {
  static const String apiUrl = String.fromEnvironment("API_URL");
  static const String baseImageUrl = String.fromEnvironment("BASE_IMAGE_URL");
  static const String scheduleApiUrl = String.fromEnvironment("SCHEDULE_API_URL");
  static const String webWiewUrlSpravki = String.fromEnvironment("WEBVIEW_URL_EDINI_DEKANAT_SPRAVKI");
  static const String webWiewUrlDopuski = String.fromEnvironment("WEBVIEW_URL_EDINI_DEKANAT_DOPUSKI");
  static const String webWiewUserAgent = String.fromEnvironment("WEBVIEW_USER_AGENT");
  static const String appmetricaApiKey = String.fromEnvironment("APPMETRICA");
}
