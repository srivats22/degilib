import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degilib/common.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:universal_platform/universal_platform.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({Key? key}) : super(key: key);

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  String query = "";
  TextEditingController searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: searchBar(),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: query != ""
              ? fStore
                  .collection('users')
                  .where("search_field", arrayContains: query)
                  .where("name",
                  isNotEqualTo: "${fAuth.currentUser!.displayName}")
                  .limit(3)
                  .snapshots()
              : fStore.collection("users").where("name",
              isNotEqualTo: "${fAuth.currentUser!.displayName}")
              .limit(3).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Loader();
              default:
                return ListView(
                  padding: const EdgeInsets.all(10),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        child: ListTile(
                          onTap: (){
                            var userUid = document['uid'];
                            // Routemaster.of(context).push('/user/$userUid');
                            Modular.to.pushNamed('/user/$userUid');
                          },
                          leading: ExcludeSemantics(
                            child: CircleAvatar(
                              child: Text(document['name'][0]),
                            ),
                          ),
                          title: Text(document['name']),
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  Widget searchBar() {
    if (UniversalPlatform.isIOS) {
      return CupertinoTextField(
        onChanged: (search) {
          initiateSearch(search);
        },
        placeholder: "Search by user name",
      );
    }
    return TextField(
      onChanged: (search) {
        initiateSearch(search);
      },
      decoration: const InputDecoration(
        hintText: "Search by user name",
      ),
    );
  }

  void initiateSearch(String val) {
    setState(() {
      query = val.toLowerCase();
    });
  }
}
