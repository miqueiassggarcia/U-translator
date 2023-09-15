import 'package:flutter/material.dart';

class PhrasePageBody extends StatelessWidget {
  const PhrasePageBody({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Selecione frases em seus PDF',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'para que elas aparecam aqui',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
  );
}
