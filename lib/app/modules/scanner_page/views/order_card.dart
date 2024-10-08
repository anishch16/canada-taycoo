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
    required this.smallText,
    required this.pickArea,
    required this.quantity,
  });

  final String orderText;
  final String itemText;
  final String descriptionText;
  final String colorText;
  final String plantDateText;
  final String smallText;
  final String pickArea;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order #$orderText",
                style: AppTextTheme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                "Item #$itemText",
                style: AppTextTheme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    descriptionText,
                    style: AppTextTheme.textTheme.labelMedium,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        smallText,
                        style: AppTextTheme.textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(" - ", style: AppTextTheme.textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                      Text(
                        pickArea,
                        style: AppTextTheme.textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "PLANT DATE $plantDateText",
                    style: AppTextTheme.textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),
                  Text(
                    "____/$quantity QTY ____/____ BOXES",
                    style: AppTextTheme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

            ],
          ),
        ),
        Positioned(
          right: -20,
          top: 5,
          child: SvgPicture.string(
            buildBarcodeSvg(Barcode.qrCode(), '$orderText|$itemText'),
            height: 40,
            width: 40,
          ),
        ),
      ],
    );
  }
}
