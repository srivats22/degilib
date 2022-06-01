import 'package:degilib/common.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:universal_platform/universal_platform.dart';

class CategoryPost extends StatefulWidget {
  final String userId, category;
  final bool showAddToCategory;
  const CategoryPost({Key? key, required this.userId, required this.category,
  required this.showAddToCategory}) : super(key: key);

  @override
  State<CategoryPost> createState() => _CategoryPostState();
}

class _CategoryPostState extends State<CategoryPost> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: PaginateFirestore(
          shrinkWrap: true,
          itemsPerPage: 5,
          initialLoader: const Loader(),
          itemBuilderType: PaginateBuilderType.listView,
          query: fStore.collection("users")
          .doc(widget.userId).collection("posts")
          .where("category", isEqualTo: widget.category)
          .orderBy("added_on"),
          itemBuilder: (context, snapshot, index){
            final data = snapshot[index].data() as Map?;
            if(data!['img'] == ""){
              return ListTile(
                leading: ExcludeSemantics(
                  child: CircleAvatar(
                    child: UniversalPlatform.isIOS ?
                    const Icon(CupertinoIcons.photo) : const Icon(Icons.photo),
                  ),
                ),
                title: Text(data['title']),
                subtitle: Text("Provider: ${data['provider']}"),
              );
            }
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data['img']),
              ),
              title: Text(data['title']),
              subtitle: Text("Provider: ${data['provider']}"),
            );
          },
          onEmpty: widget.showAddToCategory ?
          Center(
            child: Column(
              children: [
                Text("Nothing to display for ${widget.category} Category"),
                const Text("Do you wish to add to this category?"),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: UniversalPlatform.isIOS,
                      child: CupertinoButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ),
                    Visibility(
                      visible: UniversalPlatform.isIOS,
                      child: CupertinoButton.filled(
                        onPressed: (){
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) =>
                          //     const AddToProfile()));
                          modular.pushNamed('/add');
                        },
                        child: Text("Add"),
                      ),
                    ),
                    Visibility(
                      visible: !UniversalPlatform.isIOS,
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ),
                    Visibility(
                      visible: !UniversalPlatform.isIOS,
                      child: ElevatedButton(
                        onPressed: (){
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) =>
                          //     const AddToProfile()));
                          modular.pushNamed('/add');
                        },
                        child: Text("Add"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) : Center(
            child: Column(
              children: [
                Text("The User has not displayed anything for ${widget.category}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
