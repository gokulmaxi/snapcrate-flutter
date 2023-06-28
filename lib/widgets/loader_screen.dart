import 'package:flutter/material.dart';

Scaffold waitingView() {
  return const Scaffold(
      body: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
        Text('Loading...'),
      ],
    ),
  ));
}
