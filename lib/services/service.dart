import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './connection_service.dart';

enum ConnectionStatus { idle, loading, ready, error }

class Service {
  final ValueNotifier<Map<String, dynamic>> cardStateNotifier = ValueNotifier({
    'status': ConnectionStatus.idle,
    'dataObjects': [],
    'columnNames': [],
  });

  final ValueNotifier<Map<dynamic, dynamic>> favoritesStateNotifier =
      ValueNotifier({
    'status': ConnectionStatus.idle,
    'dataObjects': [],
    'columnNames': [],
  });

  Future<void> load(index) async {
    List<Function> functions = [loadRobotMaster];

    cardStateNotifier.value = {
      'status': ConnectionStatus.loading,
      'dataObjects': []
    };

    bool isConected = await ConnectionService().isConected();

    if (!isConected) {
      cardStateNotifier.value = {
        'status': ConnectionStatus.error,
        'dataObjects': []
      };

      return;
    }

    functions[index]();
  }

  Future<void> loadRobotMaster() async {
    print("Dudu");

    var robotsUri = Uri(
      scheme: 'https',
      host: 'megaman-api.herokuapp.com',
      path: '/',
    );

    var jsonString = await http.read(robotsUri);
    var robotsJson = jsonDecode(jsonString);

    cardStateNotifier.value = {
      'status': ConnectionStatus.ready,
      'dataObjects': robotsJson,
      'columnNames': [
        "Nome",
        "Arma",
        "Sprite",
        "Avatar",
        "Jogo"
      ], // Atualize esta linha
      'propertyNames': ["name", "weapon", "sprite1", "avatar", "series"]
    };
  }
}
