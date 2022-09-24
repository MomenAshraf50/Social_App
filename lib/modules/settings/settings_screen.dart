import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_cubit.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_states.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/componants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        UserDataModel? userDataModel = HomeCubit.get(context).userDataModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration:   BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${userDataModel!.coverImage}'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      CircleAvatar(
                        radius: 62,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child:  CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('${userDataModel.image}'),
                        ),
                      )
                    ]
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                  '${userDataModel.name}',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${userDataModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '32',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10K',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '260',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child:OutlinedButton(child: const Text('Add Photos'),onPressed: (){},)),
                  const SizedBox(width: 10,),
                  OutlinedButton(onPressed: (){
                    navigateTo(context, EditProfileScreen());
                  }, child: const Icon(IconBroken.Edit)),
                ],
              )

            ],
          ),
        );
      },);
  }
}
