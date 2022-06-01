import 'package:cloud_firestore/cloud_firestore.dart';

class UserSearchModel {
  final String? name, uid;

  UserSearchModel({this.name, this.uid});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold
  List<UserSearchModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return UserSearchModel(
        name: dataMap['name'],
        uid: dataMap['uid'],
      );
    }).toList();
  }
}
