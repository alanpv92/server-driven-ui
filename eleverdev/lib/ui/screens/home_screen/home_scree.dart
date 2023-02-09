import 'package:eleverdev/controllers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed:
                Provider.of<AuthenticationController>(context, listen: false)
                    .onlogOut,
            child: Text("log out")),
      ),
    );
  }
}
