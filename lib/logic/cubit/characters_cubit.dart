import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:train_use_bloc_app/data/models/characters_model.dart';
import 'package:train_use_bloc_app/data/repository/characters_repo.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  Logger logger = Logger();
  List<CharactersModel> characters = [];
  CharactersRepo charactersRepo;

  CharactersCubit(this.charactersRepo) : super(CharactersInitial());
  List<CharactersModel> getAllCharacters() {
    charactersRepo.getAllCharacters().then(
      (characters) {
        logger.d("Cubit: Fetched characters: $characters");
        this.characters = characters;
        emit(CharactersLoaded(characters));
      },
    ).catchError((error) {
      logger.e("Cubit: Error fetching characters: $error");
    });
    return characters;
  }
}
