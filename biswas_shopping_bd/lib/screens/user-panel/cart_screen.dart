
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class CartScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Screen'),
        iconTheme: IconThemeData(
          color: AppConstant.apptextColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          
          itemBuilder: ( context, index) {  
            return Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppConstant.appMainColor,
                  child: Text('pic'),

                ),
                title: Text('items name'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('1'),
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: AppConstant.appMainColor,
                      child: Text('-'),
                    ),
                    SizedBox(width:Get.width/20.0),
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: AppConstant.appMainColor,
                      child: Text('+'),
                    )
                  ],
                ),
              ),
            );
          },
          
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8.0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total : "),
            SizedBox(width: Get.width/40.0,),
            Text(" 100tk "),
            Padding(
              padding: EdgeInsets.only(left: 8.0,),
              child: Material(
                child: Container(
                  width: Get.width / 2.0,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appSecondaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    child: Text(
                      "Checkout",
                      style: TextStyle(color: AppConstant.apptextColor),
                    ),
                    onPressed: () {
                      // Get.to(() => CheckOutScreen());
                    },
                  ),
                ),
            ),
            ),
          ],
        ),
      ),
    );
  }

}