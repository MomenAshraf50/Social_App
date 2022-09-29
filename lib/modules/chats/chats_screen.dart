import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_cubit.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_states.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/shared/components/componants.dart';

import '../chat_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state) {},
      builder: (context,state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).users.isNotEmpty,
          builder: (context) => Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index) => chatItemBuilder(context,HomeCubit.get(context).users[index]),
              separatorBuilder:(context,index)=> Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(height: 1,width: double.infinity,color: Colors.black38,),
              ),
              itemCount: HomeCubit.get(context).users.length,),
          ),
          fallback:(context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget chatItemBuilder(BuildContext context,UserDataModel model) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children:  [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style:  const TextStyle(height: 1.4),
          ),
        ],
      ),
    ),
  );
}

