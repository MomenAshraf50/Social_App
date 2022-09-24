import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';
import 'package:social_app/modules/register/register_cubit/cubit.dart';
import '../../shared/components/componants.dart';


class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterErrorState){
            showToast(state.error.toString(), ToastStates.ERROR);
          }
          if(state is CreateUserSuccessState){
            navigateToAndFinish(context, LoginScreen());
            showToast('Account created successfully', ToastStates.SUCCESS);
          }
          if(state is CreateUserErrorState){
            showToast(state.error.toString(), ToastStates.ERROR);
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: ConditionalBuilder(
              condition: state is! RegisterLoadingState,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'Register now and connect with the world',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        controller: nameController,
                        label: 'User Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        prefix: Icons.person,
                        inputType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 20.0,
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
                          inputType: TextInputType.emailAddress),
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
                          prefix: Icons.lock_outline,
                          inputType: TextInputType.visiblePassword,
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffix: RegisterCubit.get(context).suffix,
                          onPressed: () {
                            RegisterCubit.get(context).changePasswordVisibility();
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                          controller: rePasswordController,
                          label: 'RePassword',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please re enter your password';
                            } else if (value != passwordController.text) {
                              return 'Password and RePassword dose not match';
                            }
                            return null;
                          },
                          prefix: Icons.lock_outline,
                          inputType: TextInputType.visiblePassword,
                          isPassword: RegisterCubit.get(context).isRePassword,
                          suffix: RegisterCubit.get(context).rePasswordSuffix,
                          onPressed: () {
                            RegisterCubit.get(context).changeRePasswordVisibility();
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                        controller: phoneController,
                        label: 'Phone Number',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please re enter your password';
                          }
                          return null;
                        },
                        prefix: Icons.phone,
                        inputType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultButton(
                          text: 'Register',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
              fallback:(context) =>  const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ),
    );
  }
}
