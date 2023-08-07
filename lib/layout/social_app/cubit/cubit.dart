import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project_flutter/layout/social_app/cubit/states.dart';
import 'package:new_project_flutter/models/social_app/message_model/message_model.dart';
import 'package:new_project_flutter/models/social_app/post_model/post_model.dart';
import 'package:new_project_flutter/models/social_app/user_model/social_user_model.dart';
import 'package:new_project_flutter/modules/social_app/feeds/feeds_screen.dart';
import 'package:new_project_flutter/modules/social_app/new_post/new_post_screen.dart';
import 'package:new_project_flutter/shared/components/constants.dart';

import '../../../modules/social_app/chats/chats_screen.dart';
import '../../../modules/social_app/settings/settings_screen.dart';
import '../../../modules/social_app/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingStates());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  int currentIndex = 0;

  List<String> ScreenNames = ['Home', 'Chats', 'Add Post', 'Users', 'Settings'];

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getImageProfile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users')
        .child(Uri.file(profileImage!.path).pathSegments.last)
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error.toString());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
      print(error.toString());
    });
  }

  // void updateUserImage({
  //   required String name,
  //   required String bio,
  //   required String phone,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else {
  //     updateUser(name: name, bio: bio, phone: phone);
  //   }
  // }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uId: userModel!.uId,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
      print(error.toString());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  // List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          // comments.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessStates());
    }).catchError((error) {
      emit(SocialGetPostsErrorStates(error.toString()));
      print(error.toString());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostErrorStates(error.toString()));
      print(error.toString());
    });
  }

  //
  // void commentPost(String postId, String comment) {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('comments')
  //       .doc(userModel!.uId)
  //       .set({'comment': comment}).then((value) {
  //     emit(SocialCommentPostSuccessStates());
  //   }).catchError((error) {
  //     emit(SocialCommentPostErrorStates(error.toString()));
  //     print(error.toString());
  //   });
  // }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUserSuccessStates());
      }).catchError((error) {
        emit(SocialGetAllUserErrorStates(error.toString()));
        print(error.toString());
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMassageSuccessState());
    }).catchError((error) {
      emit(SocialSendMassageErrorState());
      print(error.toString());
    });

    //--------------------------------------

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMassageSuccessState());
    }).catchError((error) {
      emit(SocialSendMassageErrorState());
      print(error.toString());
    });
  }

  List<MessageModel> message = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMassagesSuccessState());
    });
  }
}
