import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';

class OTPTextField extends StatelessWidget {
  const OTPTextField({super.key, required this.controller, required this.focusNode, required this.onChanged});
    final TextEditingController controller;
    final FocusNode focusNode;
    final Function(String)? onChanged;

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
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
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