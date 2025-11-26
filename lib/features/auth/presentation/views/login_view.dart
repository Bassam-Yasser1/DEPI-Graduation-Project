import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
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
                width: double.infinity,
                height: 250,
                child: Column(
                  children: [
                    const Gap(110),
                    SvgPicture.asset(
                      Assets.imagesAppIcon,
                      width: 50.w,
                      height: 60.h,
                    ),
                    const Gap(10),
                    Text(
                      'Welcome Back!',
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
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: AppColors.main,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                              'Login',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      SizedBox(
                        height: 48,
                        width: 450,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.offNamed('/register');
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(
                              color: AppColors.main,
                              width: 2.5,
                            ),
                            foregroundColor: AppColors.main,
                          ),
                          child: Text(
                            'Register',
                            style: AppTextStyle.regular20,
                          ),
                        ),
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
