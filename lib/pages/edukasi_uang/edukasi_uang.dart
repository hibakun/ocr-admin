import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr_admin/pages/edukasi_uang/bisnis.dart';
import 'package:ocr_admin/pages/edukasi_uang/investasi.dart';
import 'package:ocr_admin/pages/edukasi_uang/keuangan.dart';
import 'package:ocr_admin/pages/edukasi_uang/marketing.dart';

class EdukasiUangPage extends StatefulWidget {
  const EdukasiUangPage({Key? key}) : super(key: key);

  @override
  State<EdukasiUangPage> createState() => _EdukasiUangPageState();
}

class _EdukasiUangPageState extends State<EdukasiUangPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: width,
            height: height,
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  child: Image.asset(
                    "assets/images/edukasibg.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/edukasiuang.png",
                            width: width * 0.27,
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Text(
                            "EDUKASI UANG",
                            style: GoogleFonts.passeroOne(
                              textStyle:
                              TextStyle(color: Colors.white, fontSize: 28),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 4.0,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => KeuanganPage()));
                        },
                        child: Container(
                          width: width,
                          height: height * 0.13,
                          color: Color(0xff6B8292).withOpacity(0.6),
                          child: Center(
                            child: Text(
                              "Keuangan",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BisnisPage()));
                        },
                        child: Container(
                          width: width,
                          height: height * 0.13,
                          color: Color(0xffAED1EA).withOpacity(0.8),
                          child: Center(
                            child: Text(
                              "Bisnis",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InvestasiPage()));
                        },
                        child: Container(
                          width: width,
                          height: height * 0.13,
                          color: Color(0xffE1F0FB).withOpacity(0.8),
                          child: Center(
                            child: Text(
                              "Investasi",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MarketingPage()));
                        },
                        child: Container(
                          width: width,
                          height: height * 0.13,
                          color: Color(0xff92A5B2).withOpacity(0.8),
                          child: Center(
                            child: Text(
                              "Marketing",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
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
