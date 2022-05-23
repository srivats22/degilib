import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Text("Category",
        style: Theme.of(context).textTheme.headline6,),
        ListTile(
          onTap: (){},
          leading: Icon(Icons.person),
          title: Text("Artists"),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          onTap: (){},
          leading: Icon(Icons.movie),
          title: Text("Movie"),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          onTap: (){},
          leading: Icon(Icons.music_note),
          title: Text("Music"),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          onTap: (){},
          leading: Icon(Icons.tv),
          title: Text("Shows"),
          trailing: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
