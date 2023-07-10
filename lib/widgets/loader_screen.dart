import 'package:flutter/material.dart';

Scaffold waitingView() {
  return const Scaffold(
      body: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.all(40.0),
            child: Image(
              image: AssetImage("assets/Cube-1s-200px.gif"),
              height: 50,
            )),
        Text('Loading...'),
      ],
    ),
  ));
}
