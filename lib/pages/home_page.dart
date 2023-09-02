import 'package:flutter/material.dart';
import 'package:utranslator/navigation/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Home'),
          centerTitle: true,
        ),
        drawer: const Navigation(),
        body: Center(
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}