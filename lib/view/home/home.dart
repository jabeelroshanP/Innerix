import 'package:flutter/material.dart';
import 'package:innerix/controller/carousel_provider.dart';
import 'package:innerix/controller/categories_provider.dart';
import 'package:innerix/widgets/list_view_wdgt.dart';
import 'package:innerix/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchCtrl = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: RefreshIndicator(
        onRefresh: () async => fetchData(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Consumer2<CategoriesProvider, CarouselProvider>(
                builder: (context, categoryValue, carouselValue, child) {
                  final isLoading =
                      categoryValue.isLoading || carouselValue.isLoading;

                  if (isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (categoryValue.categoryList.isEmpty &&
                      carouselValue.listModel.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        children: [
                          Expanded(
                            child: textWdgt(
                              "Hi, Jabeel",
                              screenWidth * 0.10,
                              FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite_border_outlined),
                            onPressed: () {},
                            tooltip: 'Favorites',
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.notifications_none_outlined),
                            onPressed: () {},
                            tooltip: 'Notifications',
                          ),
                        ],
                      ),
                      textWdgt(
                        "Let's start Shopping",
                        screenWidth * 0.05,
                        FontWeight.w400,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: searchCtrl,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search products...",
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CarouselSliderWdgt(
                            context,
                            screenHeight * 0.28,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      sectionTitle(
                        "Categories",
                        "See All",
                        screenHeight * 0.02,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      SizedBox(
                        height: screenHeight * 0.16,
                        child: categoryValue.categoryList.isEmpty
                            ? const Center(
                                child: Text('No categories available'),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: categoryValue.categoryList.length,
                                itemBuilder: (context, index) {
                                  final value =
                                      categoryValue.categoryList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              radius: screenWidth * 0.10,
                                              backgroundColor: Colors.white,
                                              backgroundImage:
                                                  value.categoryImage != null
                                                  ? NetworkImage(
                                                      value.categoryImage!,
                                                    )
                                                  : const NetworkImage(
                                                      "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=",
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: screenWidth * 0.20,
                                            child: Text(
                                              value.categoryName ?? "Unknown",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.018,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      sectionTitle(
                        "Top Selling",
                        "View All",
                        screenHeight * 0.02,
                      ),

                      SizedBox(height: screenHeight * 0.02),
                      topSellingWdgt(screenHeight, screenWidth),

                      SizedBox(height: screenHeight * 0.04),
                      sectionTitle(
                        "Best Offers",
                        "View All",
                        screenHeight * 0.02,
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      bestOffersWdgt(screenHeight, screenWidth),

                      SizedBox(height: screenHeight * 0.05),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
