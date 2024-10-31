
import 'package:biswas_shopping_bd/models/order-model.dart';
import 'package:biswas_shopping_bd/screens/user-panel/main-screen.dart';
import 'package:biswas_shopping_bd/services/generate_order_id_service.dart';
import 'package:biswas_shopping_bd/services/send_notification_service.dart';
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void placeOrder({
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken,}) async{

  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: "Please Wait..");
  if(user != null){
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel cartModel = OrderModel(
          productId: data['productId'],
          categoryId: data['categoryId'],
          productName: data['productName'],
          categoryName: data['categoryName'],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data['productQuantity'],
          productTotalPrice: double.parse(data['productTotalPrice'].toString()),
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );
        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set(
            {
              'uId': user.uid,
              'customerName': customerName,
              'customerPhone': customerPhone,
              'customerAddress': customerAddress,
              'customerDeviceToken': customerDeviceToken,
              'orderStatus': false,
              'createdAt': DateTime.now()
            },
          );

          //upload orders
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('confirmOrders')
              .doc(orderId)
              .set(cartModel.toMap());

          //delete cart products
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(cartModel.productId.toString())
              .delete()
              .then((value) {
            print('Delete cart Products $cartModel.productId.toString()');
          });
        }

        // save notification
        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(user.uid)
            .collection('notifications')
            .doc()
            .set(
          {
            'title': "Order Successfully placed ${cartModel.productName}",
            'body': cartModel.productDescription,
            'isSeen': false,
            'createdAt': DateTime.now(),
            'image': cartModel.productImages,
            'fullPrice': cartModel.fullPrice,
            'salePrice': cartModel.salePrice,
            'isSale': cartModel.isSale,
            'productId': cartModel.productId,
          },
        );
      }

      //sent notification
      await SendNotificationService.sendNotificationUsingApi(
        token:
        "eUn8RwbTSwK3bv9j3rKQu8:APA91bHYEje64oVDk6dsLNI77jELGjmh59RB_yPNmlZXzqMoJB76HF7l6qMCPFSez5SqsDKoIdt6k8RDzDRt2IVTchgIigmRD_QmJIxZ1MkSscXknbOmPsZkYsUGToaFZQvvb1c-JFec",
        title: "Order Successfully placed",
        body: "notification body",
        data: {
          "screen": "notification",
        },
      );


      print("Order Confirmed");
      Get.snackbar(
        "Order Confirmed",
        "Thank you for your order!",
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );

      EasyLoading.dismiss();
      Get.offAll(() => MainScreen());
    }catch(e){
      print("Error $e");
    }
  }
}