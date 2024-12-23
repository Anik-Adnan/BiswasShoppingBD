
import 'package:biswas_shopping_bd/screens/user-panel/all-category-screen.dart';
import 'package:biswas_shopping_bd/screens/user-panel/all-flashSale-product-screen.dart';
import 'package:biswas_shopping_bd/screens/user-panel/all-products-screen.dart';
import 'package:biswas_shopping_bd/screens/user-panel/cart_screen.dart';
import 'package:biswas_shopping_bd/screens/user-panel/notification_screen.dart';
import 'package:biswas_shopping_bd/services/get_server_key.dart';
import 'package:biswas_shopping_bd/services/notification_service.dart';
import 'package:biswas_shopping_bd/services/send_notification_service.dart';
import 'package:biswas_shopping_bd/widgets/all-products-widget.dart';
import 'package:biswas_shopping_bd/widgets/categories-widget.dart';
import 'package:biswas_shopping_bd/widgets/flashSale-widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '/widgets/banner-widget.dart';
import '/widgets/heading-widget.dart';
import 'package:get/get.dart';

import '/utils/app-constant.dart';
import '/widgets/drawer-widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{

  NotificationService notificationService = NotificationService();
  final GetServerKey _getServerKey = GetServerKey();

  @override
  void initState() {
    super.initState();
    notificationService.requestNotification();
    notificationService.getDeviceToken();
    // FcmService.firebaseInit();

    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appName),
        actions:  [
          GestureDetector(
            onTap: ()=> {
              Get.to(()=> NotificationScreen()),
              // EasyLoading.show();
              // await SendNotificationService.sendNotificationUsingApi(
              //   token: await notificationService.getDeviceToken(),
              //     title: "Order Created Successfully",
              //     body: "Product Name: N/A",
              //     data: {
              //       'screen': 'order',
              //     });
              //   EasyLoading.dismiss();
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.notifications,color: Colors.black,)),
          ),
          GestureDetector(
            onTap: () async {
              Get.to(CartScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart,color: Colors.black,)),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height/95.0
              ),
              BannerWidget(),

              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your budget",
                onTap: ()=> Get.to(AllCategoryScreen()),
                buttonText: "see more>>",
              ),
              CategoriesWidget(),

              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "According to your budget",
                onTap: ()=> Get.to(AllFlashSaleProductsScreen()),
                buttonText: "see more>>",
              ),
              FlashSaleWidget(),

              HeadingWidget(
                headingTitle: "All Products",
                headingSubTitle: "According to your budget",
                onTap: () =>Get.to(AllProductsScreen()),
                buttonText: "see more>>",
              ),
              AllProductsWidget(),



            ],
          ),
        ),
      ),

    );
  }


}