
import 'package:biswas_shopping_bd/services/generate_order_id_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

void placeOrder({
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken}) async{

  final user = FirebaseAuth.instance.currentUser;
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

      }
    }catch(e){
      print("Error $e");
    }
  }
}