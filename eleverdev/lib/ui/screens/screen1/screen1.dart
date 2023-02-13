import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('"Screen1,press to go back"'),
        ),
      ),
    );
  }
}
