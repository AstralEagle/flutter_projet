import 'package:cloud_firestore/cloud_firestore.dart';

class MyLike {
  late String uid;
  late String user;
  late String liked;

  MyLike() {
    uid = "";
    user = "";
    liked = "";
  }

  MyLike.bdd(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    user = map["user"];
    liked = map["liked"];
  }

  String textInfo() {
    return "Like : $user -- $liked";
  }
}
