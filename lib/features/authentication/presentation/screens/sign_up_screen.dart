import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';
import 'package:kashkha/features/authentication/presentation/screens/login_screen.dart';
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
  final GlobalKey<FormState> mykey = GlobalKey<FormState>();
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
                    top: 56,
                    left: 26,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,color: AppColors.blackCLR, size: 20,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: 106,
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
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
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
                      title: 'Email Address',
                      hintText: 'Enter your email address',
                      prefixIcon: Icons.email,
                      validator: (email) {
                        return Validator.validateEmail(email ?? '');
                      },
                    ),
                    PasswordTextField(
                      title: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: true,
                      validator: (password) {
                        return Validator.validatePassword(password ?? '');
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
                    SizedBox(height: 15,),
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