import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
      createUser(email: email, phone: phone, name: name,uid: value.user!.uid);
      emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });

  }

  void createUser({
    required String email,
    required String phone,
    required String name,
    required String uid,
}){

    UserDataModel userDataModel = UserDataModel(
      email: email,
      phone: phone,
      name: name,
      uid: uid,
      image: 'https://cdn-icons-png.flaticon.com/512/2133/2133364.png',
      coverImage: 'https://img.freepik.com/free-vector/space-background-with-landscape-planet_107791-797.jpg?w=740&t=st=1663684402~exp=1663685002~hmac=dbe38846df008ce17b9e25f6f1a1bb8848d6ba240e75c722b5e3a15506d262f1',
      bio: 'write your bio ...'
    );
    FirebaseFirestore.instance.collection('users').doc(uid).set(userDataModel.toMap()).then((value){
      emit(CreateUserSuccessState());
    }).catchError((error){
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());

  }
  IconData rePasswordSuffix = Icons.visibility_outlined;
  bool isRePassword = true;
  void changeRePasswordVisibility(){
    isRePassword = !isRePassword;
    rePasswordSuffix = isRePassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());

  }
}
