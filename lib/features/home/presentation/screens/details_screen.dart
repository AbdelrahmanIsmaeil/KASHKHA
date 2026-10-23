import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';
import 'package:kashkha/features/home/widgets/size_button.dart';


class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.name, required this.price, required this.image, required this.description, required this.isFavorite, this.onPressed, required this.productId, required this.accessToken});
  final String name;
  final num price;
  final String image;
  final String description;
  final bool isFavorite;
  final void Function()? onPressed;
  final String productId;
final String accessToken;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 0;
  String? selectedSize;
  List<String> size = [
    'M', 'L', 'XL', 'XXL'
  ];

  Future<void> deleteProduct() async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete product'),
      content: const Text(
        'Are you sure you want to delete this product?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );

  if (confirm != true || !mounted) return;

  try {
    final dio = Dio();

    final response = await dio.delete(
      'https://accessories-eshop.runasp.net/api/products/${widget.productId}',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
        },
      ),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 204) {
      if (!mounted) return;

      Navigator.pop(context, true);
    } else {
      throw Exception('Unexpected status: ${response.statusCode}');
    }
  } on DioException catch (e) {
    debugPrint('Delete status: ${e.response?.statusCode}');
    debugPrint('Delete error: ${e.response?.data}');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Delete failed: ${e.response?.statusCode ?? e.message}',
        ),
      ),
    );
  } catch (e) {
    debugPrint('Delete error: $e');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong while deleting the product'),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.whiteCLR,
      title: Text('Product details', style: AppStyles.style16ExtraBold,),
      actions: [
        IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        onPressed: widget.onPressed,
        icon: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
          size: 20,
        ),
      ),
      ],
      centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(widget.image, width: double.infinity, height: 300, fit: BoxFit.cover,)),
                  SizedBox(height: 24,),
                Row(
                  children: [
                    Text('Kashkha SIGNATURE', style: AppStyles.style12Bold.copyWith(color: AppColors.redCLR),),
                    Spacer(),
                    Text('. 5 IN STOCK', style: AppStyles.style10Regular.copyWith(color: AppColors.greyCLR),),
                  ],
                ),
                Text(widget.name, style: AppStyles.style25Bold.copyWith(color: AppColors.blackCLR),),
                Row(
                  children: [
                    Text('EGP ${widget.price.toStringAsFixed(0)}', style: AppStyles.style25Bold.copyWith(color: AppColors.redCLR),),
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
                Text(widget.description, style: AppStyles.style14Bold.copyWith(color: AppColors.greyCLR),),
                SizedBox(height: 20,),
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
                    itemCount: size.length,
                    itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                      children: [
                        SizeButton(size: size[index], onPressed: (){
                          setState(() {
                            selectedSize = size[index];
                          });
                        }, isSelected: selectedSize == size[index],),
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
                onTap: deleteProduct,
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
      ),
    );
  }
}