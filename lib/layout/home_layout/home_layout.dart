import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_cubit.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_states.dart';
import 'package:social_app/modules/add_post/add_post_screen.dart';
import 'package:social_app/modules/notifications/notifications_screen.dart';
import 'package:social_app/modules/search/search_screen.dart';
import 'package:social_app/shared/components/componants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder:(context,state) => Scaffold(
        appBar: AppBar(
          title: Text(homeCubit.titles[homeCubit.currentIndex]),
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, NotificationsScreen());
            }, icon: const Icon(IconBroken.Notification)),
            IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, icon: const Icon(IconBroken.Search)),
          ],
        ),
        body: ConditionalBuilder(
          condition: HomeCubit.get(context).userDataModel != null,
          builder:(context){
            return Column(
              children: [
                if (!FirebaseAuth.instance.currentUser!.emailVerified) Container(
                  color: Colors.amber.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber),
                        const SizedBox(width: 10,),
                        const Expanded(child: Text('Please verify your email')),
                        TextButton(onPressed: (){
                          FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
                            showToast('check your mail for verification', ToastStates.SUCCESS);
                          }).catchError((error){});
                        }, child: const Text("Send verification"))

                      ],
                    ),
                  ),
                ),
                homeCubit.screens[homeCubit.currentIndex],
              ],
            );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: homeCubit.currentIndex,
          onTap: (index){
            homeCubit.changeBottomNav(index);
          },
          items: const [
          BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
          BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            navigateTo(context, AddPostScreen());
          },
          child: const Icon(IconBroken.Paper_Upload),
        ),

      ) ,

    );
  }
}
