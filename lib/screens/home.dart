import 'package:degilib/common_widget/category_list.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:degilib/common_widget/posts.dart';
import 'package:degilib/common_widget/profile_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:degilib/common.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:universal_platform/universal_platform.dart';

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
            actions: [
              IconButton(
                onPressed: (){},
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: Center(
            child: Row(
              children: const [
                Expanded(
                    child: ProfileLayout()
                ),
                VerticalDivider(),
                Expanded(
                  child: CategoryList(),
                ),
              ],
            ),
          ),
          floatingActionButton: speedDial(),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(appName),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: (){},
              icon: UniversalPlatform.isIOS ? const Icon(CupertinoIcons.search)
                  : const Icon(Icons.search),
            ),
            TextButton(
              onPressed: (){},
              child: ExcludeSemantics(
                child: CircleAvatar(
                  child: Text(userName!),
                ),
              ),
            ),
          ],
        ),
        body: const Center(
          child: Text("On Mobile"),
        ),
        floatingActionButton: speedDial(),
      ),
    );
  }

  Widget speedDial(){
    return  SpeedDial(
      speedDialChildren: [
        SpeedDialChild(
          onPressed: (){
            modular.pushNamed("/add");
          },
          child: UniversalPlatform.isIOS ?
          const Icon(CupertinoIcons.add) : const Icon(Icons.add),
          label: "Add To Profile",
        ),
        SpeedDialChild(
          onPressed: (){},
          child: UniversalPlatform.isIOS ?
          const Icon(CupertinoIcons.share) : const Icon(Icons.share),
          label: "Share Profile",
        ),
      ],
      child: UniversalPlatform.isIOS ?
      const Icon(CupertinoIcons.add) : const Icon(Icons.add),
    );
  }
}
