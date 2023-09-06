import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstbd233/controller/firebase_helper.dart';
import 'package:firstbd233/model/my_user.dart';
import 'package:flutter/material.dart';

import '../constante/constant.dart';
import 'info_user.dart';

class ListPersonne extends StatefulWidget {
  const ListPersonne({super.key});

  @override
  State<ListPersonne> createState() => _ListPersonneState();
}

class _ListPersonneState extends State<ListPersonne> {
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
            List documents =
                snap.data!.docs.where((el) => el.id != moi.uid).toList();
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  MyUser users = MyUser.bdd(documents[index]);
                  return
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return InfoUser(user: users);
                              }
                          ));                      },
                        child:Card(
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
                                moi.liked.removeWhere((el) => el == users.uid);
                              } else {
                                moi.liked.add(users.uid);
                              }
                              FirebaseHelper()
                                  .updateUser(moi.uid, {"LIKED": moi.liked});
                            });
                          },
                          child: Icon(moi.liked.contains(users.uid)
                              ? Icons.favorite
                              : Icons.favorite_border),
                        )),
                  )
                  );
                });
          }
        });
  }
}
