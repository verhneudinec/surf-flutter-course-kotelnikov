import 'package:flutter/material.dart';

// Экран со списком интересных мест

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key}) : super(key: key);

  final String title = "Итересные места";

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  String _currentRoot = "Главная страница";

  // Тестовая функция для смены маршрута роутера
  void _setRoot(String currentRoot) {
    setState(() {
      _currentRoot = currentRoot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("$_currentRoot", style: TextStyle(fontSize: 20)),
        ),
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => _setRoot("Выбран профиль"),
            )
          ],
          backgroundColor: Colors.lightGreen[300],
        ),
        bottomNavigationBar: BottomNavigationBar(currentIndex: 1, items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("Закладки")),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Главная")),
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Карта")),
        ]));
  }
}
