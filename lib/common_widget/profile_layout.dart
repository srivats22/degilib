import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common.dart';
import 'loader.dart';

class ProfileLayout extends StatefulWidget {
  const ProfileLayout({Key? key}) : super(key: key);

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  bool isLoading = true;
  String userName = "";
  String userEmail = "";

  void initializer() async{
    final userNamePref = await SharedPreferences.getInstance();
    final userEmailPref = await SharedPreferences.getInstance();
    setState((){
      userName = userNamePref.getString("name")!;
      userEmail = userEmailPref.getString("email")!;
      isLoading = false;
    });
  }

  @override
  void initState(){
    if (kDebugMode) {
      print("Inside Init State");
    }
    super.initState();
    initializer();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Loader();
    }
    return ListView(
      padding: const EdgeInsets.all(10),
      // shrinkWrap: true,
      children: [
        ExcludeSemantics(
          child: CircleAvatar(
            radius: 50,
            child: Text(userName[0].toUpperCase(),
              style: Theme.of(context).textTheme.headline3
                  ?.copyWith(color: Colors.white),),
          ),
        ),
        const SizedBox(height: 5,),
        Text(userName,
          style: Theme.of(context).textTheme.headline4,),
        const SizedBox(height: 5,),
        Text(userEmail,
          style: Theme.of(context).textTheme.headline5,),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        Text("App Related",
        style: Theme.of(context).textTheme.headline5,),
        ListTile(
          onTap: (){},
          leading: const Icon(Icons.privacy_tip),
          title: const Text("Privacy"),
        ),
        ListTile(
          onTap: (){},
          leading: const Icon(Icons.info),
          title: const Text("About App"),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        Text("General",
          style: Theme.of(context).textTheme.headline5,),
        ListTile(
          onTap: (){},
          leading: const Icon(Icons.share),
          title: const Text("Share App"),
        ),
        ListTile(
          onTap: (){},
          leading: const Icon(Icons.email),
          title: const Text("Contact Developer"),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        Text("Account",
          style: Theme.of(context).textTheme.headline5,),
        const SizedBox(height: 10,),
        ElevatedButton(
          onPressed: (){},
          child: const Text("Log out"),
        ),
        const SizedBox(height: 10,),
        ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(primary: Colors.red,
              onPrimary: Colors.white),
          child: const Text("Delete Account"),
        ),
      ],
    );
  }
}
