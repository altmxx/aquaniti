import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenCarousel extends StatefulWidget {
  const HomeScreenCarousel({super.key});

  @override
  State<HomeScreenCarousel> createState() => _HomeScreenCarouselState();
}

class _HomeScreenCarouselState extends State<HomeScreenCarousel> {
  int _current = 0;
  final _carouselController = CarouselController();

  static const List<String> imageList = [
    // "assets/images/marketplace_carousel/carousel_marketplace_1.png",
    "assets/images/news/news_1.png",
    "assets/images/news/news_2.png",
    "assets/images/news/news_3.png",
    "assets/images/news/news_4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _carouselController,
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.map((entry) {
            int index = imageList.indexOf(entry);
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(index),
              child: Container(
                width: 10.w,
                height: 10.w,
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                      : const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  final List<Widget> imageSliders = imageList
      .map((e) => ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 316.w,
              height: 181.h,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(e), fit: BoxFit.cover)),
            ),
          ))
      .toList();
}
