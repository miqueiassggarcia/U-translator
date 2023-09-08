import 'package:flutter/material.dart';

class HomePageInitialText extends StatelessWidget {
  const HomePageInitialText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Use o botão no canto inferior direito',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'e abra o seu primeiro arquivo',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}