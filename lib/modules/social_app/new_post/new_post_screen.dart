import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/social_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/social_app/cubit/states.dart';

class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Post'),
              actions: [
                TextButton(
                    onPressed: () {
                  if(SocialCubit.get(context).postImage == null){
                    SocialCubit.get(context).createPost(text: textController.text, dateTime: DateTime.now().toString());
                  }else{
                    SocialCubit.get(context).uploadPostImage(text: textController.text, dateTime: DateTime.now().toString());
                  }
                },
                    child: const Text('Post')
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialCreatePostLoadingState)
                    const SizedBox(height: 10.0,),
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/portrait-young-beautiful-woman-gesticulating_273609-40418.jpg?w=996&t=st=1689956894~exp=1689957494~hmac=3a43ef84499fa9b1dea9a5aa3b2d81e4d8260bc8b46eeadb46f096921dffc3e5',
                        ),
                        radius: 25.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          'Feras Osama',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'What is on your mind ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if(SocialCubit.get(context).postImage != null)
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            width: double.infinity,
                            height: 400.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                                image: DecorationImage(
                                    image: FileImage(SocialCubit.get(context).postImage!),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        CircleAvatar(
                          radius: 16.0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                            onPressed: () {
                              SocialCubit.get(context).removePostImage();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: (){
                              SocialCubit.get(context).getPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                              Icon(Icons.image),
                              Text('Add Photo'),
                            ],
                            )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: (){},
                            child: const Text('# Tags'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
