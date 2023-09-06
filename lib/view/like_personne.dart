import "package:cloud_firestore/cloud_firestore.dart";
import "package:firstbd233/view/info_user.dart";
import "package:flutter/material.dart";

import "../constante/constant.dart";
import "../controller/firebase_helper.dart";
import "../model/my_user.dart";

class LikePersonne extends StatefulWidget {
  const LikePersonne({Key? key}) : super(key: key);

  @override
  State<LikePersonne> createState() => _LikePersonneState();
}

class _LikePersonneState extends State<LikePersonne> {
  // FirebaseHelper().cloud_likes.where

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseHelper().cloud_users.snapshots(),
        builder: (context, snap) {
          if (snap.data == null) {
            return Center(
              child: Text("Aucun utilisateur"),
            );
          } else {
            List documents = snap.data!.docs
                .where((el) => moi.liked.contains(el.id))
                .toList();
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  MyUser users = MyUser.bdd(documents[index]);
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return InfoUser(user: users);
                        }));
                      },
                      child: Card(
                        elevation: 5,
                        color: Colors.purple,
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(users.avatar!),
                            ),
                            title: Text(users.fullName),
                            subtitle: Text(users.email),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (moi.liked.contains(users.uid)) {
                                    moi.liked
                                        .removeWhere((el) => el == users.uid);
                                  } else {
                                    moi.liked.add(users.uid);
                                  }
                                  FirebaseHelper().updateUser(
                                      moi.uid, {"LIKED": moi.liked});
                                });
                              },
                              child: Icon(moi.liked.contains(users.uid)
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                            )),
                      ));
                });
          }
        });
  }
}
