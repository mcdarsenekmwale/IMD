import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

Color getCategoryColor(String _cat){
  Color _color;
  switch(_cat){
    case "UI UX Design":
      _color = ThemeDetails.sYellowColor;
      break;
    case "Motivation":
      _color = Color(0XFF9bc2df);
      break;
  }

  return _color;
}

//
//choose file to upload
Future<File> chooseFile(BuildContext context, String title) async {
  File image;
  switch (title) {
    case 'camera':
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      break;
    case 'gallery':
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      break;
    default:
//        image = await ImagePicker.platform.pickImage(source: null);
      break;
  }
  return image;
}


//
//loading
loadingDialog({ BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content:Center(
          child: SpinKitFadingFour(
            color: ThemeDetails.yellowColor,
            size: 50.0,
          ),
        ),
        backgroundColor: Colors.transparent,
      );
    },
  );
}


/// The user selects a file, and the task is added to the list.
Future<UploadTask> uploadFile(File _image, String folder) async {
  if ( _image== null) {
    return null;
  }
  UploadTask uploadTask;
  String filename  = basename(_image.path);
  // Create a Reference to the file
  Reference ref = FirebaseStorage.instance
      .ref()
      .child(folder)
      .child('/$filename');
  final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': _image.path});
  if (kIsWeb) {
    uploadTask = ref.putData(await _image.readAsBytes(), metadata);
  } else {
    uploadTask = ref.putFile(_image, metadata);
  }
  await uploadTask.whenComplete(() => null);
  return Future.value(uploadTask);
}


/// Handles the user pressing the PopupMenuItem item.
void handleUploadType(U) async {
  File file;
  UploadTask task = await uploadFile(file, 'user_profiles');
  if (task != null) {

  }
}



downloadLink(Reference ref) async {
  try{
    // final link = await ref.getDownloadURL();
    // // await Clipboard.setData(ClipboardData(
    // //   text: link,
    // // ));
    return await ref.getDownloadURL();
  }
  catch(e){
    throw Exception(e);
  }
}

Future<void> _downloadFile(Reference ref, BuildContext context) async {
  final Directory systemTempDir = Directory.systemTemp;
  final File tempFile = File('${systemTempDir.path}/temp-${ref.name}');
  if (tempFile.existsSync()) await tempFile.delete();

  await ref.writeToFile(tempFile);

  Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        'Success!\n Downloaded ${ref.name} \n from bucket: ${ref.bucket}\n '
            'at path: ${ref.fullPath} \n'
            'Wrote "${ref.fullPath}" to tmp-${ref.name}.txt',
      )));
}

//error responses
enum RESPONSES{
  DOES_NOT_EXIST,
  ALREADY_EXIST,
  SUCCESSFULLY_ADDED,
  REMOVED_SUCCESSFULLY,
  DETAILS_SEND,
  ERROR_USER_NOT_FOUND,
  FAILED_TO_CREATE,
  CREATED_SUCCESSFULLY,
  SUCCESSFULLY_LOGIN,
  FAILED_TO_LOGIN,
  FAILED_TO_ADD,
  FAILED_TO_REMOVE
}




