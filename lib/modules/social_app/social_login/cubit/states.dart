abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginChangePasswordVisibilityState extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates{

  final String uId;

  SocialLoginSuccessState(this.uId);

}

class SocialLoginErrorState extends SocialLoginStates{
  final error;

  SocialLoginErrorState(this.error);
}
