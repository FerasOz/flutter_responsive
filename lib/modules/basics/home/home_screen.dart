
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          "First App",
        ),
        actions:
        [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: onNotifications,
          ),

        ],
      ),
      body: Column(
        children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20.0),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                      image: NetworkImage(
                      "https://img.freepik.com/free-photo/purple-osteospermum-daisy-flower_1373-16.jpg",
                      ),
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 200.0,
                      color: Colors.black.withOpacity(0.6),
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                      ),
                      child: Text(
                        "Flower",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );

  }

  void onNotifications(){
    print("Notification");
  }

}