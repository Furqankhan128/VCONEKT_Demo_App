

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'my_app.dart';

void main() async{
   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
   MobileAds.instance.initialize();
   await Firebase.initializeApp();
   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); 
   
   
   runApp(const MyApp());
}
