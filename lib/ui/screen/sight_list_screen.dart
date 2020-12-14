import 'package:flutter/material.dart';

// Экран со списком интересных мест

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key}) : super(key: key);

  final String title = "Список\nинтересных мест";

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar settings
        toolbarHeight: 136, // heigh 72px + top margin 64px
        backgroundColor: Colors.transparent,
        elevation: 0.0, // remove shadow

        // Title text
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B3E5B),
          ),
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
