import 'package:degilib/common.dart';
import 'package:degilib/common_widget/category_list.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final String? uid;
  const UserDetails({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool isLoading = true;
  String userName = "";

  void initializer() async{
    var userCollection =
        await fStore.collection("users").doc(widget.uid).get();
    Map<String, dynamic>? userMap = userCollection.data();
    setState((){
      userName = userMap!['name'];
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Degilib"),
          centerTitle: false,
        ),
        body: isLoading ? const Loader() : userDisplay(),
      ),
    );
  }

  Widget userDisplay(){
    return ListView(
      padding: const EdgeInsets.all(10),
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
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        CategoryList(userId: "${widget.uid}", showAddToCategory: false,),
      ],
    );
  }
}
