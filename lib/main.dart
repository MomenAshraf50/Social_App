import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout/home_cubit/home_cubit.dart';
import 'package:social_app/layout/home_layout/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uid = CacheHelper.getData(key: 'uid');
  Widget widget;

  if(uid!= null){
    widget = HomeLayout();
  }else{
    widget = LoginScreen();
  }


  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  MyApp(this.startScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        home:startScreen,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: defaultColor,
          appBarTheme:  AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: const TextStyle(color: Colors.black, fontSize: 24.0),
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              iconTheme: IconThemeData(color: defaultColor)),
          bottomNavigationBarTheme:  BottomNavigationBarThemeData(
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.black38,
              elevation: 30.0),
        ),
      ),
    );
  }
}

