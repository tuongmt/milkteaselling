import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/config/style.dart';
import 'package:flutter_coffee_app/data/productData.dart';
import 'package:flutter_coffee_app/models/offer_model.dart';
import 'package:gap/gap.dart';

class HomeOffers extends StatefulWidget {
  const HomeOffers({super.key});
  @override
  State<HomeOffers> createState() => _HomeOffersState();
}

class _HomeOffersState extends State<HomeOffers> {
  List<OfferModel> offerList = [];

  @override
  void initState() {
    offerList = createOfferDataList(10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MyTitle(
        title: 'Hè cực đã, ưu đãi thả ga',
      ),
      Gap(8),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: offerList
              .map((e) => OffersItem(
                    offer: e,
                  ))
              .toList(),
        ),
      ),
      Gap(24),
    ]);
  }
}

class OffersItem extends StatelessWidget {
  final OfferModel offer;
  const OffersItem({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Card(
        elevation: 1,
        shadowColor: Colors.grey,
        color: Colors.white,
        child: Container(
          width: 150,
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: (Image.network(
                  net_img_url + "offer.png",
                  width: 150,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    //       ,
                    // Image.asset(
                    // img_offer_url + offer.image,
                    // width: 150,
                    // height: 100,
                    // fit: BoxFit.cover,
                    // )
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  offer.title,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      size: 20,
                    ),
                    Gap(4),
                    Text(
                      offer.time,
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
