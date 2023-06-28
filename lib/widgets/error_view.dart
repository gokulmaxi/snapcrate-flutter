import 'package:flutter/material.dart';

Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
  return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
}
