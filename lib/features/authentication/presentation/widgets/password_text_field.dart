
import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.obscureText = false,
    required this.prefixIcon,required this.validator,
  });

  final String title;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppStyles.style12Bold),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            validator: widget.validator,
            obscureText: isVisible,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textFieldFillColor,
              prefixIcon: Icon(
                widget.prefixIcon,
                color: AppColors.greyCLR,
              ),
              hintText: widget.hintText,
              suffixIcon: IconButton(onPressed: (){
                isVisible = !isVisible;
                setState(() {
                  
                });
              }, icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(
                  color: AppColors.redCLR,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}