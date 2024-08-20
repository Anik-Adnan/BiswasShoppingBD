
import 'package:biswas_shopping_bd/controllers/banner-controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWidget extends StatefulWidget{
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}
class _BannerWidgetState extends State<BannerWidget>{
  final CarouselController carouselController = CarouselController();
  final BannerController _bannerController = Get.put(BannerController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx((){
        return CarouselSlider(
          items: _bannerController.bannersUrls.map((imgUrl)=>
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.cover,
                width: Get.width-10.0,
              placeholder: (context,url)=>
                  ColoredBox(
                    color: Colors.white,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                ),),
                errorWidget: (context,url,error) => Icon(Icons.error),
              ),
        ),).toList(),
          options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.5,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1,
        ),
        );
      }),
    );
  }

}