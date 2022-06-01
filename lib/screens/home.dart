import 'package:degilib/common_widget/category_list.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:degilib/common_widget/profile_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:degilib/common.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:share_plus/share_plus.dart';

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
            actions: [
              IconButton(
                onPressed: (){
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => const UserSearch()));
                  modular.pushNamed("/search");
                },
                icon: const Icon(Icons.search),
              ),
            ],
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
                    child: CategoryList(userId: '${user?.uid}',
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
          actions: [
            IconButton(
              onPressed: (){
                modular.pushNamed("/search");
              },
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
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            ExcludeSemantics(
              child: CircleAvatar(
                radius: 50,
                child: Text(fAuth.currentUser!.displayName![0].toUpperCase(),
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
            modular.pushNamed("/add");
          },
          label: "Post",
          child: UniversalPlatform.isIOS ?
          const Icon(CupertinoIcons.add) : const Icon(Icons.add),
        ),
        SpeedDialChild(
          onPressed: (){
            String profileUrl = "localhost:8080/user/${fAuth.currentUser!.uid}";
            Share.share("Here's my Degilib profile: $profileUrl");
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
