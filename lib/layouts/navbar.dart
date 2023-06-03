import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text("Carregar Robôs"),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text("Carregar Favoritos"),
              ),
            ],
        onSelected: (value) {
          {}
        });
  }
}
