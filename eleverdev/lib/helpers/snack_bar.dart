import 'package:eleverdev/mangers/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ShowSnackBar{
  static showError({required String errorMessage}){
        Get.showSnackbar(GetSnackBar(
            messageText: Text(errorMessage,style:const TextStyle(
              fontWeight: FontWeight.w900,
              color: ColorManger.snackBarErrorText,
              fontSize: 20
            ),),
            backgroundColor: ColorManger.snackBarErrorBgColor,
            snackStyle: SnackStyle.GROUNDED,
            duration:const Duration(seconds: 2),  
          ));
  }
}