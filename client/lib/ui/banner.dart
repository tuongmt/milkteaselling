import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: BannerCarousel(
        banners: BannerImage.listBanners,
        customizedIndicators: const IndicatorModel.animation(
            width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
        activeColor: Colors.amber,
        disableColor: Colors.white,
        animation: true,
        borderRadius: 10,
        indicatorBottom: false,
      ),
    );
  }
}

class BannerImage {
  static const String banner1 = "assets/images/banner/banner_1.jpg";
  static const String banner2 = "assets/images/banner/banner_2.jpg";
  static const String banner3 = "assets/images/banner/banner_3.jpg";
  static const String banner4 = "assets/images/banner/banner_4.jpg";

  static List<BannerModel> listBanners = [
    BannerModel(imagePath: banner1, id: "1"),
    BannerModel(imagePath: banner2, id: "2"),
    BannerModel(imagePath: banner3, id: "3"),
    BannerModel(imagePath: banner4, id: "4"),
  ];
}
