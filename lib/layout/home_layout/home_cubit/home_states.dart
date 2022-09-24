abstract class HomeStates{}

class HomeInitialState extends HomeStates{}
class HomeGetUserSuccessState extends HomeStates{}
class HomeGetUserLoadingState extends HomeStates{}
class HomeGetUserErrorState extends HomeStates{
  String? error;

  HomeGetUserErrorState(this.error);
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
class UserUpdateLoadingState extends HomeStates{}