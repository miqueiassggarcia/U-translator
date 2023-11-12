import 'package:flutter/material.dart';
import 'package:utranslator/pages/about_page.dart';
import 'package:utranslator/pages/configuration_page.dart';
import 'package:utranslator/pages/initial_page.dart';

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 8,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const InitialPage())),
          ),
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