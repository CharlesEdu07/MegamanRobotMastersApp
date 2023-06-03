import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../services/service.dart';

class ListRobots extends HookWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;
  final Service service;

  const ListRobots({
    super.key,
    this.jsonObjects = const [],
    this.columnNames = const [], // Atualize esta linha
    this.propertyNames = const [
      "name",
      "weapon",
      "avatar",
      "weakness",
      "series"
    ],
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      const SizedBox(height: 20),
      const Center(
        child: Text("Lista de Robot-Masters",
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      const SizedBox(height: 20),
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 260),
        itemCount: 32,
        itemBuilder: (_, index) {
          return Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.teal[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.network(
                    jsonObjects[index][propertyNames[2]],
                    height: 150,
                    scale: 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        Text(jsonObjects[index][propertyNames[0]],
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white)),
                        const SizedBox(height: 5),
                        Text("Arma: ${jsonObjects[index][propertyNames[1]]}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Center(
                              child: ValueListenableBuilder(
                                  valueListenable:
                                      service.favoritesStateNotifier,
                                  builder: (_, value, __) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: value['dataObjects']
                                                .contains(jsonObjects[index])
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                      onPressed: () {
                                        value['dataObjects']
                                                .contains(jsonObjects[index])
                                            ? value['dataObjects']
                                                .remove(jsonObjects[index])
                                            : value['dataObjects']
                                                .add(jsonObjects[index]);
                                      },
                                    );
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
      const SizedBox(height: 20),
    ]);
  }
}
