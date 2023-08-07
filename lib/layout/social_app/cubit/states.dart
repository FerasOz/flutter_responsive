abstract class SocialStates{}

class SocialInitialStates extends SocialStates{}

class SocialGetUserSuccessStates extends SocialStates{}

class SocialGetUserLoadingStates extends SocialStates{}

class SocialGetUserErrorStates extends SocialStates{
  final error;

  SocialGetUserErrorStates(this.error);
}

class SocialGetAllUserSuccessStates extends SocialStates{}

class SocialGetAllUserLoadingStates extends SocialStates{}

class SocialGetAllUserErrorStates extends SocialStates{
  final error;

  SocialGetAllUserErrorStates(this.error);
}

class SocialGetPostsSuccessStates extends SocialStates{}

class SocialGetPostsLoadingStates extends SocialStates{}

class SocialGetPostsErrorStates extends SocialStates{
  final error;

  SocialGetPostsErrorStates(this.error);
}

class SocialLikePostSuccessStates extends SocialStates{}

class SocialLikePostErrorStates extends SocialStates{
  final error;

  SocialLikePostErrorStates(this.error);
}

class SocialCommentPostSuccessStates extends SocialStates{}

class SocialCommentPostErrorStates extends SocialStates{
  final error;

  SocialCommentPostErrorStates(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}


// Create Post

class SocialCreatePostErrorState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}


// chat

class SocialSendMassageSuccessState extends SocialStates{}

class SocialSendMassageErrorState extends SocialStates{}

class SocialGetMassagesSuccessState extends SocialStates{}

class SocialGetMassagesErrorState extends SocialStates{}