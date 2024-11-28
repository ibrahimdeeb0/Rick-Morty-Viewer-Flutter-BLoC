import 'package:flutter/material.dart';
import 'package:train_use_bloc_app/core/app_colors.dart';

Widget showLoadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      color: MyColors.myYellow,
    ),
  );
}

Widget buildAppBarTitle() {
  return const Text(
    'Characters',
    style: TextStyle(color: MyColors.myGrey),
  );
}

Widget buildNoInternetWidget() {
  return Center(
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Can\'t connect .. check internet',
            style: TextStyle(
              fontSize: 22,
              color: MyColors.myGrey,
            ),
          ),
          Image.asset('assets/images/no_internet.png')
        ],
      ),
    ),
  );
}
