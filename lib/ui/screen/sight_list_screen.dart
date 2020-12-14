import 'package:flutter/material.dart';

// Экран со списком интересных мест

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key}) : super(key: key);

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
        title: RichText(
          // Basic settings for RichTextWidget
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          // Text of RichTextWidget
          text: TextSpan(

              // Basic settings for TextSpan
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3E5B),
              ),

              // Text and its individual settings
              children: [
                TextSpan(
                  text: "С",
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                  ),
                ),
                TextSpan(text: "писок\n"),
                TextSpan(
                  text: "и",
                  style: TextStyle(
                    color: Color(0xFFFCDD3D),
                  ),
                ),
                TextSpan(text: "нтересных мест"),
              ]),
        ),
      ),
    );
  }
}
