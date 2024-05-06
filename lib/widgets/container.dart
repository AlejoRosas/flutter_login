import 'package:flutter/material.dart';
import 'package:login/widgets/text.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              gradient: const LinearGradient(
                  colors: [Colors.yellow, Colors.blue, Colors.red],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4, 0.7, 1]),
              boxShadow: const [
                BoxShadow(color: Colors.black, blurRadius: 20),
                BoxShadow(color: Colors.red, blurRadius: 20, spreadRadius: 10)
              ]),
          child: const MyText(),
        )));
  }
}
