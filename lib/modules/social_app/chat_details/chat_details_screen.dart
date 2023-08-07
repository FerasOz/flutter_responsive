import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/social_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/social_app/cubit/states.dart';
import 'package:new_project_flutter/models/social_app/message_model/message_model.dart';
import 'package:new_project_flutter/models/social_app/user_model/social_user_model.dart';
import 'package:new_project_flutter/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel? model;
  var messageController = TextEditingController();

  ChatDetailsScreen({
    this.model,
});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiverId: model!.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state){},
          builder: (context, state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(model!.image),
                    ),
                    const SizedBox( width: 15.0,),
                    Text(model!.name),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                  condition: SocialCubit.get(context).message.length>0,
                  builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // const SizedBox(height: 10.0,),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index){
                          var message = SocialCubit.get(context).message[index];
                          if(SocialCubit.get(context).userModel!.uId == message.senderId) {
                            return buildMyMessage(message);
                          }else {
                            return buildMessage(message);
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 15.0,),
                        itemCount: SocialCubit.get(context).message.length,
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.4),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Row(

                        children: [
                          const SizedBox(width: 10.0,),
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message here ...'
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: primaryColor,
                            child: MaterialButton(
                              onPressed: (){
                                SocialCubit.get(context).sendMessage(receiverId: model!.uId, dateTime: DateTime.now().toString(), text: messageController.text);
                              },
                              child: const Icon(Icons.send, size: 16.0, color: Colors.white,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                  fallback: (context) => const Center(child: CircularProgressIndicator())),
            );
          },
        );
      }
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0,),
          topStart: Radius.circular(10.0,),
          topEnd: Radius.circular(10.0,),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      child: Text(
        model.text,
        style: const TextStyle(
            fontSize: 15.0
        ),
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.2,),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0,),
          topStart: Radius.circular(10.0,),
          topEnd: Radius.circular(10.0,),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      child: Text(
        model.text,
        style: const TextStyle(
            fontSize: 15.0
        ),
      ),
    ),
  );
}
