import 'package:flutter/material.dart';


showCustomSnackBar(BuildContext context, Widget child) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: child,
      margin: const EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
    )
  );
}