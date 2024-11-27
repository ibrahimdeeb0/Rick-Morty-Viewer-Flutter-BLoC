import 'package:flutter/material.dart';
import 'package:train_use_bloc_app/core/app_colors.dart';
import 'package:train_use_bloc_app/data/models/characters_model.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final CharactersModel character;
  const CharactersDetailsScreen({
    super.key,
    required this.character,
  });

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name ?? '',
          style: const TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo({
    required String title,
    required String value,
  }) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title: ',
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                        title: 'Name',
                        value: character.name ?? '...',
                      ),
                      buildDivider(333),
                      characterInfo(
                        title: 'Gender',
                        value: character.gender ?? '...',
                      ),
                      buildDivider(322),
                      characterInfo(
                        title: 'Status',
                        value: character.status ?? '...',
                      ),
                      buildDivider(326),
                      characterInfo(
                        title: 'Species',
                        value: character.species ?? '...',
                      ),
                      buildDivider(315),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          characterInfo(
                            title: 'Type',
                            value: character.type!,
                          ),
                          buildDivider(340),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 510)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
