import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ListFavorites extends HookWidget {
  final List jsonObjects;
  final List<String> propertyNames;

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
      Column(
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
                onPressed: () {},
              ),
            ),
          );
        },
      ).toList()),
    ]);
  }
}
