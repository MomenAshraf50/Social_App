
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_states.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';

import '../../../shared/components/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserDataModel? userDataModel;

  void getUserData() {
    emit(HomeGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
          userDataModel = UserDataModel.fromJson(value.data());
          emit(HomeGetUserSuccessState());
    })
        .catchError((error) {
          emit(HomeGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens= [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index){
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  File? profileImage;
  File? coverImage;
  ImagePicker imagePicker = ImagePicker();

  Future getProfileImage()async{
    await imagePicker.pickImage(source: ImageSource.gallery).then((value){
      profileImage = File(value!.path);
      emit(ProfileImagePickedSuccessState());
    }).catchError((error){
      emit(ProfileImagePickedErrorState());
      print(error);
    });
  }
  Future getCoverImage()async{
    await imagePicker.pickImage(source: ImageSource.gallery).then((value){
      coverImage = File(value!.path);
      emit(CoverImagePickedSuccessState());
    }).catchError((error){
      emit(CoverImagePickedErrorState());
      print(error);
    });
  }
  String? profileImageUrl;
  void uploadProfileImage(){
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value){
          value.ref.getDownloadURL().then((value){

            profileImageUrl = value;
            emit(ProfileImageUploadSuccessState());
          }).catchError((error){
            emit(ProfileImageUploadErrorState());
            print(error);
          });
    }).catchError((error){
      emit(ProfileImageUploadErrorState());
      print(error);
    });
  }

  String? coverImageUrl;
  void uploadCoverImage(){
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value){
        coverImageUrl = value;
        emit(CoverImageUploadSuccessState());
      }).catchError((error){
        print(error);
        emit(CoverImageUploadErrorState());
      });
    }).catchError((error){
      emit(CoverImageUploadErrorState());
      print(error);
    });
  }

  void updateUserData({
  required String name,
  required String bio,
  required String phone,
}){
    emit(UserUpdateLoadingState());
    if(profileImage != null){
      uploadProfileImage();
    }else if(coverImage != null){
      uploadCoverImage();
    }else{
      UserDataModel model = UserDataModel(
          name: name,
          email: userDataModel!.email,
          bio:bio,
          image: userDataModel!.image,
          coverImage: userDataModel!.coverImage,
          uid: userDataModel!.uid,
          phone: phone
      );
      FirebaseFirestore.instance.collection('users').doc(userDataModel!.uid).update(model.toMap())
          .then((value){
        getUserData();
      }).catchError((error){
        emit(UserUpdateErrorState());
      });
    }


  }
}
