import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vconekt_demo_app/constants/style.dart';
import 'package:vconekt_demo_app/ui/screens/firestore_products_screen.dart';
import 'package:vconekt_demo_app/ui/screens/google_cloud_storage.dart';
import 'package:vconekt_demo_app/ui/screens/home_screen.dart';
import 'package:vconekt_demo_app/ui/screens/profile_screen.dart';

import '../../constants/colors.dart';
import '../ads/ads_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  int _index = 0;
  final _screens = [
    HomeScreen(),
    FireStoreProductsScreen(),
    const CloudStorageScreen(),
    const AdsScreen(),
    const ProfileScreen(),
  ];

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    if (_index != 0) {
      setState(() {
        _index = 0;
      });
      return Future.value(false);
    } else {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(
            msg: "Double tap to exit", toastLength: Toast.LENGTH_SHORT);
        return Future.value(false);
      }
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _index,
          unselectedLabelStyle: TextStyle(color: kGreyColor, fontSize: 11.sp),
          selectedLabelStyle: TextStyle(color: kAccentColor, fontSize: 11.sp),
          unselectedItemColor: kGreyColor,
          type: BottomNavigationBarType.shifting,
          iconSize: 25.sp,
          onTap: (index) {

            setState(() {
              _index = index;
            });
          },
          selectedItemColor: kAccentColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              label: "Products",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_circle_rounded),
              label: "Cloud Storage",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ads_click_rounded),
              label: "Ads",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
        body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: _screens[_index]),
      ),
    );
  }
}
