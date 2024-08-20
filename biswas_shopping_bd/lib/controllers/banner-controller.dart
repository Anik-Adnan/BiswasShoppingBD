
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{
  RxList<String> bannersUrls = RxList<String>([]);

  @override
  void OnInit(){
    super.onInit();
    fetchBannersUrls();
  }

  Future<void> fetchBannersUrls()async{
    try{
      QuerySnapshot bannersSnapshot = await FirebaseFirestore.instance.collection('banners').get();

      if(bannersSnapshot.docs.isEmpty){
        bannersUrls.value = bannersSnapshot.docs
            .map((doc) => doc['pant'] as String).toList();
      }
    }catch(e){
      print("$e");
    }
  }
}