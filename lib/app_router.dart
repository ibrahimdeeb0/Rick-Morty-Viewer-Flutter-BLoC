import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_use_bloc_app/core/string_constants.dart';
import 'package:train_use_bloc_app/data/api_services/characters_api_services.dart';
import 'package:train_use_bloc_app/data/models/characters_model.dart';
import 'package:train_use_bloc_app/data/repository/characters_repo.dart';
import 'package:train_use_bloc_app/logic/cubit/characters_cubit.dart';
import 'package:train_use_bloc_app/ui/screens/characters_details_screen.dart';
import 'package:train_use_bloc_app/ui/screens/home_characters_screen.dart';

class AppRouter {
  late CharactersRepo charactersRepo;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepo = CharactersRepo(CharactersApiServices());
    charactersCubit = CharactersCubit(charactersRepo);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const HomeCharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(
          builder: (_) => CharactersDetailsScreen(
            character: character,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SafeArea(
            child: Center(
              child: Text('the page dos not exist'),
            ),
          ),
        );
    }
  }
}
