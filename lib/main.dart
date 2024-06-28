

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:real_chat/src/app/chateo_app.dart';

import './src/app/di/di.dart' as di;
import 'firebase/firebase_config.dart';
import 'src/app/notification/notification_setup.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.sl<NotificationSetup>().setupFlutterNotifications();

  runApp(const ChateoApp());

}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await di.init();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   await di.sl<NotificationSetup>().setupFlutterNotifications();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GlobalLoaderOverlay(
//       child: MaterialApp(  
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
//           textTheme: const TextTheme(),
//         ),
//         home: FirebaseAuth.instance.currentUser != null
//             ? const HomePage()
//             : const OnboardingPage(),
//       ),
//     );
//   }

// }
