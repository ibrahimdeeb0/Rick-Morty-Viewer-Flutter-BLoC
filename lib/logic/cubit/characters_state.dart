part of 'characters_cubit.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharactersModel> listOfCharacters;

  CharactersLoaded(this.listOfCharacters);
}
