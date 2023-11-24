import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utranslator/controllers/initial_page_controller.dart';
import 'package:utranslator/controllers/drawer_status_controller.dart';
import 'package:utranslator/navigation/navigation.dart';
import 'package:utranslator/builders/build_initial_text.dart';
import 'package:utranslator/pages/home_page_body.dart';
import 'package:utranslator/provider/theme_controller.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final pageViewController = PageController();
  final appThemeProvider = AppThemeProvider();

  @override
  void initState() {
    super.initState();
    appThemeProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => InitialPageController(),
      builder: (context, _) {
        final initialPageController =
            Provider.of<InitialPageController>(context);

        return Scaffold(
            appBar: initialPageController.headerAndFooterIsActive
                ? AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: const Text('Home'),
                    centerTitle: true,
                  )
                : null,
            drawer: const Navigation(),
            onDrawerChanged: (isOpened) {
              DrawerStatusController.instance.changeDrawnerStatus(isOpened);
            },
            bottomNavigationBar: initialPageController.headerAndFooterIsActive
                ? AnimatedBuilder(
                    animation: pageViewController,
                    builder: (context, snapshot) {
                      return BottomNavigationBar(
                          currentIndex: pageViewController.page?.round() ?? 0,
                          onTap: (index) {
                            pageViewController.jumpToPage(index);
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
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
                    })
                : null,
            body: PageView(
              controller: pageViewController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [HomePage(), PhrasePageBody()],
            ));
      });
}
