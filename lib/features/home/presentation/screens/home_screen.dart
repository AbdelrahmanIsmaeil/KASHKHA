import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
              Align(
                  alignment: Alignment.center,
                  child:  Image.asset('assets/images/KashkhaStore.png', width: 98,),
                ),
                Row(
                  children: [
                    Text('Good morning, ', style: AppStyles.style13Regular.copyWith(color: AppColors.greyCLR),),
                    Text('Maya', style: AppStyles.style15Bold.copyWith(color: AppColors.redCLR),),
                  ],
                ),
                SizedBox(height: 9,),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textFieldFillColor,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffE8E8E8),
                        child: Icon(Icons.search, color: AppColors.greyCLR, fontWeight: FontWeight.w900, size: 30,)),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.redCLR,
                        child: Icon(Icons.tune, color: AppColors.whiteCLR, size: 30,)),
                    ),
                    hintText: 'Search accessories',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: AppColors.redCLR, width: 3),
                    ),
                  ),
                ),
                SizedBox(height: 9,),
                Row(
                  children: [
                    Text('Shop by category', style: AppStyles.style15Bold.copyWith(color: AppColors.blackCLR),),
                    Spacer(),
                    Text('See all', style: AppStyles.style13Regular.copyWith(color: AppColors.redCLR),),
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/True.png', width: 60,),
                          Text('Bags', style: AppStyles.style13Regular.copyWith(color: AppColors.blackCLR),),
                        ],
                      ),
                    );
                  }, itemCount: 10, shrinkWrap: true,),
                ),
                SizedBox(height: 9,),
                Row(
                  children: [
                    Text('Curated for you', style: AppStyles.style15Bold.copyWith(color: AppColors.blackCLR),),
                    Spacer(),
                    Text('See all', style: AppStyles.style13Regular.copyWith(color: AppColors.redCLR),),
                  ],
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/True.png', width: 60,),
                          Text('Bags', style: AppStyles.style13Regular.copyWith(color: AppColors.blackCLR),),
                        ],
                      ),
                    );
                  }, itemCount: 10, shrinkWrap: true,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}