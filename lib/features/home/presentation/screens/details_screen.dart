import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';
import 'package:kashkha/features/home/widgets/size_button.dart';


class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.whiteCLR,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/KashkhaStore.png', width: double.infinity,),
              Row(
                children: [
                  Text('SORRA SIGNATURE', style: AppStyles.style12Bold.copyWith(color: AppColors.redCLR),),
                  Spacer(),
                  Text('. 5 IN STOCK', style: AppStyles.style10Regular.copyWith(color: AppColors.greyCLR),),
                ],
              ),
              Text('Luxury Necklace', style: AppStyles.style40ExtraBold.copyWith(color: AppColors.blackCLR),),
              Row(
                children: [
                  Text('EGP 4,500', style: AppStyles.style25Bold.copyWith(color: AppColors.redCLR),),
                  Spacer(),
                  Row(
                    children: [
                    Icon(Icons.star_rate, color: AppColors.redCLR, size: 20,),
                    SizedBox(width: 5,),
                    Text('5.0 · 1 review', style: AppStyles.style11ExtraBold.copyWith(color: AppColors.greyCLR),),
                    ],
                  )
                ],
              ),
              SizedBox(height: 12,),
              Text('Gold plated necklace for special occasions', style: AppStyles.style14Bold.copyWith(color: AppColors.greyCLR),),
              SizedBox(height: 40,),
              Row(
                children: [
                  Text('Select size', style: AppStyles.style12Bold.copyWith(color: AppColors.blackCLR),),
                  Spacer(),
                  Text('Chain length', style: AppStyles.style10Regular.copyWith(color: AppColors.greyCLR),),
                ],
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection : Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                    children: [
                      SizeButton(size: "M", onPressed: (){}, isSelected: true),
                    ],
                  ),
                  );
                }
                ),
              ),
              
              Text('Quantity', style: AppStyles.style10Regular.copyWith(color: AppColors.greyCLR),),
              SizedBox(height: 8,),
              Row(
                children: [
                  Container(
                  width: 140,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEDEA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                        icon: const Icon(Icons.remove),
                        color: AppColors.greyCLR,
                        disabledColor: Colors.black26,
                      ),
                      SizedBox(
                        width: 24,
                        child: Text(
                          '$quantity',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(Icons.add),
                        color: AppColors.redCLR,
                      ),
                    ],
                  ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFFEFEDEA), width: 2),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.local_shipping_outlined, size: 28),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery estimate',
                                style: TextStyle(color: AppColors.greyCLR, fontSize: 11),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '2–4 business days',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24,),
              GestureDetector(
              onTap: (){},
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEDEA),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFF0C4BE), width: 2),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_rounded, color: AppColors.redCLR),
                    SizedBox(width: 10),
                    Text(
                      'Delete product',
                      style: TextStyle(
                        color: AppColors.redCLR,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ],
          ),
        )
      ),
    );
  }
}