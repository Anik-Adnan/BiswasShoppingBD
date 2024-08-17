import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //for password visibility
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethod(
      String userEmail,
      String userPassword,
      )async{

    EasyLoading.show(status: "Please wait");
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      EasyLoading.dismiss();
      return userCredential;

    }on FirebaseException catch(e){
      EasyLoading.dismiss();
      print("$e");
      // Get.snackbar("Error", "$e");
    }
  }

}