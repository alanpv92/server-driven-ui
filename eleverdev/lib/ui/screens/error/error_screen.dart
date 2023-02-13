import 'package:eleverdev/mangers/text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(TextManger.instance.errorScreenContent),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Go Back"))
          ],
        ),
      )),
    );
  }
}
