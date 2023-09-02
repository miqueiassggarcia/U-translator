import 'package:flutter/material.dart';

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