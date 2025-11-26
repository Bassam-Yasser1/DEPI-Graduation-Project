import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{


  final nameController = TextEditingController();

  final passwordController = TextEditingController();

  final see = true.obs;

  final formKey = GlobalKey<FormState>();

}