import 'package:Leader/screens/Signup/signup_screen.dart';
import 'package:Leader/screens/add_business_screen.dart';
import 'package:Leader/screens/home_screen.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Leader/components/Onboarding/text_field_container.dart';
import './background.dart';
// import '../../Signup/signup_screen.dart';
import '../../components/Onboarding/already_have_an_account_acheck.dart';
import '../../components/Onboarding/rounded_button.dart';
import '../../components/Onboarding/rounded_input_field.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Body(),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //     colors: [
        //       Colors.blue[200],
        //       Colors.white,
        //     ],
        //   ),
        // ),
      ),
      // backgroundColor: Colors.blue[50],
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/filled_pin.png'),
                height: 60.0,
              ),
              SizedBox(width: 20),
              TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 500),
                repeatForever: true,
                text: ['Lead Grow'],
                textStyle: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.05),
          SvgPicture.asset(
            "assets/images/icons/login.svg",
            height: size.height * 0.40,
          ),
          // SizedBox(height: size.height * 0.07),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: size.width * 0.55,
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
