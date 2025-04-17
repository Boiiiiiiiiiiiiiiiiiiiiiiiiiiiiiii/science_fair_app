import 'package:flutter/material.dart';
import 'package:science_fair_app/data/notifiers.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier, 
      builder:(context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Главная'),
            NavigationDestination(icon: Icon(Icons.air), label: 'Долги'),
            NavigationDestination(icon: Icon(Icons.lightbulb), label: 'Советы'),
            NavigationDestination(icon: Icon(Icons.book), label: 'Глоссарий'),
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}