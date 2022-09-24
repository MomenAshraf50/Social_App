import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/home_layout.dart';
import 'package:social_app/modules/login/login_cubit/cubit.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/componants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'login_cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LogInCubit(),
      child: BlocConsumer<LogInCubit,LogInStates>(
        listener: (context,state){
          if(state is LogInErrorState){
            showToast(state.error.toString(), ToastStates.ERROR);
          }
          if(state is LogInSuccessState){
            showToast('LogIn Success', ToastStates.SUCCESS);
            CacheHelper.saveData(key: 'uid', value: state.uid).then((value){
              navigateToAndFinish(context, HomeLayout());
            });
          }
        } ,
        builder: (context,state) => Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: state is! LogInLoadingState,
              builder:(context) => Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                color: Colors.black
                            ),
                          ),
                          Text(
                            'Login now and connect with the world',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormField(
                              controller: emailController,
                              label: 'Email',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              prefix: Icons.email_outlined,
                              inputType: TextInputType.emailAddress
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultTextFormField(
                              controller: passwordController,
                              label: 'Password',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              onSubmitted: (value) {
                                if (formKey.currentState!.validate()) {}
                              },
                              prefix: Icons.lock_outline,
                              inputType: TextInputType.visiblePassword,
                              isPassword: LogInCubit.get(context).isPassword,
                              suffix: LogInCubit.get(context).suffix,
                              onPressed: () {
                                LogInCubit.get(context).changePasswordVisibility();
                              }
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultButton(text: 'Log In', onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LogInCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  }, child: const Text('Register Now'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              fallback:(context)=> const Center(child: CircularProgressIndicator(),),
            )),
      ),
    );
  }
}
