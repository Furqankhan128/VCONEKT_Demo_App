import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vconekt_demo_app/blocs/auth_bloc.dart';
import 'package:vconekt_demo_app/constants/colors.dart';
import 'package:vconekt_demo_app/constants/strings.dart';
import 'package:vconekt_demo_app/constants/style.dart';
import 'package:vconekt_demo_app/events/auth_events.dart';
import 'package:vconekt_demo_app/global_variables.dart';
import 'package:vconekt_demo_app/ui/widgets/app_bar.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';

import '../widgets/image_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _activeNotifications = true;

  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: buildAppBar(context,title: "Profile",leading: const SizedBox(),center: true),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [

              ImageWidget(kLogo,fit: BoxFit.fill,isLocalImage: true,isCircular: true,isProfileImage: true,height: 100.w,width: 100.w,),
              kVerticalSpace16,
              Row(children: [
                Expanded(
                    flex: 1,
                    child: Text("Username",style: kDarkLargeStyle.copyWith(color: kGreyColor),)),
                Expanded(
                  flex: 2,
                  child: Column(children: [
                    Text("${gFirebaseAuth.currentUser?.email!.split("@").first.toUpperCase()}",style: kDarkBoldLargeStyle,),
                    Divider(),
                  ],),
                ),
              ],),
              kVerticalSpace8,
              Row(children: [
                Expanded(
                    flex: 1,
                    child: Text("Email",style: kDarkLargeStyle.copyWith(color: kGreyColor),)),
                Expanded(
                  flex: 2,
                  child: Column(children: [
                    Text("${gFirebaseAuth.currentUser?.email!}",style: kDarkBoldLargeStyle,),
                    Divider(),
                  ],),
                ),
              ],),
kVerticalSpace12,
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Settings",style: kDarkBoldExtraLargeStyle)),
              kVerticalSpace8,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kBlackColor,width: 1.5),
                  borderRadius: kBorderRadius16,
                ),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text("Language"),
                    ),
                    ListTile(
                      leading: Icon(Icons.notification_add_outlined),
                      title: Text("Notifications"),
                      trailing: Switch(onChanged: (val){
                        setState(() {
                          _activeNotifications=val;
                        });
                      },value: _activeNotifications,activeColor: kAccentColor),
                    ),
                    ListTile(
                      leading: Icon(Icons.nightlife_sharp),
                      title: Text("Dark Mode",),
                      trailing: Switch(onChanged: (val){
                        setState(() {
                          _darkMode=val;
                        });
                      },value: _darkMode,activeColor: kAccentColor),
                    ),
                    ListTile(
                      leading: Icon(Icons.help),
                      title: Text("Help Center"),
                    )
                  ],
                ),
              ),
              kVerticalSpace16,
              ButtonWidget(text: "Log Out", onPressed: (){
                BlocProvider.of<AuthBloc>(context).add(LogOut());
              })
            ],
          ),
        ),
      ),
    );
  }
}
