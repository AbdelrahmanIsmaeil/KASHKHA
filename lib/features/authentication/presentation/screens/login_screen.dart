import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';
import 'package:kashkha/features/authentication/presentation/screens/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  Text('Email Address', style: AppStyles.style12Bold),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.whiteGreyCLR,
                        prefixIcon: Icon(Icons.email, color: AppColors.greyCLR,),
                        hintText: 'Enter your email address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppColors.redCLR, width: 3),
                        ),
                      ),
                    ),
                  ),
                  Text('Password', style: AppStyles.style12Bold),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.whiteGreyCLR,
                        prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.greyCLR,),
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppColors.redCLR, width: 3),
                        ),
                      ),
                    ),
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
                      onPressed: (){}, 
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
                        onPressed: (){}, 
                        child: TextButton(
                          child: Text('Create account', style: AppStyles.style13Bold.copyWith(color: AppColors.redCLR),),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpScreen()),
                            );
                          },
                      ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}