import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degilib/common_widget/custom_input.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:degilib/model/lib_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:universal_platform/universal_platform.dart';

import '../common.dart';

class AddToProfile extends StatefulWidget {
  const AddToProfile({Key? key}) : super(key: key);

  @override
  State<AddToProfile> createState() => _AddToProfileState();
}

class _AddToProfileState extends State<AddToProfile> {
  int index = 0;
  TextEditingController? imgUrl, link, provider, title;
  String searchQuery = "";

  @override
  void initState() {
    imgUrl = TextEditingController();
    link = TextEditingController();
    provider = TextEditingController();
    title = TextEditingController(text: searchQuery);
    super.initState();
  }

  void initiateSearch(String val) {
    setState(() {
      searchQuery = val.toLowerCase().trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: TextFormField(
            decoration: const InputDecoration(
              hintText: "Search by title",
            ),
            onChanged: (val) => initiateSearch(val),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: searchQuery != "" && searchQuery != null
              ? fStore
                  .collection('lib')
                  .where("searchQuery", arrayContains: searchQuery)
                  .snapshots()
              : fStore.collection("lib").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Text("Looks like what you are searching for is not present"),
                    Text("Would you like to add it to your profile?"),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: UniversalPlatform.isIOS,
                          child: CupertinoButton(
                            onPressed: (){
                              modular.pop();
                            },
                            child: Text("Cancel"),
                          ),
                        ),
                        Visibility(
                          visible: UniversalPlatform.isIOS,
                          child: CupertinoButton.filled(
                            onPressed: (){
                              setState((){
                                index = 1;
                              });
                            },
                            child: Text("Add"),
                          ),
                        ),
                        Visibility(
                          visible: !UniversalPlatform.isIOS,
                          child: TextButton(
                            onPressed: (){
                              modular.pop();
                            },
                            child: Text("Cancel"),
                          ),
                        ),
                        Visibility(
                          visible: !UniversalPlatform.isIOS,
                          child: ElevatedButton(
                            onPressed: (){
                              setState((){
                                index = 1;
                              });
                            },
                            child: Text("Add"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Loader();
              default:
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return ListTile(
                      onTap: () {},
                      leading: Image.network(document['imgUrl']),
                      title: Text(document['title']),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ));
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          shrinkWrap: true,
          children: [
            CustomTextField(imgUrl!, "Image", "", "", false, TextInputType.url,
                false, [""]),
            CustomTextField(title!, "Title", "", "", false, TextInputType.url,
                false, [""]),
            CustomTextField(provider!, "provider", "Ex: Spotify, Netflix", "", false, TextInputType.url,
                false, [""]),
            CustomTextField(link!, "Link", "", "", false, TextInputType.url,
                false, [""]),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: UniversalPlatform.isIOS,
                  child: CupertinoButton(
                    onPressed: (){
                      setState((){
                        searchQuery = "";
                      });
                      modular.pushNamed("/home");
                    },
                    child: Text("Cancel"),
                  ),
                ),
                Visibility(
                  visible: UniversalPlatform.isIOS,
                  child: CupertinoButton.filled(
                    onPressed: (){

                    },
                    child: Text("Add"),
                  ),
                ),
                Visibility(
                  visible: !UniversalPlatform.isIOS,
                  child: TextButton(
                    onPressed: (){
                      setState((){
                        searchQuery = "";
                      });
                      modular.pushNamed("/home");
                    },
                    child: Text("Cancel"),
                  ),
                ),
                Visibility(
                  visible: !UniversalPlatform.isIOS,
                  child: ElevatedButton(
                    onPressed: (){
                    },
                    child: Text("Add"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
