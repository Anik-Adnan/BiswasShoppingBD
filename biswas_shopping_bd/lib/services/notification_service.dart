
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:biswas_shopping_bd/screens/user-panel/main-screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService{
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  // send notification request
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
      if(kDebugMode){
        print('User granted provisional permission');
      }
    }else{
      if(kDebugMode){
        print('Notification permission denied');
      }
      Get.snackbar('Notification permission denied', 'Please allow notification to receive updates.',
      snackPosition: SnackPosition.BOTTOM);
    }
    // Future.delayed(
    //     Duration(seconds: 2),(){
    //       AppSettings.openAppSettings(type: AppSettingsType.notification);
    // });
  }

  // get FCM Token
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

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(BuildContext context,RemoteMessage message) async {
      var androidInitialiationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInitializationSettings = const DarwinInitializationSettings();
  
      var initializationSettings = InitializationSettings(
        android: androidInitialiationSettings,
        iOS: iosInitializationSettings
      );
  
      await _flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveBackgroundNotificationResponse: (payload){
            handleMessage(context, message);
          });
  }
  
  // firebase Initialization
  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message){
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      
      if(kDebugMode){
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if(Platform.isAndroid){
        forgroundMessage();

      }
      if(Platform.isIOS){
        initLocalNotifications(context, message);
        showNotification(message);

      }
    });
  }

  // background && terminated
  Future<void> setupInteractMessage(BuildContext context) async{
      //background state
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      handleMessage(context,message);
    });
    // a terminated state.
    FirebaseMessaging.instance.getInitialMessage()
        .then((RemoteMessage? message){
          if(message != null
              && message.data.isNotEmpty
          ){
            handleMessage(context,message);
          }
    });


  }
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Channel Discription ...',
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
      ticker: 'ticker',
      sound: channel.sound,
    );
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: 'my_data',
      );
    });
  }

  Future<void> forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  Future<void> handleMessage(
      BuildContext context,
      RemoteMessage message,
      ) async {
    print(
        "Navigating to appointments screen. Hit here to handle the message. Message data: ${message
            .data}");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
  }
}