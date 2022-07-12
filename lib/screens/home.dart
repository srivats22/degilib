import 'package:degilib/common_widget/category_list.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:degilib/common_widget/profile_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:degilib/common.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  String? userName = "";

  void initializer(){
    setState((){
      userName = fAuth.currentUser?.displayName![0].toUpperCase();
    });
  }

  @override
  initState(){
    initializer();
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const SafeArea(
        child: Scaffold(
          body: Loader(),
        ),
      );
    }
    if(isDesktopBrowser){
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(appName),
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Row(
              children: [
                const Expanded(
                    child: ProfileLayout()
                ),
                const VerticalDivider(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    child: CategoryList(userId: user?.uid,
                      showAddToCategory: true,),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: fab(),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(appName),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pushNamed("/account");
              },
              child: ExcludeSemantics(
                child: CircleAvatar(
                  child: Text(userName!),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            ExcludeSemantics(
              child: CircleAvatar(
                radius: 50,
                child: Text(userName![0].toUpperCase(),
                  style: Theme.of(context).textTheme.headline3
                      ?.copyWith(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 5,),
            Text("${fAuth.currentUser!.displayName}",
              style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            CategoryList(userId: "${user?.uid}",
            showAddToCategory: true,)
          ],
        ),
        floatingActionButton: fab(),
      ),
    );
  }

  Widget fab(){
    return SpeedDial(
      speedDialChildren: [
        SpeedDialChild(
          onPressed: (){
            Navigator.of(context).pushNamed("/add");
          },
          label: "Add to profile",
          child: UniversalPlatform.isIOS ?
          const Icon(CupertinoIcons.add) : const Icon(Icons.add),
        ),
        SpeedDialChild(
          onPressed: (){
            // debug
            if(kDebugMode){
              String debugProfileUrl = "localhost:8080/users/${fAuth.currentUser!.uid}";
              if(isDesktopBrowser){
                Clipboard.setData(ClipboardData(text: debugProfileUrl)).then((_){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile copied to clipboard")));
                });
              }
              else{
                Share.share("Here's my Degilib profile: $debugProfileUrl");
              }
            }
            // release
            else{
              String profileUrl = "degilib.web.app/users/${fAuth.currentUser!.uid}";
              if(isDesktopBrowser){
                Clipboard.setData(ClipboardData(text: profileUrl)).then((_){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile copied to clipboard")));
                });
              }
              else{
                Share.share("Here's my Degilib profile: $profileUrl");
              }
            }
          },
          label: "Share Profile",
          child: UniversalPlatform.isIOS ? const Icon(CupertinoIcons.share) :
          const Icon(Icons.share),
        ),
      ],
      child: UniversalPlatform.isIOS ?
          const Icon(CupertinoIcons.add) : const Icon(Icons.add),
    );
  }
}
