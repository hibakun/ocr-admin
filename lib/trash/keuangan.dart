// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:ocr_admin/pages/detail.dart';
// import 'package:path/path.dart' as path;
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class KeuanganPage extends StatefulWidget {
//   const KeuanganPage({Key? key}) : super(key: key);
//
//   @override
//   _KeuanganPageState createState() => _KeuanganPageState();
// }
//
// class _KeuanganPageState extends State<KeuanganPage> {
//   final TextEditingController _title = TextEditingController();
//   final TextEditingController _desc = TextEditingController();
//   FirebaseStorage storage = FirebaseStorage.instance;
//
//   // Select and image from the gallery or take a picture with the camera
//   // Then upload to Firebase Storage
//   Future<void> _upload(String inputSource) async {
//     final prefs = await SharedPreferences.getInstance();
//     final picker = ImagePicker();
//     XFile? pickedImage;
//     try {
//       pickedImage = await picker.pickImage(
//           source: inputSource == 'camera'
//               ? ImageSource.camera
//               : ImageSource.gallery,
//           maxWidth: 1920);
//
//       final String fileName = path.basename(pickedImage!.path);
//       File imageFile = File(pickedImage.path);
//       prefs.setString("judul", _judul.text);
//       prefs.setString("detail", _detail.text);
//       _judul.clear();
//       _detail.clear();
//       try {
//         // Uploading the selected image with some custom meta data
//         await storage.ref(fileName).putFile(
//             imageFile,
//             SettableMetadata(customMetadata: {
//               'uploaded_by': prefs.getString('judul').toString(),
//               'description': prefs.getString('detail').toString(),
//             }));
//
//         // Refresh the UI
//         setState(() {});
//       } on FirebaseException catch (error) {
//         if (kDebugMode) {
//           print(error);
//         }
//       }
//     } catch (err) {
//       if (kDebugMode) {
//         print(err);
//       }
//     }
//   }
//
//   // Retriew the uploaded images
//   // This function is called when the app launches for the first time or when an image is uploaded or deleted
//   Future<List<Map<String, dynamic>>> _loadImages() async {
//     List<Map<String, dynamic>> files = [];
//
//     final ListResult result = await storage.ref().list();
//     final List<Reference> allFiles = result.items;
//
//     await Future.forEach<Reference>(allFiles, (file) async {
//       final String fileUrl = await file.getDownloadURL();
//       final FullMetadata fileMeta = await file.getMetadata();
//       files.add({
//         "url": fileUrl,
//         "path": file.fullPath,
//         "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
//         "description":
//             fileMeta.customMetadata?['description'] ?? 'No description'
//       });
//     });
//
//     return files;
//   }
//
//   // Delete the selected image
//   // This function is called when a trash icon is pressed
//   Future<void> _delete(String ref) async {
//     await storage.ref(ref).delete();
//     // Rebuild the UI
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Keuangan'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Expanded(
//                 child: FutureBuilder(
//                   future: _loadImages(),
//                   builder: (context,
//                       AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       return ListView.builder(
//                         itemCount: snapshot.data?.length ?? 0,
//                         itemBuilder: (context, index) {
//                           final Map<String, dynamic> image =
//                               snapshot.data![index];
//
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => DetailPage(
//                                     gambar: snapshot.data![index]['url'],
//                                     detail: snapshot.data![index]
//                                         ['description'],
//                                     judul: snapshot.data![index]['uploaded_by'],
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               margin: const EdgeInsets.symmetric(vertical: 10),
//                               child: ListTile(
//                                 dense: false,
//                                 leading: Image.network(
//                                   image['url'],
//                                   width: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 title: Text(
//                                   image['uploaded_by'],
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 subtitle: Text(
//                                   image['description'],
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 trailing: IconButton(
//                                   onPressed: () => _delete(image['path']),
//                                   icon: const Icon(
//                                     Icons.delete,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   },
//                 ),
//               ),
//               TextFormField(
//                 controller: _judul,
//                 decoration: InputDecoration(
//                   filled: true,
//                   hintText: "Judul",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               TextFormField(
//                 controller: _detail,
//                 decoration: InputDecoration(
//                   filled: true,
//                   hintText: "Deskripsi",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton.icon(
//                       onPressed: () => _upload('camera'),
//                       icon: const Icon(Icons.camera),
//                       label: const Text('camera')),
//                   ElevatedButton.icon(
//                       onPressed: () => _upload('gallery'),
//                       icon: const Icon(Icons.library_add),
//                       label: const Text('Gallery')),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
