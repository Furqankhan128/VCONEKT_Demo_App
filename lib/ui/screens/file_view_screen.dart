import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vconekt_demo_app/ui/widgets/image_widget.dart';

class FileViewScreen extends StatelessWidget {
  const FileViewScreen({
    this.backgroundDecoration=const BoxDecoration(
  color: Colors.black,
  ),
    required this.file,
  });

  final BoxDecoration backgroundDecoration;
   final File file;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,elevation: 0,),
      body: Container(
        decoration: backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery
              .of(context)
              .size
              .height,
        ),
        child: ImageWidget(
          file,
          file: file,
          fit: BoxFit.fill,

        ),
      ),
    );
  }
}