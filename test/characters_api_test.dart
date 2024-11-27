import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:train_use_bloc_app/data/api_services/characters_api_services.dart';

void main() {
  test('Test CharactersRepo fetching characters', () async {
    Logger logger = Logger();

    CharactersApiServices apiService = CharactersApiServices();
    final result = await apiService.getAllCharacters();

    logger.t('API Service Result: $result');
  });
}
