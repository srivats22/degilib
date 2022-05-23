import 'package:cloud_firestore/cloud_firestore.dart';

class LibSearch {
  final String? category, imgUrl, link, provider, title;

  LibSearch({this.category, this.imgUrl, this.link, this.provider, this.title});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold
  List<LibSearch> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return LibSearch(
        category: dataMap['category'],
        imgUrl: dataMap['imgUrl'],
        link: dataMap['link'],
        provider: dataMap['provider'],
        title: dataMap['title'],
      );
    }).toList();
  }
}

