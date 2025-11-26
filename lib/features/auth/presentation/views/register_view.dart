import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/auth/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
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
                width: double.infinity,
                height: 250.h,
                child: Column(
                  children: [
                    const Gap(110),
                    SvgPicture.asset(
                      Assets.imagesAppIcon,
                      width: 50,
                      height: 60,
                    ),
                    const Gap(10),
                    Text(
                      'Create an Account!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
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
                      Text(
                        'UserName',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.sp,
                        ),
                      ),
                      Validator.buildUserNameField(
                        controller.nameController,
                        'Enter your username',
                      ),
                      const Gap(20),
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.sp,
                        ),
                      ),
                      Validator.buildGmailField(
                        controller.gmailController,
                        'Enter your email',
                      ),
                      const Gap(20),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.sp,
                        ),
                      ),
                      Validator.buildPasswordField(
                        controller.passwordController,
                        'Enter your password',
                        controller.see,
                      ),
                      const Gap(30),
                      Center(
                        child: SizedBox(
                          height: 48,
                          width: 450,
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                // code Auth
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppColors.main,
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: AppTextStyle.regular16,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offNamed('/login');
                            },
                            child:  Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.main,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
