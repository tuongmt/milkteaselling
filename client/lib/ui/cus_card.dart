import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/screen/cart/cart_detail.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

// Image Name
const String cardImage = "assets/images/card_image.jpg";
const String codebarImage = "assets/images/bar_code.jpg";
const String shipperImage = "assets/images/shipper.jpg";
const String coffeetalkImage = "assets/images/coffee_talk.jpg";

class CusCard extends StatelessWidget {
  const CusCard({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.topStart,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    opacity: 0.8,
                    image: AssetImage(cardImage),
                    fit: BoxFit.cover)),
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            height: 160,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            appProvider.getUserInformation.fullName.toUpperCase(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 13, 15, 15),
                                fontWeight: FontWeight.bold, ),
                          ),
                          Text(
                            '100 điểm',
                            style: TextStyle(
                                color: Color.fromARGB(255, 13, 15, 15),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      InkWell(
                        child: Text(
                          'Đổi thưởng',
                          style: TextStyle(
                              color: Color.fromARGB(255, 13, 15, 15),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                const MaxGap(10),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white60,
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(10))),
                  width: double.infinity,
                  height: 80,
                  alignment: Alignment.center,
                  child: const Column(
                    children: [
                      Gap(8),
                      Image(
                        width: 200,
                        height: 50,
                        image: AssetImage(codebarImage),
                      ),
                      Text(
                        'M128AJ1046',
                        style: TextStyle(fontSize: 11, letterSpacing: 3),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartDetail(
                            selectedVoucher: 1,
                          )));
            },
            child: const Card(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              child: Column(
                children: [
                  Image(
                    width: 100,
                    image: AssetImage(shipperImage),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Giao hàng",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )),
          const Gap(20),
          const Expanded(
              child: Card(
            surfaceTintColor: Colors.white,
            color: Colors.white,
            child: Column(
              children: [
                Image(
                    width: 88,
                    image: AssetImage(coffeetalkImage),
                    fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Đặt bàn",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
