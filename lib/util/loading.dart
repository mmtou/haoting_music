import 'package:flutter/material.dart';

Future loading;

class Loading {
  static show(context) {
    loading = showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static close() {}
}
