import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';
import 'package:kashkha/features/authentication/presentation/screens/login_screen.dart';
import 'package:kashkha/features/authentication/presentation/widgets/otp_text_field.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key, required this.email});
  final String email;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<FocusNode> focusNodes = [
  FocusNode(),
  FocusNode(),
  FocusNode(),
  FocusNode(),
  FocusNode(),
  FocusNode(),
];
  @override
void dispose() {
  controllers[0].dispose();
  controllers[1].dispose();
  controllers[2].dispose();
  controllers[3].dispose();
  controllers[4].dispose();
  controllers[5].dispose();
  focusNodes[0].dispose();
  focusNodes[1].dispose();
  focusNodes[2].dispose();
  focusNodes[3].dispose();
  focusNodes[4].dispose();
  focusNodes[5].dispose();
  super.dispose();
}
  void onOtpChanged(String value, int index) {
  if (value.isNotEmpty && index < 5) {
    focusNodes[index + 1].requestFocus();
  }
  if (value.isEmpty && index > 0) {
    focusNodes[index - 1].requestFocus();
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteCLR,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.blackCLR, size: 20,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        
      ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/verifyEmail.png',),
                  Positioned(
                    right: 12,
                    bottom: 8,
                    child: Image.asset('assets/images/True.png',),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text('Verify your email', style: AppStyles.style25Bold. copyWith(color: AppColors.redCLR),),
              Text('We sent a 6-digit code to', style: AppStyles.style13Regular.copyWith(color: AppColors.greyCLR),),
              Text(widget.email, style: AppStyles.style13Bold.copyWith(color: AppColors.blackCLR),),
              SizedBox(height: 20,),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OTPTextField(controller: controllers[index], focusNode: focusNodes[index],
                            onChanged: (value) {
                              onOtpChanged(value, index);
                          },),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    String code = controllers[0].text +
                        controllers[1].text +
                        controllers[2].text +
                        controllers[3].text +
                        controllers[4].text +
                        controllers[5].text;
                    log('Code: $code');
                  }, 
                  style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redCLR,
                  foregroundColor: AppColors.blackCLR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  ),
                  child: Text('Verify email', style: AppStyles.style14Bold.copyWith(color: AppColors.whiteCLR),),
                ),
              ),
              SizedBox(height: 20,),
              Text('Didn\'t receive the code?', style: AppStyles.style13Regular.copyWith(color: AppColors.greyCLR),),
              TextButton(
                onPressed: (){}, 
                child: Text('Resend code in 00:29', style: AppStyles.style13Bold.copyWith(color: AppColors.redCLR),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}