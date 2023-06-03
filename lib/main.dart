import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:projetinho/services/service.dart';
import './layouts/navbar.dart';
import './layouts/my_bottom_navbar..dart';
import './components/start_screen.dart';
import './components/list_robots.dart';

final service = Service();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.black),
      home: const MyHomePage(
        title: 'Mega Man API',
      ),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset('assets/images/snes.png'),
        ),
        actions: const [
          Navbar(),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: service.cardStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case ConnectionStatus.idle:
                return const StartScreen();
              case ConnectionStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionStatus.ready:
                return ListRobots(
                  jsonObjects: value['dataObjects'],
                  columnNames: value['columnNames'],
                  propertyNames: value['propertyNames'],
                );
              case ConnectionStatus.error:
                return const Center(
                  child: Text(
                    'Sem conexão com a internet',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                );

              default:
                return const Center(
                  child: Text(
                    'Erro desconhecido',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                );
            }
          }),
      bottomNavigationBar:
          MyBottomNavBar(itemSelectedCallback: (index) => service.load(index)),
    );
  }
}
