import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Animacion extends StatefulWidget {
  const Animacion({super.key});

  @override
  State<Animacion> createState() => _AnimacionState();
}

class _AnimacionState extends State<Animacion> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/Animation01.json',
        repeat: false,
        width: 400,
        height: 400,
        fit: BoxFit.contain,
      ),
    );
  }
}
