import 'package:degilib/common.dart';
import 'package:degilib/screens/category_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class CategoryList extends StatelessWidget {
  final String? userId;
  final bool showAddToCategory;
  const CategoryList({Key? key, required this.userId,
  required this.showAddToCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Category",
        style: Theme.of(context).textTheme.headline6,),
        lTile(context, "artist", Icons.person, "Artists", userId!,
        showAddToCategory),
        lTile(context, "movie", Icons.movie, "Movie", userId!,
        showAddToCategory),
        lTile(context, "music", Icons.music_note, "Music", userId!,
        showAddToCategory),
        lTile(context, "shows", Icons.tv, "Shows", userId!,
        showAddToCategory),
      ],
    );
  }

  Widget lTile(BuildContext context, String category,
      IconData leadingIcon, String title, String id,
      bool showAddToCategory){
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryPost(userId: id,
                category: category,
            showAddToCategory: showAddToCategory,)));
      },
      leading: Icon(leadingIcon),
      title: Text(title),
      trailing: UniversalPlatform.isIOS ?
      const Icon(CupertinoIcons.forward) : const Icon(Icons.arrow_forward),
    );
  }
}
