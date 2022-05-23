import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../common.dart';

class ProfileLayout extends StatefulWidget {
  const ProfileLayout({Key? key}) : super(key: key);

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      // shrinkWrap: true,
      children: [
        ExcludeSemantics(
          child: CircleAvatar(
            radius: 50,
            child: Text("${fAuth.currentUser!.displayName![0].toUpperCase()}",
              style: Theme.of(context).textTheme.headline3
                  ?.copyWith(color: Colors.white),),
          ),
        ),
        const SizedBox(height: 5,),
        Text("${fAuth.currentUser!.displayName}",
          style: Theme.of(context).textTheme.headline4,),
        const SizedBox(height: 5,),
        Text("${fAuth.currentUser!.email}",
          style: Theme.of(context).textTheme.headline5,),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        Text("App Related",
        style: Theme.of(context).textTheme.headline5,),
        ListTile(
          onTap: (){},
          leading: Icon(Icons.privacy_tip),
          title: Text("Privacy"),
        ),
        ListTile(
          onTap: (){},
          leading: Icon(Icons.info),
          title: Text("About App"),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        Text("General",
          style: Theme.of(context).textTheme.headline5,),
        ListTile(
          onTap: (){},
          leading: Icon(Icons.share),
          title: Text("Share App"),
        ),
        ListTile(
          onTap: (){},
          leading: Icon(Icons.email),
          title: Text("Contact Developer"),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        Text("Account",
          style: Theme.of(context).textTheme.headline5,),
        const SizedBox(height: 10,),
        ElevatedButton(
          onPressed: (){},
          child: Text("Log out"),
        ),
        const SizedBox(height: 10,),
        ElevatedButton(
          onPressed: (){},
          child: Text("Delete Account"),
          style: ElevatedButton.styleFrom(primary: Colors.red,
              onPrimary: Colors.white),
        ),
      ],
    );
  }
}
