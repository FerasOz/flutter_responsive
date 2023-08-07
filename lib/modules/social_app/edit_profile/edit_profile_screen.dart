import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/social_app/cubit/states.dart';
import 'package:new_project_flutter/shared/components/components.dart';

import '../../../layout/social_app/cubit/cubit.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = SocialCubit.get(context).userModel!;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;
          nameController.text = model.name;
          bioController.text = model.bio;
          phoneController.text = model.phone;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              actions: [
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          bio: bioController.text,
                          phone: phoneController.text);
                    },
                    child: const Text('UPDATE')),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialUserUpdateLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SocialUserUpdateLoadingState)
                      const SizedBox(
                        height: 15.0,
                      ),
                    Container(
                      height: 200.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Container(
                                  width: double.infinity,
                                  height: 170.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4.0)),
                                      image: DecorationImage(
                                          image: coverImage == null
                                              ? NetworkImage('${model.cover}')
                                              : FileImage(coverImage)
                                                  as ImageProvider,
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              CircleAvatar(
                                radius: 16.0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 16.0,
                                  ),
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 53.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${model.image}')
                                      : FileImage(profileImage) as ImageProvider,
                                  radius: 48.0,
                                ),
                              ),
                              CircleAvatar(
                                radius: 16.0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 16.0,
                                  ),
                                  onPressed: () {
                                    SocialCubit.get(context).getImageProfile();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                                child: Column(
                                  children: [
                                    defaultButton(
                                        text: 'upload Profile', function: () {
                                          SocialCubit.get(context).uploadProfileImage(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                                    }),
                                    if (state is SocialUserUpdateLoadingState)
                                      const SizedBox(
                                      height: 5.0,
                                    ),
                                    if (state is SocialUserUpdateLoadingState)
                                      const LinearProgressIndicator(),
                                  ],
                                )),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                                child: Column(
                                  children: [
                                    defaultButton(
                                        text: 'upload Cover', function: () {
                                      SocialCubit.get(context).uploadCoverImage(name: nameController.text, bio: bioController.text, phone: phoneController.text);

                                    }),
                                    if (state is SocialUserUpdateLoadingState)
                                      const SizedBox(
                                      height: 7.0,
                                    ),
                                    if (state is SocialUserUpdateLoadingState)
                                      const LinearProgressIndicator(),
                                  ],
                                )),
                        ],
                      ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 25.0,
                    ),
                    defaultFormFeild(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        label: 'name',
                        prefix: Icons.person_outline),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormFeild(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        label: 'phone',
                        prefix: Icons.phone_outlined),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormFeild(
                        controller: bioController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Bio must not be empty';
                          }
                          return null;
                        },
                        label: 'bio',
                        prefix: Icons.info_outlined),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
