import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:real_chat/src/packages/features/chat_detail/chat_detail.dart';

import '../di/di.dart';
import '../navigator/app_navigator.dart';
import '../navigator/chateo_flow.dart';

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

}

class NotificationSetup {
  NotificationSetup(
    this._messaging,
  ) {
    channel = const AndroidNotificationChannel(
      'chat', // id
      
      'ChatNotifications', // title
      description:
          'This channel is used for chat notifications.', // description
      importance: Importance.high,
      
    );
  }

  late final AndroidNotificationChannel channel;
  final FirebaseMessaging _messaging;

  Future<void> setupFlutterNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

   await _requestPermissions();

  
    // // Configure message handling when the app is in the foreground or background
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   showFlutterNotification(message);
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   handleMessage(message);
    // });

    // final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    // if (initialMessage != null) {
    //   handleMessage(initialMessage);
    // }
  
  }

  Future<void> _requestPermissions() async {
    try {
      await _messaging.requestPermission(
        announcement: true,
        carPlay: true,
        criticalAlert: true,
      );
    } catch (e) {
      print("Error requesting permissions: $e");
    }
  }
  
  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        
        NotificationDetails(
          android: AndroidNotificationDetails(
            
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: notification.android!.imageUrl!,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }


 void handleMessage(RemoteMessage message) {

    final Map<String, dynamic> data = message.data;
    if (data.isNotEmpty) {
      final String? userChatUid = data['userChatUid'];
      final String? userChatName = data['userChatName'];
      final String? userChatPhotoUrl = data['userChatPhotoUrl'];
      final bool userChatStatus = data['userChatStatus'] == 'true';
      final String? myUid = data['myUid'];

      if (userChatUid != null && myUid != null) {
        navigatorKey.currentState?.pushNamed(
          AppNavigator.ROUTE_CHAT,
          arguments: {
            AppNavigator.ARGS_USER_CHAT_ID: userChatUid,
            AppNavigator.ARGS_USER_CHAT_NAME: userChatName,
            AppNavigator.ARGS_USER_CHAT_STATUS: userChatStatus,
            AppNavigator.ARGS_USER_PHOTO_URL: userChatPhotoUrl,
            AppNavigator.ARGS_MY_UID: myUid,
          },
        );

        
      }
    } else {
      print("Message data is empty");
    }
  }
}
