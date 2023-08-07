import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/models/social_app/user_model/social_user_model.dart';
import 'package:new_project_flutter/modules/social_app/social_register/cubit/states.dart';
import 'package:new_project_flutter/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel mdoel =
        SocialUserModel(
            name: name,
            email: email,
            phone: phone,
            uId: uId,
            bio: 'write your bio',
            image: 'https://img.freepik.com/free-photo/smiling-caucasian-young-guy-wearing-pink-shirt-showing-size-isolated-orange-background_141793-38630.jpg?w=996&t=st=1690122476~exp=1690123076~hmac=3a590ab9247906821a2fdede77b016d178cebcafcde85ee3d6972217e2386c54',
            cover: 'https://img.freepik.com/free-photo/work-message-lightbox-arrangement_23-2149150446.jpg?w=996&t=st=1690122550~exp=1690123150~hmac=595522b9176d0a7f8a0252dd97c96e183f704c592bfc43b11a77024e78eba939',
            isEmailVerified: false,
        );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(mdoel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
