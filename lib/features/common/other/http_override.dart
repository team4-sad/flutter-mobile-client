import 'dart:io';

class BadCertificateHttpOverrides extends HttpOverrides{
  static void setup(){
    HttpOverrides.global = BadCertificateHttpOverrides();
  }

  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}