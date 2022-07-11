import 'package:degilib/common.dart';
import 'package:degilib/screens/account_screen.dart';
import 'package:degilib/screens/add_to_profile.dart';
import 'package:degilib/screens/auth.dart';
import 'package:degilib/screens/error_page.dart';
import 'package:degilib/screens/home.dart';
import 'package:degilib/screens/user_details.dart';
import 'package:degilib/screens/user_search.dart';
import 'package:degilib/theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(
  //   ModularApp(
  //       module: AppModule(),
  //       child: const MyApp()
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Modular.setInitialRoute(
    //     FirebaseAuth.instance.currentUser == null ? "/" : "/home");
    return DynamicColorBuilder(
        builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
          // return MaterialApp.router(
          //   debugShowCheckedModeBanner: false,
          //   title: appName,
          //   theme: AppTheme.lightTheme(lightColorScheme),
          //   darkTheme: AppTheme.lightTheme(lightColorScheme),
          //   routeInformationParser: Modular.routeInformationParser,
          //   routerDelegate: Modular.routerDelegate,
          // );
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: AppTheme.lightTheme(lightColorScheme),
            darkTheme: AppTheme.lightTheme(lightColorScheme),
            initialRoute: FirebaseAuth.instance.currentUser == null ? "/" : "/home",
            onGenerateRoute: (settings){
              var uri = Uri.parse("${settings.name}");
              if(settings.name == "/"){
                return MaterialPageRoute(builder: (context) => const Auth());
              }
              if(settings.name == '/home'){
                return MaterialPageRoute(builder: (context) => const Home());
              }
              if(settings.name == '/add'){
                return MaterialPageRoute(builder: (context) => const AddToProfile());
              }
              if(settings.name == '/search'){
                return MaterialPageRoute(builder: (context) => const UserSearch());
              }
              if(settings.name == '/account'){
                return MaterialPageRoute(builder: (context) => const AccountScreen());
              }
              if(uri.pathSegments.length == 2 &&
                  uri.pathSegments.first == 'users'){
                var uid = uri.pathSegments[1];
                return MaterialPageRoute(builder: (context) => UserDetails(uid: uid));
              }
              return MaterialPageRoute(builder: (context) => const ErrorPage());
            },
          );
        });
  }
}