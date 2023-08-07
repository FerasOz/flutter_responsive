import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/social_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/social_app/cubit/states.dart';
import 'package:new_project_flutter/models/social_app/user_model/social_user_model.dart';
import 'package:new_project_flutter/modules/social_app/chat_details/chat_details_screen.dart';

import '../../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state){},
        builder: (context, state){
          return ConditionalBuilder(
              condition: SocialCubit.get(context).users.isNotEmpty,
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildChatItem(context, SocialCubit.get(context).users[index]),
                  separatorBuilder: (context, index) => divider(),
                  itemCount: SocialCubit.get(context).users.length
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        }
    );
  }

  Widget buildChatItem(context, SocialUserModel model){
    return  InkWell(
      onTap: (){
        navigateTo(context, ChatDetailsScreen(model: model,));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                model.image,
              ),
              radius: 25.0,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                model.name,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
