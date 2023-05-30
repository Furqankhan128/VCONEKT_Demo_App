
import 'dart:async';
import 'dart:io' as io;
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vconekt_demo_app/constants/colors.dart';
import 'package:vconekt_demo_app/constants/style.dart';
import 'package:vconekt_demo_app/ui/screens/file_view_screen.dart';
import 'package:vconekt_demo_app/ui/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 

class CloudStorageScreen extends StatefulWidget {
  
  const CloudStorageScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CloudStorageScreen();
  }
}

class _CloudStorageScreen extends State<CloudStorageScreen> {
  List<UploadTask> _uploadTasks = [];
 
  Future<UploadTask?> uploadFile(PlatformFile platformFile) async {

    UploadTask uploadTask;
 
    Reference ref = FirebaseStorage.instance.ref().child('documents').child('/${platformFile.name}');

      uploadTask = ref.putFile(io.File(platformFile.path!));

    return Future.value(uploadTask);
  }

 
  Future<void> handleUploadType() async {
    final FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(allowMultiple: false, allowCompression: true,type: FileType.any);

    if (filePickerResult != null) {
      UploadTask? task = await uploadFile(filePickerResult.files.first);

      if (task != null) {
        setState(() {
          _uploadTasks = [..._uploadTasks, task];
        });
      }

    } else {

      Fluttertoast.showToast(msg: "No file was selected");

    }
  }

  void _removeTaskAtIndex(int index, String fileName) async{

    Reference ref = FirebaseStorage.instance.ref().child('documents').child('/${fileName}');
    try{
      await ref.delete();
      setState(() {
        _uploadTasks = _uploadTasks..removeAt(index);
      });
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }


  }

  Future<void> _downloadLink(Reference ref) async {
    final link = await ref.getDownloadURL();

    await Clipboard.setData(
      ClipboardData(
        text: link,
      ),
    );

    Fluttertoast.showToast(msg: "Success!\n Copied download URL to Clipboard!");

  }

  Future<void> _downloadFile(Reference ref) async {
    final io.Directory systemTempDir = io.Directory.systemTemp;
    final io.File tempFile = io.File('${systemTempDir.path}/temp-${ref.name}');
    if (tempFile.existsSync()) await tempFile.delete();

    await ref.writeToFile(tempFile);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>FileViewScreen(file: tempFile)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,
        title: 'Cloud Storage',
        center: true
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: handleUploadType,
        tooltip: "Press the '+' button to add a new file.",
        child: Icon(Icons.add,size: kMenuIconSize,),

      ),
      body: _uploadTasks.isEmpty
          ? const Center(child: Text("Press the '+' button to add a new file."))
          : ListView.builder(
        itemCount: _uploadTasks.length,
        itemBuilder: (context, index) => UploadTaskListTile(
          task: _uploadTasks[index],
          onDismissed: () => _removeTaskAtIndex(index,_uploadTasks[index].snapshot.metadata!.name),
          onDownloadLink: () async {
            return _downloadLink(_uploadTasks[index].snapshot.ref);
          },
          onDownload: () async {
            return _downloadFile(_uploadTasks[index].snapshot.ref);
          },
        ),
      ),
    );
  }
}

/// Displays the current state of a single UploadTask.
class UploadTaskListTile extends StatelessWidget {
  // ignore: public_member_api_docs
  const UploadTaskListTile({
    Key? key,
    required this.task,
    required this.onDismissed,
    required this.onDownload,
    required this.onDownloadLink,
  }) : super(key: key);
 
  final UploadTask task;
 
  final VoidCallback onDismissed;

  final VoidCallback onDownload;

  final VoidCallback onDownloadLink;

  String _bytesTransferred(TaskSnapshot snapshot) {

    return '${getFileSizeString(bytes: snapshot.bytesTransferred)}/${getFileSizeString(bytes: snapshot.totalBytes)}';

  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (
          BuildContext context,
          AsyncSnapshot<TaskSnapshot> asyncSnapshot,
          ) {
        Widget subtitle = const Text('');
        TaskSnapshot? snapshot = asyncSnapshot.data;
        TaskState? state = snapshot?.state;

        if (asyncSnapshot.hasError) {
          if (asyncSnapshot.error is FirebaseException &&
              (asyncSnapshot.error as FirebaseException).code == 'canceled') {
            subtitle = const Text('Upload canceled.');
          } else {
            subtitle = const Text('Something went wrong.');
          }
        } else if (snapshot != null) {
          subtitle = Text('$state: ${_bytesTransferred(snapshot)} bytes sent');
        }

        return Dismissible(
          background: Container(
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete,color: kAccentColor,),
                  kHorizontalSpace16,
                ]
            ),
          ),
          key: Key(task.hashCode.toString()),
          onDismissed: ($) => onDismissed(),
          child: ListTile(
            title: Text('Upload Task #${task.hashCode}'),
            subtitle: subtitle,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (state == TaskState.running)
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: task.pause,
                  ),
                if (state == TaskState.running)
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: task.cancel,
                  ),
                if (state == TaskState.paused)
                  IconButton(
                    icon: const Icon(Icons.file_upload),
                    onPressed: task.resume,
                  ),
                if (state == TaskState.success)
                  IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: onDownload,
                  ),
                if (state == TaskState.success)
                  IconButton(
                    icon: const Icon(Icons.link),
                    onPressed: onDownloadLink,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}