import 'package:depi_graduation_project/features/auth/presentation/views/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/assets.dart';
import '../../helper/validator.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                    const Text('Welcome Back!',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
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
                          const Text('Password',style: TextStyle(color: Colors.black87,fontSize: 17),),
                          Validator.buildPasswordField(controller.passwordController,'Enter your password',controller.see),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed: (){
          
                              }, child: Text('Forget Password?',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 16),))
                            ],
                          ),
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
                              ), child: const Text('Login',style: TextStyle(fontSize: 20,color: Colors.white),),),
                            ),
                          ),SizedBox(height: 20,),
                          SizedBox(
                            height: 48,
                            width: 450,
                            child: OutlinedButton(onPressed: (){
                                Get.offNamed('/register');
                            }, style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),side: const BorderSide(
                              color: Colors.deepOrangeAccent,
                              width: 2.5,
                            ),
                              foregroundColor: Colors.deepOrangeAccent,
                            ),child: const Text('Register',style: TextStyle(fontSize: 20,),),),
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

