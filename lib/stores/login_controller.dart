import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app_with_tgbot/pages/home_page.dart';

class LoginController extends GetxController{
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();

   GetStorage base = GetStorage();


  validate() {
   return name.text.trim().isEmpty || 
   phone.text.trim().isEmpty || 
   login.text.trim().isEmpty;
    
  }

  loginFunction()async{
   if(validate()){
    Get.snackbar("Error", "Enter the full info", backgroundColor: Colors.red, colorText: Colors.white);
    return;
   }
   Map user = {
    "name": name.text,
    "phone": name.text,
    "login": name.text,
    "password": name.text,
   };
  await GetStorage().write('user', user);
  var test = await base.read('user');
   

    Get.to(() =>const HomePage());
  }
}