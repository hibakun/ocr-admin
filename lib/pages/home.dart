import 'package:flutter/material.dart';
import 'package:ocr_admin/pages/edukasi_uang/edukasi_uang.dart';
import 'package:ocr_admin/pages/pinjam_uang/pinjam_uang.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width / 2,
                height: 50,
                child: ElevatedButton(
                  child: Text("Edukasi uang"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EdukasiUangPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: width / 2,
                height: 50,
                child: ElevatedButton(
                  child: Text("Pinjam uang"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PinjamUangPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
