// Text

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innerix/controller/best_offers_provider.dart';
import 'package:innerix/controller/carousel_provider.dart';
import 'package:innerix/controller/categories_provider.dart';
import 'package:innerix/controller/top_sellingProvider.dart';
import 'package:provider/provider.dart';

Widget textWdgt(txt, txtSize, txtWidth, [clr]) {
  return Text(
    txt,
    style: TextStyle(fontSize: txtSize, fontWeight: txtWidth, color: clr),
  );
}

// text form field
Widget customTextFormField(
  BuildContext context,
  TextEditingController ctrl,
  String hint, [
  Widget? suff,
  String? Function(String?)? validate,
]) {
  return TextFormField(
    controller: ctrl,
    validator: validate,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      hintText: hint,
      suffixIcon: suff,
      contentPadding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.025,
        horizontal: MediaQuery.of(context).size.width * 0.03,
      ),
    ),
  );
}

// Container

Widget containerWdgt(ht, img, txt, txtSizw, textWeight, [clr]) {
  return Container(
    width: double.infinity,
    height: ht,
    decoration: BoxDecoration(
      color: clr,
      border: Border.all(width: 0.7),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(img, height: 40),
        SizedBox(width: 10),
        Center(
          child: Text(
            txt,
            style: TextStyle(fontSize: txtSizw, fontWeight: textWeight),
          ),
        ),
      ],
    ),
  );
}

// icon container

Widget containerFavANdLike(BuildContext context, icn) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.06,
    width: MediaQuery.of(context).size.width * 0.10,
    decoration: BoxDecoration(
      color: Color(0xFFFFF9C2),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Icon(icn),
  );
}

// Carousel Slider

Widget CarouselSliderWdgt(BuildContext context, double height) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  final provider = Provider.of<CarouselProvider>(context);

  if (provider.isLoading) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 252, 236, 92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  if (provider.listModel.isEmpty) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 252, 236, 92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(child: Text("No offers available")),
    );
  }

  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 252, 236, 92),
      borderRadius: BorderRadius.circular(20),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CarouselSlider.builder(
        itemCount: provider.listModel.length,
        options: CarouselOptions(
          height: height,
          autoPlay: true,
          viewportFraction: 1,
        ),
        itemBuilder: (context, index, realIdx) {
          final offer = provider.listModel[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Image.network(
                    offer.image,
                    width: screenWidth * 0.3,
                    height: height * 0.8,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(Icons.photo, size: 100),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        offer.name,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.09,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        offer.description,
                        style: GoogleFonts.openSans(
                          fontSize: screenHeight * 0.04,
                          color: Colors.brown,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

// initState FUtur micro task

void fetchData(BuildContext context) {
  Future.microtask(() {
    final read = context.read;
    read<CategoriesProvider>().getCategories();
    read<CarouselProvider>().getCarousel();
    read<TopSellingProvider>().fetchTopSelling();
    read<BestOfferProvider>().fetchBestOffers();
  });
}

// Section title like categories

Widget sectionTitle(String title, String action, double fontSize) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      textWdgt(title, fontSize, FontWeight.w600),
      textWdgt(action, fontSize, FontWeight.w400),
    ],
  );
}

// bullet point

Widget buildDot(bool isActive) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    height: 8,
    width: 8,
    decoration: BoxDecoration(
      color: isActive ? Colors.black : Colors.grey[300],
      shape: BoxShape.circle,
    ),
  );
}
