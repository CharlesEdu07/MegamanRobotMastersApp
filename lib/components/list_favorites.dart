import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../services/service.dart';

class ListFavorites extends HookWidget {
  final List jsonObjects;
  final List<String> propertyNames;
  final Service service;

  const ListFavorites({
    super.key,
    this.jsonObjects = const [], // Atualize esta linha
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
        child: Text("Lista de Favoritos",
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      const SizedBox(height: 20),
      jsonObjects.isEmpty
          ? const Center(
              child: Text("Você ainda não adicionou nenhum favorito",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            )
          : Column(
              children: jsonObjects.map(
              (jsonObject) {
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      jsonObject[propertyNames[2]],
                      height: 150,
                      scale: 0.4,
                    ),
                    title: Text(jsonObject[propertyNames[0]]),
                    subtitle: Text(jsonObject[propertyNames[1]]),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                      onPressed: () {
                        service.favoritesStateNotifier.value = {
                          'status': ConnectionStatus.ready,
                          'dataObjects': service
                              .favoritesStateNotifier.value['dataObjects']
                              .where((element) =>
                                  element[propertyNames[0]] !=
                                  jsonObject[propertyNames[0]])
                              .toList(),
                          'propertyNames': service
                              .favoritesStateNotifier.value['propertyNames'],
                        };
                      },
                    ),
                  ),
                );
              },
            ).toList()),
    ]);
  }
}
