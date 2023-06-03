import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyBottomNavBar extends HookWidget {
  final Function itemSelectedCallback;

  const MyBottomNavBar({super.key, required this.itemSelectedCallback});

  @override
  Widget build(BuildContext context) {
    var selectedIndex = useState(0);

    onTap(index) {
      selectedIndex.value = index;
      itemSelectedCallback(index);
    }

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
      ],
      currentIndex: selectedIndex.value,
      selectedItemColor: Colors.teal,
      onTap: onTap,
    );
  }
}
