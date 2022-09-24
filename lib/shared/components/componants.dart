import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateToAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => screen), (route) {
    return false;
  });
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required String label,
  String? Function(String?)? validator,
  required IconData prefix,
  required TextInputType inputType,
  bool isPassword = false,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  IconData? suffix,
  VoidCallback? onPressed,
  VoidCallback? onTap,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: isPassword,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: Icon(suffix),
      ),
      border: const OutlineInputBorder(),
    ),
  );
}

Widget defaultButton({required String text, required VoidCallback onPressed}) =>
    Container(
        height: 40.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: defaultColor, borderRadius: BorderRadius.circular(10.0)),
        child: MaterialButton(
          onPressed: onPressed,
          height: 30.0,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ));

void showToast(String msg,ToastStates state){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates{SUCCESS,ERROR,WARNING}

Color toastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
}) => TextButton(onPressed: onPressed, child: Text(text));