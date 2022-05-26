import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degilib/common_widget/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../common.dart';

class AddToProfile extends StatefulWidget {
  const AddToProfile({Key? key}) : super(key: key);

  @override
  State<AddToProfile> createState() => _AddToProfileState();
}

class _AddToProfileState extends State<AddToProfile> {
  int index = 0;
  int selectedIndex = 0;
  TextEditingController? imgUrl, title, provider;
  String selectedCategory = "";

  final errorSnackBar = const SnackBar(
      content: Text("Title, Provider & Category are required fields")
  );

  @override
  void initState() {
    imgUrl = TextEditingController();
    title = TextEditingController();
    provider = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          children: [
            CustomTextField(imgUrl!, "Image", "", "", false, TextInputType.url,
                false, const [""]),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                title!, "Title", "", "", false, TextInputType.url, false, const [""]),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                provider!, "Provider", "Ex: Spotify", "", false,
                TextInputType.text, false, const [""]),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Category",
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              "Type below to select a category",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Visibility(
              visible: selectedCategory == "",
              child: Autocomplete(
                optionsBuilder: (TextEditingValue autoCompleteVal) {
                  if (autoCompleteVal.text == "") {
                    return const Iterable<String>.empty();
                  }
                  return categories.where((String option) {
                    return option.contains(autoCompleteVal.text.toLowerCase());
                  });
                },
                onSelected: (String selected) {
                  setState(() {
                    selectedCategory = selected;
                  });
                },
              ),
            ),
            Visibility(
              visible: selectedCategory != "",
              child: Card(
                child: ListTile(
                  title: Text(selectedCategory),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = "";
                      });
                    },
                    icon: UniversalPlatform.isIOS
                        ? const Icon(CupertinoIcons.clear)
                        : const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                  "If you don't see a category that means it's not supported yet",
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: UniversalPlatform.isIOS,
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                Visibility(
                  visible: UniversalPlatform.isIOS,
                  child: CupertinoButton.filled(
                    onPressed: () {
                      if(selectedCategory == "" || title!.text == ""
                      || provider!.text == ""){
                        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                      }
                      else{
                        upload();
                      }
                    },
                    child: const Text("Add"),
                  ),
                ),
                Visibility(
                  visible: !UniversalPlatform.isIOS,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                Visibility(
                  visible: !UniversalPlatform.isIOS,
                  child: ElevatedButton(
                    onPressed: () {
                      if(selectedCategory == "" || title!.text == ""
                      || provider!.text == ""){
                        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                      }
                      else{
                        upload();
                      }
                    },
                    child: const Text("Add"),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (UniversalPlatform.isIOS) {
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Info"),
                      content: const Text(
                          "To get image, search for the content on a browser and copy the image url"),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close"),
                        ),
                      ],
                    );
                  });
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Help"),
                  content: const Text(
                      "To get image, search for the content on a browser and copy the image url"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                  ],
                );
              },
            );
          },
          child: UniversalPlatform.isIOS
              ? const Icon(CupertinoIcons.question)
              : const Icon(Icons.help),
        ),
      ),
    );
  }

  void upload() {
    fStore.collection("users").doc(user!.uid).collection("posts").add({
      "img": imgUrl!.text,
      "title": title!.text,
      "provider": provider!.text,
      "category": selectedCategory,
      "added_on": FieldValue.serverTimestamp(),
    });
  }
}
