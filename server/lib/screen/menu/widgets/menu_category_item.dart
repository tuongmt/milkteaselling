import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/models/category_model.dart';
import 'package:gap/gap.dart';

class MenuCategoryItem extends StatelessWidget {
  const MenuCategoryItem(
      {super.key, required this.categoryModel, required this.onPressed});
  final CategoryModel categoryModel;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //border: Border.all(color: Colors.red),
        color: Colors.white,
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              net_img_url + categoryModel.image,
              height: 45,
              width: 45,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image),
            ),
            Gap(2),
            Text(
              categoryModel.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12, color: Colors.black, letterSpacing: 0.9),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
