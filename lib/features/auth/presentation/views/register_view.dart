import 'package:depi_graduation_project/features/auth/presentation/views/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/assets.dart';
import '../../helper/validator.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width:double.infinity,
                    height: 250,
                    child: Column(
                      children: [
                        const SizedBox(height: 110,),
                        SvgPicture.asset(Assets.imagesAppIcon,width: 50,height: 60,),
                        const SizedBox(height: 10,),
                        const Text('Create an Account!',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  Form(
                      key: controller.formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('UserName',style: TextStyle(color: Colors.black87,fontSize: 17),),
                            Validator.buildUserNameField(controller.nameController, 'Enter your username'),
                            const SizedBox(height: 20,),
                            const Text('Email',style: TextStyle(color: Colors.black87,fontSize: 17),),
                            Validator.buildGmailField(controller.gmailController,'Enter your email'),
                            const SizedBox(height: 20,),
                            const Text('Password',style: TextStyle(color: Colors.black87,fontSize: 17),),
                            Validator.buildPasswordField(controller.passwordController,'Enter your password',controller.see),
                            const SizedBox(height: 30,),
                            Center(
                              child: SizedBox(
                                height: 48,
                                width: 450,
                                child: ElevatedButton(onPressed: (){
                                  if(controller.formKey.currentState!.validate()){
                                    // code Auth
                                  }
                                },style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: Colors.deepOrangeAccent
                                ), child: const Text('Register',style: TextStyle(fontSize: 20,color: Colors.white),),),
                              ),
                            ),const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account?',style: TextStyle(fontSize: 16),),
                                TextButton(onPressed: (){
                                  Get.offNamed('/login');
                                }, child: const Text('Login',style: TextStyle(fontSize: 16,color: Colors.deepOrangeAccent)))
                              ],
                            )
                          ],
                        ),
                      )
                  )
            
                ]
            ),
          )
      ),
    );
  }
}

