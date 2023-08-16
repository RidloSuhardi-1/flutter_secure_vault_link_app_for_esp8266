import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app/view/splash_screen.dart';
import 'data/repository/setup_repo.dart';
import 'firebase_options.dart';
import 'res/strings/constant.dart';
import 'res/strings/global_key.dart';
import 'res/themes.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();

  SetupRepo().getSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: theme(),
      home: const SplashScreen(),
      routes: routes,
    );
  }
}
