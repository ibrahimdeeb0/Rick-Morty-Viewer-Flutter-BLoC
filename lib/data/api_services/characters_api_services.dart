import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:train_use_bloc_app/core/string_constants.dart';

class CharactersApiServices {
  late Dio _dio;

  Logger logger = Logger();

  CharactersApiServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    _dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await _dio.get('character');
      // print(response.data['results'].toString());
      return response.data['results'];
    } catch (e) {
      // print(e.toString());
      return [];
    }
  }

 
}
