
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationService{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestNotification()  async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted permission');
    }else if( settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted provisional permission');
    }else{
      Get.snackbar('Notification permission denied', 'Please allow notification to receive updates.',
      snackPosition: SnackPosition.BOTTOM);
    }
    Future.delayed(
        Duration(seconds: 2),(){
          AppSettings.openAppSettings(type: AppSettingsType.notification);
    });
  }

  // get Token
  Future<String> getDeviceToken() async{
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      String? token = await messaging.getToken();
      print("Device Token : $token");
      return token!; // returned token to send messages to users from our custom server

  }

}