import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/text_style.dart';
import '../../../resources/utils.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderText,
    required this.itemText,
    required this.descriptionText,
    required this.colorText,
    required this.plantDateText,
  });

  final String orderText;
  final String itemText;
  final String descriptionText;
  final String colorText;
  final String plantDateText;

  @override
  Widget build(BuildContext context) {
    final barcodeSvg = buildBarcodeSvg(
      Barcode.code128(),
      '$orderText$itemText',
      width: 200,
      height: 200,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order $orderText",
                    style: AppTextTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "Item $itemText",
                    style: AppTextTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              SvgPicture.string(
                barcodeSvg,
                width: 50,
                height: 50,
              ),
              // Icon(
              //   Icons.qr_code_2,
              //   size: 50,
              // ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            descriptionText,
            style: AppTextTheme.textTheme.titleMedium,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          Text(
            colorText,
            style: AppTextTheme.textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            "PLANT DATE $plantDateText",
            style: AppTextTheme.textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "____/999 QTY ____/____ BOXES",
            style: AppTextTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}