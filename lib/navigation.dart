import 'package:flutter/material.dart';
import 'package:utranslator/about_page.dart';
import 'package:utranslator/configuration_page.dart';
import 'package:utranslator/home_page.dart';
import 'package:utranslator/phrase_page.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: ExactAssetImage('assets/images/Logo.png'),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'U-translator',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 12,
          ),
        ]),
      );

  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 8,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage())),
          ),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Frases'),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PhrasePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text('Premium'),
            onTap: () {},
          ),
          const Divider(color: Colors.black54),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ConfigPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.short_text),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
        ],
      ));
}
