import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Jogo",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Quantidade",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Nome",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
