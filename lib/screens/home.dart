import 'package:degilib/common_widget/category_list.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:degilib/common_widget/profile_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:degilib/common.dart';
import 'package:universal_platform/universal_platform.dart';

import 'add_to_profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  String? userName = "";
  TextEditingController? imgUrl, title;

  void initializer(){
    setState((){
      userName = fAuth.currentUser?.displayName![0].toUpperCase();
    });
  }

  @override
  initState(){
    initializer();
    isLoading = false;
    imgUrl = TextEditingController();
    title = TextEditingController();
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: CategoryList(),
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
            const CategoryList()
          ],
        ),
        floatingActionButton: fab(),
      ),
    );
  }

  Widget fab(){
    return FloatingActionButton(
      onPressed: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddToProfile()));
      },
      tooltip: "Add to profile",
      child: UniversalPlatform.isIOS ? const Icon(CupertinoIcons.add) :
      const Icon(Icons.add),
    );
  }
}
