
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllFlashSaleProductsScreen extends StatefulWidget{
  const AllFlashSaleProductsScreen({super.key});

  @override
  State<AllFlashSaleProductsScreen> createState() => _AllFlashSaleProductsScreenState();

}
class _AllFlashSaleProductsScreenState extends State<AllFlashSaleProductsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlashSale Offer Products'),
      ),
    );
  }

}