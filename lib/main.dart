import 'package:degilib/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ModularApp(
        module: AppModule(),
        child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(
        FirebaseAuth.instance.currentUser == null ? "/" : "/home");
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        useMaterial3: true,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(
              fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: GoogleFonts.montserrat(
              fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3:
              GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
          headline4: GoogleFonts.montserrat(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5:
              GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
          headline6: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText2: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
