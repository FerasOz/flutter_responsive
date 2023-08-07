import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://instagram.fgza2-1.fna.fbcdn.net/v/t51.2885-19/242743157_1026270428149183_4013466099961349484_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fgza2-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=Mk3ldDNskfAAX-v8teR&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT_RwwnT_I-50mBJ-305IyR5_xMYRQ4gboHxYZHc9yAHmw&oe=631C67EB&_nc_sid=8fd12b'),
            ),
            SizedBox(width: 10.0,),
            Text(
              "chats",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: CircleAvatar(
              backgroundColor: Colors.grey[400],
                child: Icon(
                  Icons.camera_alt,
                  size: 20.0,
                  color: Colors.white,
                )

            ),
          ),
          IconButton(
            onPressed: (){},
            icon: CircleAvatar(
                backgroundColor: Colors.grey[400],
                child: Icon(
                  Icons.edit,
                  size: 20.0,
                  color: Colors.white,
                )

            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(30.0),
                  color: Colors.grey[400],
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildStoryItem(),
                  separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                    itemCount: 10,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.0,
                  ),
                  itemCount: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

 Widget buildStoryItem() => Container(
      width: 60.0,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  'https://instagram.fgza2-1.fna.fbcdn.net',
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0,
                ),
                child: CircleAvatar(
                  radius: 7.0,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            "Feras Osama Feras Osama Feras Osama Feras Osama",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

          )
        ],
      ),
    );

 Widget buildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              'https://instagram.fgza2-1.fna.fbcdn.net',
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 3.0,
              end: 3.0,
            ),
            child: CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Feras Osama",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Hello, my name is Feras Hello, my name is Feras Hello, my name is Feras Hello, my name is Feras",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                  child: Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text("02:00 pm",),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
