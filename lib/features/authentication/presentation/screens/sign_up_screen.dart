import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';
import 'package:kashkha/features/authentication/presentation/screens/login_screen.dart';
import 'package:kashkha/features/authentication/presentation/screens/verify_email.dart';
import 'package:kashkha/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:kashkha/features/authentication/presentation/widgets/password_text_field.dart';
import 'package:kashkha/features/authentication/presentation/widgets/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVisible = false;
  bool agreed = false;
  final GlobalKey<FormState> mykey = GlobalKey<FormState>();
  final TextEditingController firstNameCtl = TextEditingController();
  final TextEditingController lastNameCtl = TextEditingController();
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  final TextEditingController confirmPasswordCtl = TextEditingController();

  @override
  void dispose() {
    firstNameCtl.dispose();
    lastNameCtl.dispose();
    emailCtl.dispose();
    passwordCtl.dispose();
    confirmPasswordCtl.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    final Dio dio =Dio();
    try {
      final Response response = await dio.post("https://accessories-eshop.runasp.net/api/auth/register",
      data : {
          "email": emailCtl.text,
          "password": passwordCtl.text,
          "firstName": firstNameCtl.text,
          "lastName": lastNameCtl.text
        }
      );
    log("response $response");
    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmail(email: emailCtl.text.trim())),
    );
    } on DioException catch (e) {
      log("Error : ${e.response!.data['errors']}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: mykey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/Frame.png', width: double.infinity, fit: BoxFit.contain,),
                  Positioned(
                    top: 110,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create your account', style: AppStyles.style40ExtraBold.copyWith(color: AppColors.whiteCLR),),
                      Text('   Set up your profile in less than a minute.', style: AppStyles.style10Regular.copyWith(color: AppColors.pinkWhiteCLR),),
                    ],
                  )
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: firstNameCtl,
                            title: 'First Name',
                            hintText: 'First name',
                            prefixIcon: Icons.person,
                            validator: (firstName) {
                              return Validator.validateName(firstName ?? '');
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            controller: lastNameCtl,
                            title: 'Last Name',
                            hintText: 'Last name',
                            prefixIcon: Icons.person,
                            validator: (lastName) {
                              return Validator.validateName(lastName ?? '');
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      controller: emailCtl,
                      title: 'Email Address',
                      hintText: 'Enter your email address',
                      prefixIcon: Icons.email,
                      validator: (email) {
                        return Validator.validateEmail(email ?? '');
                      },
                    ),
                    PasswordTextField(
                      controller: passwordCtl,
                      title: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: true,
                      validator: (password) {
                        return Validator.validatePassword(password ?? '');
                      },
                    ),
                    PasswordTextField(
                      controller: confirmPasswordCtl,
                      title: 'Confirm Password',
                      hintText: 'Confirm your password',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: true,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (password != passwordCtl.text) {
                          return 'Passwords do not match';
                        }
                        return Validator.validatePassword(password);
                      },
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: agreed,
                                onChanged: (value) {
                                  setState(() {
                                    agreed = value ?? false;
                                  });
                                },
                                activeColor: AppColors.redCLR,
                              ),
                              Text(
                                'I agree to the Terms and Privacy Policy',
                                style: AppStyles.style13Bold.copyWith(
                                  color: AppColors.greyCLR,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          if (mykey.currentState!.validate()) {
                            signUp();
                        }
                        }, 
                        style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.whiteCLR,
                        backgroundColor: AppColors.redCLR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        ),
                        child: Text('Create account'),
                      ),
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                      Expanded(child: Divider(color: AppColors.greyCLR,)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('or continue with', style: AppStyles.style13Bold.copyWith(color: AppColors.greyCLR),),
                      ), 
                      Expanded(child: Divider(color: AppColors.greyCLR,)), 
                    ],),
                    SizedBox(height: 2,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){}, 
                        style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteGreyCLR,
                        foregroundColor: AppColors.blackCLR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        ),
                        child: Text('Continue with Google', style: AppStyles.style13Bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already registered? ', style: AppStyles.style11ExtraBold.copyWith(color: AppColors.greyCLR),),
                        TextButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                          }, 
                          child: Text('Sign In', style: AppStyles.style13Bold.copyWith(color: AppColors.redCLR),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}