import 'package:degilib/screens/add_to_profile.dart';
import 'package:degilib/screens/auth.dart';
import 'package:degilib/screens/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module{
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (context, args) => const Auth()),
    ChildRoute("/home", child: (context, args) => const Home()),
    ChildRoute("/add", child: (context, args) => const AddToProfile()),
  ];
}