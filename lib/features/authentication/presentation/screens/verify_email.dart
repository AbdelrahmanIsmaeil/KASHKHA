import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart' show AppStyles;
import 'package:kashkha/features/authentication/presentation/screens/sign_up_screen.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteCLR,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.blackCLR, size: 20,),
          onPressed: () {
            Navigator.pop(context);
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
              Text('maya@example.com', style: AppStyles.style13Bold.copyWith(color: AppColors.blackCLR),),
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
                          OTPTextField(),
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
                  onPressed: (){}, 
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

class OTPTextField extends StatelessWidget {
  const OTPTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 65,
      child: Card(
        elevation: 5,
        color: AppColors.whiteGreyCLR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          cursorColor: AppColors.redCLR,
          style: AppStyles.style16ExtraBold.copyWith(color: AppColors.blackCLR),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.greyCLR,),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.redCLR, width: 3),
            ),
          ),
        ),
      ),
    );
  }
}