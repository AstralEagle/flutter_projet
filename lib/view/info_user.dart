import "package:firstbd233/model/my_user.dart";
import "package:flutter/material.dart";

class InfoUser extends StatefulWidget {
  MyUser user;
  InfoUser({required this.user,super.key});

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(

         children: [
           CircleAvatar(
             radius: 150,
             backgroundImage: NetworkImage(widget.user.avatar!),
           ),
           Text(widget.user.fullName),
           Text(widget.user.email),
           Text("age ${widget.user.birthday.toString()}")

         ]
        )
      ),
    );
  }
}
