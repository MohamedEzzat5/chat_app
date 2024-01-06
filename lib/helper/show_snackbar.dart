import 'package:flutter/material.dart';

void showSnackBar(context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(showCloseIcon: true, content: Text(message)));
}