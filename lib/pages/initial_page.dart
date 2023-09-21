import 'package:flutter/material.dart';
import 'package:utranslator/navigation/navigation.dart';
import 'package:utranslator/builders/build_initial_text.dart';
import 'package:utranslator/pages/home_page_body.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final pageViewController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const Navigation(),
      bottomNavigationBar: AnimatedBuilder(
          animation: pageViewController,
          builder: (context, snapshot) {
            return BottomNavigationBar(
                currentIndex: pageViewController.page?.round() ?? 0,
                onTap: (index) {
                  pageViewController.jumpToPage(index);
                },
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                fixedColor: Colors.white,
                unselectedItemColor: Colors.black,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.picture_as_pdf),
                    label: 'PDF',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.text_fields),
                    label: 'Palavras',
                  ),
                ]);
          }),
      body: PageView(
        controller: pageViewController,
        physics: NeverScrollableScrollPhysics(),
        children: const [HomePage(), PhrasePageBody()],
      ),
    );
  }
}
