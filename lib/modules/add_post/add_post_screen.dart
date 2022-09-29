import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_cubit.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_states.dart';
import 'package:social_app/shared/components/componants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class AddPostScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextEditingController postTextController = TextEditingController();
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){
        if(state is CreatePostSuccessState){
          Navigator.pop(context);
        }
      },
      builder: (context ,state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            titleSpacing: 5,
            actions: [
              defaultTextButton(onPressed: (){
                var dateTime = DateTime.now();
                if(homeCubit.postImage ==null){
                  homeCubit.createPost(dateTime: dateTime.toString(), postText: postTextController.text,);
                }else{
                  homeCubit.uploadPostImage(dateTime: dateTime.toString(), postText: postTextController.text,);
                }
              }, text: 'Post')
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                Row(
                  children:  [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          homeCubit.userDataModel!.image.toString()),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        homeCubit.userDataModel!.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postTextController,
                    decoration: const InputDecoration(
                      hintText: 'What is in your mind.',
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                if(homeCubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children:[
                      Container(
                        width: double.infinity,
                        height: 200,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration:   BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: FileImage(homeCubit.postImage as File),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                        onPressed: () {
                          homeCubit.removePostImage();
                        },
                      )
                    ]
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          homeCubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5,),
                            Text('Add photo')
                          ],
                        ),),
                    ),
                    Expanded(
                      child: defaultTextButton(onPressed: (){}, text: '# Tags')
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
