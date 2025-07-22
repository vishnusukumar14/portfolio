import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme.dart';
import 'core/util.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = Utils.createTextTheme(context, "Lato", "Arvo");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Vishnu Sukumar - Portfolio',
      theme: brightness == Brightness.light ? theme.light() : theme.light(),
      home: PortfolioHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
