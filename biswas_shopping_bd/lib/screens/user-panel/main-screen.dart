
import '/widgets/banner-widget.dart';
import '/widgets/heading-widget.dart';
import 'package:get/get.dart';

import '/utils/app-constant.dart';
import '/widgets/drawer-widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appName,style: const TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
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
                onTap: (){},
                buttonText: "see more",
              ),

              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "According to your budget",
                onTap: (){},
                buttonText: "see more",
              ),



            ],
          ),
        ),
      ),

    );
  }

}