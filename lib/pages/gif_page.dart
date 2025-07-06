import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopsy/model/gif.dart';
import 'package:share_plus/share_plus.dart';

class GifPage extends StatelessWidget {
  Gif gif;

  GifPage(this.gif);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              gif.compartilhamento();
            },
            icon: Icon(Icons.share),
          ),
        ],
        title: Text(gif.url, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(child: Image.network(gif.url)),
      backgroundColor: Colors.black,
    );
  }
}
