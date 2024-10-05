import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taycoo/app/resources/text_style.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'order_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GestureDetector(
        onTap: () => Get.toNamed(Routes.SCANNER_PAGE),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
          child: Icon(
            Icons.qr_code_2,
            size: 34,
            color: Colors.white,
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: const Text('Scanned Items List'),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            // color: Colors.orange,
            child: Center(
                child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 16),
                              Image.asset(
                                "assets/png/logo.png",
                                height: 34,
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 32, right: 16, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)), color: Colors.orange),
                            child: Text(
                              "Scanned Items List",
                              style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ))),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        RepaintBoundary(
                          key:controller.globalKeys[index],
                          child: OrderCard(
                            orderText: controller.orders[index],
                            itemText: controller.items[index],
                            descriptionText: "DESCRIPTION LONG LOREM IPSUM DOLOR SIT MET CONSECTETUR ADIPISSED DO EIUS",
                            colorText: "COLOR",
                            plantDateText: "1985-00-99",
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                controller.capturePng(index);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Download"),
                            ),
                            ElevatedButton(
                              onPressed: () => Get.toNamed(Routes.HOME),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Upload"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
