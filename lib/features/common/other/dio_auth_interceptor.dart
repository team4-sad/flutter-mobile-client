import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/profile/storages/session_storage.dart';

class DioAuthInterceptor extends Interceptor {

  final SessionStorage _storage;

  DioAuthInterceptor({SessionStorage? storage}):
        _storage = storage ?? GetIt.I.get();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("Authorization")){
      try {
        final session = await _storage.getSession();
        if (session != null){
          options.headers["Authorization"] = session.accessToken;
        }
        handler.next(options);
      } on Object catch(e){
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.cancel,
            response: Response(
                requestOptions: options,
                data: e,
                statusCode: HttpStatus.unauthorized
            )
          ),
        );
      }
    }else{
      handler.next(options);
    }
  }
}