import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StartScreen extends HookWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('assets/images/megalogo.png'), height: 100),
        SizedBox(height: 50),
        Text(
          'Bem vindo ao Mega Man API',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 50),
        Text(
          'Clique nos botões abaixo para carregar os robôs ou favoritos',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
      ],
    ));
  }
}
