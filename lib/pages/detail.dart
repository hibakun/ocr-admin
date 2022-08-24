import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  String title;
  String desc;
  String imageUrl;

  Detail(
      {Key? key,
      required this.title,
      required this.desc,
      required this.imageUrl})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: height * 0.3,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        widget.desc,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
