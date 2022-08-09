import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../storage/storage_repository_edukasi.dart';
import '../detail.dart';

class MarketingPage extends StatefulWidget {
  const MarketingPage({Key? key}) : super(key: key);

  @override
  State<MarketingPage> createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference _collection = _firestore.collection("marketing");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Marketing'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _collection.orderBy("timestamp", descending: true).snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!.docs
                              .map((e) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                    title: e["title"],
                                    desc: e["desc"],
                                    imageUrl: e["url"],
                                  ),
                                ),
                              );
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
                                  e["title"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  e["desc"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  onPressed: () =>
                                      _collection.doc(e.id).delete(),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),)
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
                controller: _titleController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Judul",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Deskripsi",
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
                    onPressed: () => imagePicker("camera",
                        _titleController.text, _descController.text)
                        .then((value) {
                      _titleController.clear();
                      _descController.clear();
                    }),
                    icon: const Icon(Icons.camera),
                    label: const Text('camera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => imagePicker("gallery",
                        _titleController.text, _descController.text)
                        .then((value) {
                      _titleController.clear();
                      _descController.clear();
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

  Future<void> imagePicker(String input, String title, String desc) async {
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
      StorageRespositoryEdukasi()
          .uploadImage("marketing", "marketing", pickedImage, title, desc);
    }
  }
}
