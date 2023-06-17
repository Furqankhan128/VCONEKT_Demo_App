
import 'package:flutter/material.dart';
import 'package:vconekt_demo_app/constants/style.dart';
import 'package:vconekt_demo_app/ui/widgets/app_bar.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';
import 'anchord_adaptive_widget.dart';
import 'fluid_widget.dart';
import 'inline_adaptive_widget.dart';
import 'native_template_widget.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  AdsScreenState createState() => AdsScreenState();
}

class AdsScreenState extends State<AdsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "Google AdMob",),
      body: ListView(
        padding: kScreenPadding,
        children: [
          kVerticalSpace24,
          ButtonWidget(text: "Fluid Ads", onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FluidExample()),
            );
          }),

          kVerticalSpace24,
          ButtonWidget(text: "Inline Adaptive Ads", onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InlineAdaptiveExample()),
            );
          }),

          kVerticalSpace24,
          ButtonWidget(text: "Anchored Adaptive Ads", onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnchoredAdaptiveExample()),
            );
          }),

          kVerticalSpace24,
          ButtonWidget(text: "Native Template Ads", onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NativeTemplateExample()),
            );
          })
        ],
      )
    );
  }
}