import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';
import 'package:kashkha/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:kashkha/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:kashkha/features/authentication/presentation/widgets/password_text_field.dart';
import 'package:kashkha/features/authentication/presentation/widgets/validators.dart';
import 'package:kashkha/features/home/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> myKey = GlobalKey<FormState>();
    final TextEditingController emailCtl = TextEditingController();
    final TextEditingController passwordCtl = TextEditingController();
  
  Future<void> login() async {
    final Dio dio =Dio();
    try {
      final Response response = await dio.post("https://accessories-eshop.runasp.net/api/auth/login",
      data : {
          "email": emailCtl.text,
          "password": passwordCtl.text,
        }
      );
    log("response $response");
    } on DioException catch (e) {
      log("Error : ${e.response!.data['errors']}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: myKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/Frame.png', width: double.infinity, fit: BoxFit.contain,),
                  Positioned(
                    top: 90,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome back', style: AppStyles.style40ExtraBold.copyWith(color: AppColors.whiteCLR),),
                      Text('  Sign in to discover pieces made to last', style: AppStyles.style10Regular.copyWith(color: AppColors.pinkWhiteCLR),),
                    ],
                  )
                  ),
                  Positioned(
                    top: 150,
                    right: 8,
                    child: Image.asset('assets/images/KashkhaStore.png', width: 140,),),
                ],
              ),
              SizedBox(height: 45,),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: emailCtl,
                      title: 'Email Address',
                      hintText: 'Enter your email address',
                      prefixIcon: Icons.email,
                      validator: (email) {
                        return Validator.validateEmail(email!);
                      },
                    ),
                    PasswordTextField(
                      controller: passwordCtl,
                      title: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock_outline_rounded,
                      validator: (password) {
                        return Validator.validatePassword(password!);
                      },
                    ),
                    SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                                activeColor: AppColors.redCLR,
                              ),
                              Text(
                                'Remember me',
                                style: AppStyles.style13Bold.copyWith(
                                  color: AppColors.greyCLR,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password ?',
                              style: AppStyles.style13Bold.copyWith(
                                color: AppColors.redCLR,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                            if (myKey.currentState!.validate()) {
                              login();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          } 
                        }, 
                        style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.whiteCLR,
                        backgroundColor: AppColors.redCLR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        ),
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                      Expanded(child: Divider(color: AppColors.greyCLR,)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('or continue with', style: AppStyles.style13Bold.copyWith(color: AppColors.greyCLR),),
                      ), 
                      Expanded(child: Divider(color: AppColors.greyCLR,)), 
                    ],),
                    SizedBox(height: 18,),
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
                    SizedBox(height: 60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New to Kashkha?', style: AppStyles.style11ExtraBold.copyWith(color: AppColors.greyCLR),),
                        TextButton(
                          child: Text('Create account', style: AppStyles.style13Bold.copyWith(color: AppColors.redCLR),),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpScreen()),
                            );
                          },
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