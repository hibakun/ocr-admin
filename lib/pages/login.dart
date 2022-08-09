import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr_admin/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffDADADA),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
                child: Image.asset(
                  "assets/images/startedbg.png",
                  fit: BoxFit.cover,
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
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
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 42),
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
                          height: height * 0.1,
                        ),
                        Text(
                          "Username",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          width: width,
                          height: 55,
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter some text";
                              } else if (value != "admin") {
                                return "Username incorrect";
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: Color(0xff93A3B4),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          width: width,
                          height: 55,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter some text";
                              } else if (value != "admin") {
                                return "Password incorrect";
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: Color(0xff93A3B4),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                          width: width * 0.65,
                          height: 50,
                          child: ElevatedButton(
                            child: Text(
                              "LOGIN",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xff4BB2EC),
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)))),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
