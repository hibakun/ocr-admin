import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageRespositoryPinjam {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadImage(
      String storage, String collectionName, XFile image, String link) async {
    try {
      await _storage
          .ref("$storage/${image.name}")
          .putFile(
            File(image.path),
          )
          .then(
            (p0) => uploadFirestore(storage, collectionName, image.name, link),
          );
    } catch (_) {}
  }

  Future<String> downloadUrl(String storage, String imageName) async {
    String url = await _storage.ref("$storage/$imageName").getDownloadURL();
    print("url : $url");
    return url;
  }

  Future<void> uploadFirestore(String storage, String collectionName,
      String imageName, String link) async {
    String url = await downloadUrl(storage, imageName);
    var timestamp = FieldValue.serverTimestamp();

    CollectionReference collection = _firestore.collection(collectionName);
    collection.add({
      "link": link,
      "url": url,
      "timestamp" : timestamp,
    });
  }
}
