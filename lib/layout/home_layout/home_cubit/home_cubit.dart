import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_states.dart';
import 'package:social_app/models/post_model.dart';
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
      if(profileImage != null){
        uploadProfileImage();
      }
    }).catchError((error){
      emit(ProfileImagePickedErrorState());
      print(error);
    });
  }
  Future getCoverImage()async{
    await imagePicker.pickImage(source: ImageSource.gallery).then((value){
      coverImage = File(value!.path);
      emit(CoverImagePickedSuccessState());
      if(coverImage != null){
       uploadCoverImage();
      }
    }).catchError((error){
      emit(CoverImagePickedErrorState());
      print(error);
    });
  }
  String? profileImageUrl;
  void uploadProfileImage(){
    emit(UserUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value){
          value.ref.getDownloadURL().then((value){
            profileImageUrl = value;
            updateUserData(profile: profileImageUrl);
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
    emit(UserUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value){
        coverImageUrl = value;
        updateUserData(cover: coverImageUrl);
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
    String? name,
    String? bio,
    String? phone,
    String? cover,
    String? profile,

}){
    emit(UserUpdateLoadingState());

    UserDataModel model = UserDataModel(
        name: name?? userDataModel!.name,
        email: userDataModel!.email,
        bio:bio?? userDataModel!.bio,
        image: profile?? userDataModel!.image,
        coverImage: cover?? userDataModel!.coverImage,
        uid: userDataModel!.uid,
        phone: phone?? userDataModel!.phone
    );
      FirebaseFirestore.instance.collection('users').doc(userDataModel!.uid).update(model.toMap())
          .then((value){
        getUserData();
        emit(UserUpdateSuccessState());
      }).catchError((error){
        emit(UserUpdateErrorState());
      });
    }

  File? postImage;
  Future getPostImage()async{
    await imagePicker.pickImage(source: ImageSource.gallery).then((value){
      postImage = File(value!.path);
      emit(PostImagePickedSuccessState());
    }).catchError((error){
      emit(PostImagePickedErrorState());
      print(error);
    });
  }

  void removePostImage(){
    postImage = null;
    emit(RemovePostImageState());
  }

  String? postImageUrl;
  void uploadPostImage({
    required String dateTime,
    required String postText,
}){
    emit(CreatePostLoadingState());

    FirebaseStorage.instance.
      ref().child('posts${Uri.file(postImage!.path).pathSegments.last}')
      .putFile(postImage!).then((value){
        value.ref.getDownloadURL().then((value){
          postImageUrl = value;
          createPost(dateTime: dateTime, postText: postText,postImage: postImageUrl);
          emit(PostImageUploadSuccessState());
        }).catchError((error){
          emit(PostImageUploadErrorState());
        });
    }).catchError((error){
      emit(PostImageUploadErrorState());
    });

  }

  void createPost({
    required String dateTime,
    required String postText,
    String? postImage,

  }){
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userDataModel!.name,
      image: userDataModel!.image,
      uid: userDataModel!.uid,
      dateTime: dateTime,
      postText: postText,
      postImage: postImage
    );
    FirebaseFirestore.instance.collection('posts').add(model.toMap())
        .then((value){
      emit(CreatePostSuccessState());
    }).catchError((error){
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts =[];
  List<String> postsId =[];
  List<int> likes =[];

  void getPosts(){
    FirebaseFirestore.instance.collection('posts').get().then((value){

      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value){
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error){});
      });

      emit(HomeGetPostsSuccessState());
    }).catchError((error){
      emit(HomeGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes')
        .doc(userDataModel!.uid).set({
      'like':true
    }).then((value){
      emit(LikePostSuccessState());
    }).catchError((error){
      emit(LikePostErrorState(error));
    });
  }


}
