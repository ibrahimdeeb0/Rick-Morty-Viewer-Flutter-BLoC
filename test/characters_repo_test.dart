import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:train_use_bloc_app/data/api_services/characters_api_services.dart';
import 'package:train_use_bloc_app/data/repository/characters_repo.dart';

void main() {
  test('Test CharactersRepo fetching characters', () async {
    Logger logger = Logger();
    CharactersRepo repo = CharactersRepo(CharactersApiServices());
    final characters = await repo.getAllCharacters();
    expect(characters.isNotEmpty, true); // Assert the list is not empty

    logger.t('Repo: Fetched Characters: $characters');
  });
}
