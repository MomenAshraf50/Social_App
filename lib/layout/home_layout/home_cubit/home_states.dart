abstract class HomeStates{}

class HomeInitialState extends HomeStates{}
class HomeGetUserSuccessState extends HomeStates{}
class HomeGetUserLoadingState extends HomeStates{}
class HomeGetUserErrorState extends HomeStates{
  String? error;

  HomeGetUserErrorState(this.error);
}

class HomeGetPostsSuccessState extends HomeStates{}
class HomeGetPostsLoadingState extends HomeStates{}
class HomeGetPostsErrorState extends HomeStates{
  String? error;

  HomeGetPostsErrorState(this.error);
}

class LikePostSuccessState extends HomeStates{}
class LikePostErrorState extends HomeStates{
  String? error;

  LikePostErrorState(this.error);
}

class HomeChangeBottomNavState extends HomeStates{}
class HomeAddPostState extends HomeStates{}
class ProfileImagePickedSuccessState extends HomeStates{}
class ProfileImagePickedErrorState extends HomeStates{}
class CoverImagePickedSuccessState extends HomeStates{}
class CoverImagePickedErrorState extends HomeStates{}

class ProfileImageUploadSuccessState extends HomeStates{}

class ProfileImageUploadErrorState extends HomeStates{}

class CoverImageUploadSuccessState extends HomeStates{}

class CoverImageUploadErrorState extends HomeStates{}

class UserUpdateErrorState extends HomeStates{}
class UserUpdateSuccessState extends HomeStates{}

class UserUpdateLoadingState extends HomeStates{}

class CreatePostSuccessState extends HomeStates{}

class CreatePostErrorState extends HomeStates{}

class CreatePostLoadingState extends HomeStates{}

class PostImagePickedSuccessState extends HomeStates{}
class PostImagePickedErrorState extends HomeStates{}
class RemovePostImageState extends HomeStates{}

class PostImageUploadSuccessState extends HomeStates{}

class PostImageUploadErrorState extends HomeStates{}