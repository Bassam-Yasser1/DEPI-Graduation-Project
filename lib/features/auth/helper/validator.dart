import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Validator {

  static Widget buildUserNameField(TextEditingController controller, String mass) {
    return TextFormField(
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return '$mass cannot be empty' ;
        }
        return null;
      },
      style: const TextStyle(color: Colors.deepOrangeAccent),
      controller: controller,
      decoration: InputDecoration(
        hintText: mass,
        hintStyle:const TextStyle(color: Colors.deepOrangeAccent) ,
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(color:Colors.deepOrangeAccent,
                width: 2.5)
        ),
      ),
    );
  }


  static Widget buildPasswordField(TextEditingController controller, String mass,RxBool see) {

    return Obx(() {
      return TextFormField(

        validator: (value){
          if(value==null||value.trim().isEmpty){
            return '$mass cannot be empty';
          }if(value.length<8){
            return 'Password must be at least 8 characters';
          }if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
            return 'Password must contain at least one uppercase letter';
          }
          if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
            return 'Password must contain at least one number';
          }
          return null;
        },
        style:const TextStyle(color: Colors.deepOrangeAccent),
        obscureText: see.value,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: () {
            see.toggle();
          },
              icon: see.value ? const Icon(Icons.visibility,color: Colors.deepOrangeAccent,) :const Icon(
                  Icons.visibility_off,color: Colors.deepOrangeAccent)),
          hintText: mass,
          hintStyle:const TextStyle(color: Colors.deepOrangeAccent) ,
          fillColor: Colors.grey.shade200,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:const BorderSide(color: Colors.deepOrangeAccent,
                  width: 2.5)
          ),
        ),
      );
    });
  }


  static Widget buildGmailField(TextEditingController controller, String mass ) {
    return TextFormField(
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return '$mass cannot be empty' ;
        }
        if(!GetUtils.isEmail(value.trim())){
          return 'Enter a valid email';
        }
        return null;
      },
      style:const TextStyle(color: Colors.deepOrangeAccent),
      controller: controller,
      decoration: InputDecoration(
        hintText: mass,
        hintStyle:const TextStyle(color: Colors.deepOrangeAccent) ,
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(color: Colors.grey,
                width: 2.5)
        ),
      ),
    );
  }

}