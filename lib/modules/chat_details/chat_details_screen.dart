import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_cubit.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserDataModel userModel;
  ChatDetailsScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    TextEditingController messageController = TextEditingController();
    return Builder(
      builder: (context) {
        HomeCubit.get(context).getMessages(receiverId: userModel.uid.toString());
        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state) {},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                elevation: 5,
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel.image}'),

                    ),
                    const SizedBox(width: 10,),
                    Text('${userModel.name}')
                  ],
                ),
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context,index){
                            MessageModel messageModel = HomeCubit.get(context).messages[index];
                          if(HomeCubit.get(context).userDataModel!.uid == messageModel.senderId){
                            return buildSenderMessage(messageModel);
                          }
                          return buildReceiverMessage(messageModel);
                        },
                          separatorBuilder:(context,index) =>const SizedBox(height: 5,),
                          itemCount: HomeCubit.get(context).messages.length,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      if(state is MessageImageUploadLoadingState)
                      const LinearProgressIndicator(),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: defaultColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              HomeCubit.get(context).sendMessageImage(receiverId: userModel.uid,dateTime: DateTime.now().toString());
                            }, icon: const Icon(IconBroken.Camera),),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'You can\'t send an empty message';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here...'
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    HomeCubit.get(context).sendMessage(
                                      receiverId: userModel.uid.toString(),
                                      dateTime: DateTime.now().toString(),
                                      message: messageController.text,);
                                    messageController.text = '';
                                  }
                                },
                                minWidth: 1.0,
                                child: const Icon(IconBroken.Send,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              )
            );
          },
        );
      }
    );
  }

  Widget buildReceiverMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: ConditionalBuilder(
      condition: model.message!= null,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            )
        ),
        child: Text('${model.message}'),
      ),
      fallback: (context) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            )
        ),
        child: Image(
          height: 300,
          image: NetworkImage('${model.messageImage}'),
        ),
      ),
    )
  );

  Widget buildSenderMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: ConditionalBuilder(
      condition: model.message != null,
      builder: (context) => Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
            )
        ),
        child: Text('${model.message}'),
      ),
      fallback: (context)=> Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
            )
        ),
        child: Image(
          height: 300,
          image: NetworkImage('${model.messageImage}'),
        ),
      ),
    )
  );


}
