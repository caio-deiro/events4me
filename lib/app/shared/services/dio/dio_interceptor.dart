import 'package:dio/dio.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/dio/error/api_error.dart';
import 'package:events4me/app/shared/services/secure_storage/secure_storage_service.dart';
import 'package:events4me/app/shared/services/user/user_service.dart';
import 'package:events4me/app/shared/utils/tools.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomDioInterceptor extends Interceptor {
  final DioService dio;
  CustomDioInterceptor(this.dio);

  var userService = Modular.get<UserService>();
  var appTools = Modular.get<Tools>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Se o token não estiver nulo, significa que o usuário fez o login
    // Então vamos precisar validar se o token está expirado
    if (userService.token != null) {
      // Chamamos a função que retorna um bool se o token está válido ou não
      if (appTools.isTokenExpired(token: userService.token!)) {
        // Com o token inválido, chamamos uma função que pede a API um novo token
        final newtoken = await userService.refreshUserToken();

        // Verificamos se o token que pegamos não está vazio
        if (newtoken.isNotEmpty) {
          // Instanciamos o secure storage para armazenar o token
          final flutterSecure = Modular.get<SecureStorageService>();
          await flutterSecure.storageWrite(key: 'token', value: newtoken);

          // Atribuimos o valor a variável da classe, pegando do storage
          userService.token = await flutterSecure.storageRead(
            key: 'token',
          );

          // Substituimos no header da requisição, passando o token já renovado
          options.headers['Authorization'] = 'Bearer ${userService.token}';
        }
        // Aqui pedimos ao dio pra seguir adiante com a requisição
        return handler.next(options);
      } else {
        // Se o token não estiver expirado, voce apenas passa no header e faz
        // a requisição
        options.headers['Authorization'] = userService.token;
      }
    }

    // Retornamos a request passando todos os parametros ja mudados.
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    var error = err.response?.data;
    if (error is String) {
      error = ApiError(err, error);
    } else if (error is List) {
      error = ApiError(err, error.first);
    }
    return super.onError(error, handler);
  }
}
