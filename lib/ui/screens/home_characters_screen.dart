import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_use_bloc_app/core/app_colors.dart';
import 'package:train_use_bloc_app/data/models/characters_model.dart';
import 'package:train_use_bloc_app/logic/cubit/characters_cubit.dart';
import 'package:train_use_bloc_app/ui/screens/widgets/body_widgets.dart';
import 'package:train_use_bloc_app/ui/widgets/character_item.dart';

class HomeCharactersScreen extends StatefulWidget {
  const HomeCharactersScreen({super.key});

  @override
  State<HomeCharactersScreen> createState() => _HomeCharactersScreenState();
}

class _HomeCharactersScreenState extends State<HomeCharactersScreen> {
  List<CharactersModel> allCharacters = [];
  late List<CharactersModel> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  //*-------------
  //! No internet Function

  bool _isInternetConnect = false;

  //*------------

  @override
  void initState() {
    super.initState();

    allCharacters =
        BlocProvider.of<CharactersCubit>(context).getAllCharacters();

    StreamSubscription<List<ConnectivityResult>> _listenToNetworkStatus =
        Connectivity()
            .onConnectivityChanged
            .listen((List<ConnectivityResult> result) {
      setState(() {
        _isInternetConnect = !result.contains(ConnectivityResult.none);
      print('Connectivity changed: $result');
      });
      // ignore: avoid_print
    });
  }

  //*--------------
  //? App Bar Functions

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }
  //*--------------

  //*--------------
  //? Body Functions
  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).listOfCharacters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  //*--------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: _isInternetConnect ? buildBlocWidget() : buildNoInternetWidget(),
    );
  }
}
