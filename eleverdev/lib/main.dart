import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eleverdev/controllers/authentication.dart';
import 'package:eleverdev/controllers/cache.dart';
import 'package:eleverdev/controllers/home_page.dart';
import 'package:eleverdev/firebase_options.dart';
import 'package:eleverdev/mangers/asset.dart';
import 'package:eleverdev/mangers/routes.dart';
import 'package:eleverdev/mangers/theme.dart';
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:eleverdev/services/firebase/firebase_storage.dart';
import 'package:eleverdev/ui/screens/authentication/authentication.dart';
import 'package:eleverdev/ui/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await FileStorageService.instance.initFileStorageService();
  // FileStorageService.instance
  //     .checkIfApplicationImageStorageIsInit()
  //     .toString();
  // FileStorageService.instance.loadAllImageFilePath();
  // FirebaseStorageService().startDownload();
  runApp(EasyLocalization(
      path: AssetManger.translations,
      supportedLocales: const [Locale('en')],
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomePageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CacheController(),
        )
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          getPages: RouteManger.getRoutes(),
          unknownRoute: RouteManger.getErrorPage(),
          theme: ThemeManger.instance.getApplicationTheme,
          home: const AuthManger()),
    );
  }
}

/*

AuthManger listens for authStateChanges and if user is logged in HomeScreen is shown else AuthenticationScreen is shown


*/

class AuthManger extends StatelessWidget {
  const AuthManger({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const AuthenticationScreen();
      },
    );
  }
}
