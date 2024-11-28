import 'package:flutter/material.dart';
import 'package:train_use_bloc_app/core/app_colors.dart';
import 'package:train_use_bloc_app/core/string_constants.dart';
import 'package:train_use_bloc_app/data/models/characters_model.dart';

class CharacterItem extends StatelessWidget {
  final CharactersModel character;
  const CharacterItem({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadiusDirectional.all(Radius.circular(8)),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreen,
            arguments: character),
        child: Hero(
          tag: character.id,
          child: GridTile(
            footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                '${character.name}',
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            child: Container(
              color: MyColors.myGrey,
              child: character.image == null || character.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      placeholder: 'assets/images/loading_animation.gif',
                      image: character.image!,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                        'assets/images/image_placeholder.png',
                        fit: BoxFit.contain,
                      ),
                    )
                  : Image.asset(
                      'assets/images/image_placeholder.png',
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
