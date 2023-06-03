import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:projetinho/components/list_favorites.dart';
import 'package:projetinho/services/service.dart';
import './layouts/navbar.dart';
import './layouts/my_bottom_navbar..dart';
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
    useEffect(() {
      service.loadRobotMaster();
    }, []);

    final selectedIndex = useState(0);

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
      body: selectedIndex.value == 0
          ? ValueListenableBuilder(
              valueListenable: service.cardStateNotifier,
              builder: (_, value, __) {
                if (value['status'] == ConnectionStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (value['status'] == ConnectionStatus.error) {
                  return const Center(
                    child: Text('Erro ao carregar os dados'),
                  );
                }

                return ListRobots(
                  jsonObjects: value['dataObjects'],
                  columnNames: value['columnNames'],
                  propertyNames: value['propertyNames'],
                  service: service,
                );
              },
            )
          : selectedIndex.value == 1
              ? ValueListenableBuilder(
                  valueListenable: service.favoritesStateNotifier,
                  builder: (_, value, __) {
                    return ListFavorites(
                      jsonObjects: value['dataObjects'],
                      propertyNames: value['propertyNames'],
                    );
                  },
                )
              : Container(),
      bottomNavigationBar: MyBottomNavBar(itemSelectedCallback: (index) {
        selectedIndex.value = index;
      }),
    );
  }
}
