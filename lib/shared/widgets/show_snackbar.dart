import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    backgroundColor: color ?? Colors.grey,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
