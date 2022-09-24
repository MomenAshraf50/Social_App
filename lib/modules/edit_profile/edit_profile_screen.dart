import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_cubit.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_states.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/shared/components/componants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){
        if(state is UserUpdateSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context,state) {
        File? profileImage = homeCubit.profileImage;
        File? coverImage = homeCubit.coverImage;
        UserDataModel? userDataModel = HomeCubit.get(context).userDataModel;
        if(homeCubit.userDataModel!= null){
          nameController.text = userDataModel!.name.toString();
          bioController.text = userDataModel.bio.toString();
          phoneController.text = userDataModel.phone.toString();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            titleSpacing: 5,
            actions: [
              defaultTextButton(onPressed: (){
                homeCubit.updateUserData(name: nameController.text, bio: bioController.text, phone: phoneController.text);
              }, text: 'Update'),
              const SizedBox(width: 15,)
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is UserUpdateLoadingState) const LinearProgressIndicator(),
                  SizedBox(
                    height: 220,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children:[
                                Container(
                                width: double.infinity,
                                height: 160,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration:   BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    image: DecorationImage(
                                        image: coverImage == null? NetworkImage(
                                            '${userDataModel!.coverImage}'):FileImage(coverImage) as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                                IconButton(
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    homeCubit.getCoverImage();
                                  },
                                )
                              ]
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 62,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child:  CircleAvatar(
                                  radius: 60,
                                  backgroundImage:profileImage == null? NetworkImage('${userDataModel!.image}'): FileImage(profileImage) as ImageProvider,
                                ),
                              ),
                              IconButton(
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  ),
                                ),
                                onPressed: (){
                                  homeCubit.getProfileImage();
                                },
                              ),
                            ],
                          )
                        ]
                    ),
                  ),
                  const SizedBox(height: 20,),
                  defaultTextFormField(
                    controller: nameController,
                    label: 'Name',
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Name field can\'t be empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.Profile,
                    inputType: TextInputType.name,),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    label: 'Phone',
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Phone field can\'t be empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.Call,
                    inputType: TextInputType.phone,),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    label: 'Bio',
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Bio field can\'t be empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.Info_Circle,
                    inputType: TextInputType.text,),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
