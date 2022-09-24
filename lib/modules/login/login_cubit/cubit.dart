import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/login_cubit/states.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInInitialState());

  static LogInCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LogInLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      emit(LogInSuccessState(value.user!.uid));
      print(value.user!.email);
    }).catchError((error){
      emit(LogInErrorState(error.toString()));
      print(error.toString());
    });

  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());

  }
}
