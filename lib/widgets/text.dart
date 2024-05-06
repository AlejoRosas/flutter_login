import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTextStyle(
        style: TextStyle(),
        child: Text(
          "App de Gestion de Pagos "
          "Ah carajo",
          maxLines: 2,
          style: TextStyle(color: Colors.black, fontSize: 10),
        ));
  }
}
