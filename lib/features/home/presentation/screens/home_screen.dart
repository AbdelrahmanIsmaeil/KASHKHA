import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
import 'package:kashkha/core/theme/app_styles.dart';
import 'package:kashkha/features/home/presentation/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.accessToken, required this.refreshToken});
    final String accessToken;
  final String refreshToken;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    late String accessToken;
  late String refreshToken;
  List categories = [];
  List products = [];
  List favorites = [];
  void toggleFavorite(dynamic id) {
  setState(() {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
  });
}
Future<bool> refreshAccessToken() async {
  final dio = Dio();

  try {
    final response = await dio.post(
      'https://accessories-eshop.runasp.net/api/auth/refresh-token',
      data: {
        'refreshToken': refreshToken,
        'useCookies': false,
      },
    );

    log('Refresh response: ${response.data}');

    final data = response.data;

    if (data['accessToken'] == null) {
      return false;
    }

    accessToken = data['accessToken'];

    if (data['refreshToken'] != null) {
      refreshToken = data['refreshToken'];
    }

    return true;
  } on DioException catch (e) {
    log('Refresh error: ${e.response?.data}');
    return false;
  }
}
  Future<void> getCategories({bool retry = true}) async {
  final dio = Dio();

  try {
    final response = await dio.get(
      'https://accessories-eshop.runasp.net/api/categories',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    log('Categories response: ${response.data}');

    final data = response.data;

    if (!mounted) return;

    setState(() {
      categories = data['categories'] ?? [];
    });
  } on DioException catch (e) {
    if (e.response?.statusCode == 401 && retry) {
      final refreshed = await refreshAccessToken();

      if (refreshed) {
        await getCategories(retry: false);
        return;
      }
    }

    log('Categories status: ${e.response?.statusCode}');
    log('Categories error: ${e.response?.data}');
  }
}

  Future<void> getProducts({bool retry = true}) async {
  final Dio dio = Dio();

  try {
    final Response response = await dio.get(
      'https://accessories-eshop.runasp.net/api/products',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (!mounted) return;

    setState(() {
      products = response.data['items'] ?? [];
    });

    log('Products loaded: ${products.length}');
  } on DioException catch (e) {
    if (e.response?.statusCode == 401 && retry) {
      final refreshed = await refreshAccessToken();

      if (refreshed) {
        await getProducts(retry: false);
        return;
      }
    }

    log('Products status: ${e.response?.statusCode}');
    log('Products error: ${e.response?.data}');
  }
}
  @override
  void initState() {
    super.initState();
        accessToken = widget.accessToken;
  refreshToken = widget.refreshToken;
    getCategories();
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text('Find your new favorite items', style: AppStyles.style20Bold.copyWith(color: AppColors.blackCLR),),
                SizedBox(height: 9,),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.textFieldFillColor,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffE8E8E8),
                        child: Icon(Icons.search, color: AppColors.greyCLR, fontWeight: FontWeight.w900, size: 18,)),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.redCLR,
                        child: Icon(Icons.tune, color: AppColors.whiteCLR, size: 21,)),
                    ),
                    hintText: 'Search accessories',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: AppColors.redCLR, width: 3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: AppColors.textFieldFillColor, width: 3),
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
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, right: 16.0),
                      child: Column(
                        children: [
                        ClipOval(
                          child: Image.network(
                            categories[index]['coverPictureUrl'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                color: AppColors.textFieldFillColor,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.greyCLR,
                                ),
                              );
                            },
                          ),
                        ),
                          Text(categories[index]['name'], style: AppStyles.style13Regular.copyWith(color: AppColors.blackCLR),),
                        ],
                      ),
                    );
                  }, shrinkWrap: true,),
                ),
                SizedBox(height: 9,),
                Row(
                  children: [
                    Text('Curated for you', style: AppStyles.style15Bold.copyWith(color: AppColors.blackCLR),),
                    Spacer(),
                    Text('See all', style: AppStyles.style13Regular.copyWith(color: AppColors.redCLR),),
                  ],
                ),
                SizedBox(height: 9,),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio:  0.70,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
  final deleted = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (context) => DetailsScreen(
        productId: products[index]['id'].toString(),
        accessToken: accessToken,
        name: products[index]['name'],
        price: products[index]['price'],
        description: products[index]['description'],
        image: products[index]['coverPictureUrl'],
        isFavorite: favorites.contains(products[index]['id']),
        onPressed: () {
          toggleFavorite(products[index]['id']);
        },
      ),
    ),
  );

  if (deleted == true) {
    await getProducts();
  }
},
                      child: Card(
                        color: AppColors.whiteCLR,
                        child: Column(
                          children: [
                          Expanded(
                            flex: 6,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    products[index]['coverPictureUrl'],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 9,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      onPressed: () {
                                        setState(() {
                                          final id = products[index]['id'];
                                          favorites.contains(id) ? favorites.remove(id) : favorites.add(id);
                                        });
                                      },
                                      icon: Icon(
                                        favorites.contains(products[index]['id']) ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(products[index]['name'], style: AppStyles.style12Bold.copyWith(color: AppColors.blackCLR),),
                                            Text(products[index]['color'], style: AppStyles.style10Regular.copyWith(color: AppColors.greyCLR),),
                                            Text('EGP ${(products[index]['price'] as num).toStringAsFixed(0)}', style: AppStyles.style13ExtraBold.copyWith(color: AppColors.redCLR),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.redCLR,
                                        child: Icon(Icons.arrow_forward, color: AppColors.whiteCLR, size: 20, fontWeight: FontWeight.w900,)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }, itemCount: products.length, shrinkWrap: true, ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}