import 'package:appmovil/pages/crear_cuenta.dart';
import 'package:appmovil/pages/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  final image =
      "https://i.pinimg.com/564x/ab/19/5b/ab195bed9d31b8d2e1b59c513849f052.jpg";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: 540,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(250, 40),
                      bottomRight: Radius.elliptical(250, 70)))),
          Container(
            width: 380,
            height: 290,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                    constraints: BoxConstraints(maxWidth: 296),
                    child: Text(
                      "We are here to make your holiday easier",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.12,
                        height: 1.33333,
                        color: Color(0xff111111),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(1, 0, 0, 30),
                    constraints: BoxConstraints(maxWidth: 272),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.07,
                        height: 1.5714285714,
                        color: Color(0xff78828a),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                        child: Center(
                            child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.deepPurple)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: Text(
                            "                   Get Started                      ",
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.4444,
                                letterSpacing: 0.09,
                                color: Color(0xfffefefe)),
                          ),
                        )),
                      ),
                      Center(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 4),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.08,
                                  color: Color(0xffffffff),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Don’t have an account? ',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.08,
                                      color: Color(0xff111111),
                                    ),
                                  ),
                                  TextSpan(
                                      text: 'Register',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.08,
                                        color: Color(0xff009b8d),
                                      ),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CrearCuenta()));
                                        }),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
