import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/user/user_model.dart';



class UserScreen extends StatelessWidget {

  List<UserModel> users = [
    UserModel(id: 1, name: "Feras osama", number: "0595974716"),
    UserModel(id: 2, name: "Hassan osama", number: "0595985416"),
    UserModel(id: 3, name: "Khaled Samy", number: "0594030149"),
    UserModel(id: 4, name: "Ali Samy", number: "0595123416"),
    UserModel(id: 5, name: "Younis Mohammed", number: "0595974777"),
    UserModel(id: 6, name: "Hamza Nabil", number: "0590004716"),
    UserModel(id: 7, name: "Hazem Zeyad", number: "0595977416"),
    UserModel(id: 8, name: "Maisara Mohsen", number: "0595974569"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "users",
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => UserItemBuild(users[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 25.0,
            ),
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1.0,
            ),
          ),
          itemCount: users.length
      ),
    );
  }

  Widget UserItemBuild(UserModel users) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            "${users.id}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${users.name}",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${users.number}",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
