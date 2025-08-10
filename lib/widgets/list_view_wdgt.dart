import 'package:flutter/material.dart';
import 'package:innerix/controller/best_offers_provider.dart';
import 'package:innerix/controller/top_sellingProvider.dart';
import 'package:innerix/view/view_products/view_products.dart';
import 'package:provider/provider.dart';

// Top Selling List Widget

SizedBox topSellingWdgt(double screenHeight, double screenWidth) {
  return SizedBox(
    height: screenHeight * 0.37,
    child: Consumer<TopSellingProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.topSellingList.isEmpty) {
          return const Center(child: Text("No products available"));
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.topSellingList.length,
          itemBuilder: (context, index) {
            final product = provider.topSellingList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        productId: product.productId ?? 0,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            product.thumbnailImage ??
                                "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=",
                            width: double.infinity,
                            height: screenHeight * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.name ?? '',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "₹${product.price?.toStringAsFixed(2) ?? '0.00'}",
                          style: TextStyle(
                            fontSize: screenHeight * 0.025,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Icon(Icons.more_vert)],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

// Best Offers List Widget

Consumer<BestOfferProvider> bestOffersWdgt(
  double screenHeight,
  double screenWidth,
) {
  return Consumer<BestOfferProvider>(
    builder: (context, provider, child) {
      if (provider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (provider.errorMessage != null) {
        return Center(child: Text(provider.errorMessage!));
      }
      if (provider.bestOffers.isEmpty) {
        return const Center(child: Text("No best offers available"));
      }

      return SizedBox(
        height: screenHeight * 0.37,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.bestOffers.length,
          itemBuilder: (context, index) {
            final offer = provider.bestOffers[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(productId: offer.productId ?? 0),
                  ),
                ),
                child: Container(
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.network(
                            offer.thumbnailImage ??
                                "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=",
                            height: screenHeight * 0.2,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          offer.name ?? '',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "₹${offer.price?.toStringAsFixed(2) ?? '0.00'}",
                          style: TextStyle(
                            fontSize: screenHeight * 0.025,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
