import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr_admin/pages/home.dart';
import 'package:ocr_admin/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString("user") == null && prefs.getString("pass") == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              child: Image.asset(
                "assets/images/startedbg.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: width,
              height: height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "EDUFIN.ID",
                      style: GoogleFonts.passeroOne(
                        textStyle: TextStyle(color: Colors.white, fontSize: 42),
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 5),
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/images/logo.png",
                      width: width * 0.85,
                    ),
                    SizedBox(
                      height: height * 0.18,
                    ),
                    Text(
                      "Inklusi Keuangan untuk Semua",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Color(0xff46474B),
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      "Bersama\nEdufin.id Peduli Disabilitas",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Color(0xff797979),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
