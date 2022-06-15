import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      String dir, String userId, Uint8List avatar) async {
    Reference ref = _storage.ref().child(dir).child(userId);
    UploadTask uploadTask = ref.putData(avatar);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
