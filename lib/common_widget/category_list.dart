import 'package:degilib/screens/category_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Category",
        style: Theme.of(context).textTheme.headline6,),
        lTile(context, "artist", Icons.person, "Artists"),
        lTile(context, "movie", Icons.movie, "Movie"),
        lTile(context, "music", Icons.music_note, "Music"),
        lTile(context, "shows", Icons.tv, "Shows"),
      ],
    );
  }

  Widget lTile(BuildContext context, String category, IconData leadingIcon, String title){
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryPost(category: category)));
      },
      leading: Icon(leadingIcon),
      title: Text(title),
      trailing: UniversalPlatform.isIOS ?
      const Icon(CupertinoIcons.forward) : const Icon(Icons.arrow_forward),
    );
  }
}
