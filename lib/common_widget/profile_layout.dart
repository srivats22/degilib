import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degilib/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

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
          onTap: (){
            if(canLaunchUrl(Uri.parse("$privacyUrl")) != null){
              launchUrl(Uri.parse("${privacyUrl}"));
            }
          },
          leading: const Icon(Icons.privacy_tip),
          title: const Text("Privacy"),
        ),
        ListTile(
          onTap: (){
            showAboutDialog(
              context: context,
              applicationName: "${appName}",
              children: [
                Text("$appName is a digital library to showcase all that you love"),
              ]
            );
          },
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
          onTap: (){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Feature will be enabled later")));
          },
          leading: const Icon(Icons.share),
          title: const Text("Share App"),
        ),
        ListTile(
          onTap: (){
            final Uri mail = Uri(
              scheme: 'mailto',
              path: 'srivats.venkataraman@gmail.com'
            );
            if(canLaunchUrl(Uri.parse(mail.toString())) != null){
              launchUrl(mail);
            }
          },
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
        Visibility(
          visible: !UniversalPlatform.isIOS,
          child: ElevatedButton(
            onPressed: (){
              fAuth.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil("/",
                      (Route<dynamic> route) => false);
            },
            child: const Text("Log out"),
          ),
        ),
        const SizedBox(height: 10,),
        Visibility(
          visible: !UniversalPlatform.isIOS,
          child: ElevatedButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete Account?"),
                      content: const Text("This action cannot be undone and all data will be deleted"),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            accountDelete();
                            Navigator.of(context).pushNamedAndRemoveUntil("/",
                                    (Route<dynamic> route) => false);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red,
                              onPrimary: Colors.white),
                          child: const Text("Delete",
                            style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ],
                    );
                  }
              );
            },
            style: ElevatedButton.styleFrom(primary: Colors.red, onPrimary: Colors.white),
            child: const Text("Delete Account"),
          ),
        ),
        Visibility(
          visible: UniversalPlatform.isIOS,
          child: CupertinoButton.filled(
            onPressed: (){
              fAuth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacementNamed("/");
            },
            child: const Text("Log out"),
          ),
        ),
        const SizedBox(height: 10,),
        Visibility(
          visible: UniversalPlatform.isIOS,
          child: CupertinoButton(
            onPressed: (){
              showCupertinoDialog(
                context: context,
                builder: (context){
                  return CupertinoAlertDialog(
                    title: const Text("Delete Account?"),
                    content: const Text("This action cannot be undone and all data will be deleted"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: (){
                          accountDelete();
                          Navigator.of(context).pushNamedAndRemoveUntil("/",
                                  (Route<dynamic> route) => false);
                        },
                        isDestructiveAction: true,
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                }
              );
            },
            color: Colors.red,
            child: const Text("Delete Account"),
          ),
        ),
      ],
    );
  }

  void accountDelete() async{
    // deletes the post collection
    Future<QuerySnapshot> tasks = fStore
        .collection("users").doc(user!.uid).collection("posts").get();
    await tasks.then((value) => {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("users").doc(user!.uid).collection("posts")
            .doc(element.id).delete();
      })
    });
    // deletes the users doc
    fStore.collection("users")
        .doc(user!.uid).delete();
    // deletes the user
    fAuth.currentUser!.delete();
  }
}
