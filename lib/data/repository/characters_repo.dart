import 'package:train_use_bloc_app/data/api_services/characters_api_services.dart';
import 'package:train_use_bloc_app/data/models/characters_model.dart';

class CharactersRepo {
  final CharactersApiServices charactersApiServices;

  CharactersRepo(this.charactersApiServices);

  Future<List<CharactersModel>> getAllCharacters() async {
    final List<dynamic> char = await charactersApiServices.getAllCharacters();
    // print('CharactersRepo: ${char.toString()}');

    return char.map((item) => CharactersModel.fromJson(item)).toList();
  }
}
