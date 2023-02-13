import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('"Screen2,press to go back"'),
        ),
      ),
    );
  }
}