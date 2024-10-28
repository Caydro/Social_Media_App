import 'package:collagiey/Core/Colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CaydroLoadingPage extends StatelessWidget {
  const CaydroLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: CircularProgressIndicator(
            color: CaydroColors.mainColor,
          ),
        ),
      ),
    );
  }
}
