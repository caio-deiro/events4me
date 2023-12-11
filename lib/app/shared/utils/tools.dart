import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class Tools {
  Tools._();
  static final Tools instance = Tools._();

  Future<String?> get getImagePath async {
    final picker = ImagePicker();
    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery);

    String? pathImage = imagem?.path;
    return pathImage;
  }

  Future<FormData> createFormData({required FormData formData}) async {
    return formData;
  }

  bool isTokenExpired({required String token}) {
    // As 3 partes do token são separadas por pontos (.)
    // O metodo split quebra o token em 3 partes e o transforma em uma lista
    final parts = token.split('.');

    // Queremos a segunda parte que splitamos, pois é nela que contem o Payload
    // Payload é a parte do JWT que contem as infos do user, e do token.
    final payload = parts[1];

    // Chamamos a função na imagem ao lado para decodificar esse token
    final stringDecoded = decodedBase64(payload);

    // A função retorna um json em forma de String
    // Apenas decodificamos a string, e assim finalmente temos um Json
    final Map<String, dynamic> payloadMap = json.decode(stringDecoded);

    // Na chave EXP contém a info a respeito de quando o token expira
    final exp = payloadMap['exp'] as int;

    // Pegamos o tempo atual que estamos e armazenamos em uma variável
    final currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Aqui comparamos o tempo de expiração do token, com o tempo atual
    // Caso o exp seja menor que o tempo atual, o token está expirado.
    return exp < currentTimeInSeconds;
  }

  String decodedBase64(String string) {
    // Os caracteres suportados em base64 são apenas + e /
    // Então fazemos o replace, para evitar erros.
    String output = string.replaceAll('-', '+').replaceAll('-', '/');

    // Esse switch serve apenas para identificar o tamanho do token
    // E garantir que ele seja multiplo de 4. Para isso, adicionamos '=' ou '=='
    // Apenas para deixar o token do tamanho certo.
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        // ignore: avoid_print
        print('Erro ao decodificar Token!');
    }

    // Após garantir que ele tem o tamanho certo, fazemos o decode e retornamos
    // Uma string
    return utf8.decode(base64Url.decode(output));
  }

  String getErrorFromFirebaseAuth(String error) {
    switch (error) {
      case "ERROR_INVALID_EMAIL":
        return "Your email address appears to be malformed.";
      case "ERROR_WRONG_PASSWORD":
        return "Your password is wrong.";
      case "ERROR_USER_NOT_FOUND":
        return "User with this email doesn't exist.";
      case "ERROR_USER_DISABLED":
        return "User with this email has been disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests. Try again later.";
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Signing in with Email and Password is not enabled.";
      default:
        return "An undefined Error happened.";
    }
  }
}
