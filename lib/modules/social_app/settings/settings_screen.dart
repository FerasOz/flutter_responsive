import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/social_app/cubit/states.dart';
import 'package:new_project_flutter/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:new_project_flutter/shared/components/components.dart';

import '../../../layout/social_app/cubit/cubit.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit
            .get(context)
            .userModel!;

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        width: double.infinity,
                        height: 170.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(4.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${model.cover}',
                                ),
                                fit: BoxFit.cover)
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 53.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${model.image}'
                        ),
                        radius: 48.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                '${model.name}',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,
              ),
              Text(
                '${model.bio}',
                style: Theme
                    .of(context)
                    .textTheme
                    .caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '200',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                              Text(
                                'Posts',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        )
                    ),
                    Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '70',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                              Text(
                                'Photos',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        )
                    ),
                    Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '13K',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                              Text(
                                'Followers',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        )
                    ),
                    Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '64',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                              Text(
                                'Following',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        )
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          'Add Photos',
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      )
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: const Icon(Icons.edit_outlined, size: 16.0,),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
