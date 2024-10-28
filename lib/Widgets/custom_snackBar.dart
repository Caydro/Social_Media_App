import 'package:flutter/material.dart';

customSnackBar({required BuildContext context, required String text}) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(text)));
}
