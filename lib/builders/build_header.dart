import 'package:flutter/material.dart';

Widget buildHeader(BuildContext context) => Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: const Column(children: [
        Image(
          image: ExactAssetImage('assets/images/Logo.png'),
        ),
        Text(
          'U-translator',
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 12,
        ),
      ]),
    );
