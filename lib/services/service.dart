import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './connection_service.dart';

enum ConnectionStatus { loading, ready, error }

class Service {
  final ValueNotifier<Map<String, dynamic>> cardStateNotifier = ValueNotifier({
    'status': ConnectionStatus.loading,
    'dataObjects': [],
    'columnNames': [],
  });

  final ValueNotifier<Map<String, dynamic>> favoritesStateNotifier =
      ValueNotifier({
    'status': ConnectionStatus.ready,
    'dataObjects': [],
    'propertyNames': ['name', 'weapon', 'avatar', 'weakness', 'series'],
  });

  Future<void> loadRobotMaster() async {
    bool isConnected = await ConnectionService().isConnected();

    if (!isConnected) {
      cardStateNotifier.value = {
        'status': ConnectionStatus.error,
        'dataObjects': []
      };

      return;
    }

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
