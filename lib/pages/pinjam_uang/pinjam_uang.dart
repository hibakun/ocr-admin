import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_admin/storage/storage_repository_pinjam.dart';
import 'package:url_launcher/url_launcher.dart';

class PinjamUangPage extends StatefulWidget {
  const PinjamUangPage({Key? key}) : super(key: key);

  @override
  State<PinjamUangPage> createState() => _PinjamUangPageState();
}

class _PinjamUangPageState extends State<PinjamUangPage> {
  TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference _collection = _firestore.collection("pinjam_uang");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pinjam Uang'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _collection
                      .orderBy("timestamp", descending: true)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!.docs
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      openLink(e["link"]);
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: ListTile(
                                        dense: false,
                                        leading: Image.network(
                                          e["url"],
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(
                                          e["link"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: IconButton(
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Text(
                                                  "Apakah anda yakin ingin menghapus item ini ?"),
                                              title: Text("Hapus item"),
                                              actions: [
                                                FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _collection
                                                          .doc(e.id)
                                                          .delete();
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Ya"),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Tidak"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    } else {
                      return Text("Loading...");
                    }
                  },
                ),
              ),
              TextFormField(
                controller: _linkController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Link",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => imagePicker("camera", _linkController.text)
                        .then((value) {
                      _linkController.clear();
                    }),
                    icon: const Icon(Icons.camera),
                    label: const Text('Camera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () =>
                        imagePicker("gallery", _linkController.text)
                            .then((value) {
                      _linkController.clear();
                    }),
                    icon: const Icon(Icons.library_add),
                    label: const Text('Gallery'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> imagePicker(String input, String link) async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await _picker.pickImage(
          source: input == "camera" ? ImageSource.camera : ImageSource.gallery);
    } catch (_) {}

    if (pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No image was selected"),
        ),
      );
    }

    if (pickedImage != null) {
      print("Uploading....");
      StorageRespositoryPinjam()
          .uploadImage("pinjam_uang", "pinjam_uang", pickedImage, link);
    }
  }

  Future<void> openLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw "Could not launch $link";
    }
  }
}
