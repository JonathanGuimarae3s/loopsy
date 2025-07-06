import 'package:flutter/material.dart';

class CirculoProgresso extends StatefulWidget {
  const CirculoProgresso({super.key});

  @override
  State<CirculoProgresso> createState() => _CirculoProgressoState();
}

class _CirculoProgressoState extends State<CirculoProgresso> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 200.0,
      height: 200.0,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 5.0,
      ),
    );
  }
}
