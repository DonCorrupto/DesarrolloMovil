import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String?> uploadImage(File image) async {
  //print(image.path);
  final String namefile = image.path.split("/").last;

  Reference ref = storage.ref().child("avatares").child(namefile);

  final UploadTask uploadTask = ref.putFile(image);
  //print(uploadTask);

  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  //print(snapshot);

  final String url = await snapshot.ref.getDownloadURL();
  //print(url);

  if (snapshot.state == TaskState.success) {
    return url;
  } else {
    return null;
  }
}
