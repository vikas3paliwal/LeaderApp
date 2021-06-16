import 'package:Leader/screens/Signup/signup_screen.dart';
import 'package:Leader/screens/add_business_screen.dart';
import 'package:Leader/screens/home_screen.dart';
import 'package:Leader/screens/my_business_screen.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/widgets/forgot_password.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Leader/components/Onboarding/text_field_container.dart';
import 'package:Leader/constant.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:Leader/utilities/http_exception.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './background.dart';
// import '../../Signup/signup_screen.dart';
import '../../../components/Onboarding/already_have_an_account_acheck.dart';
import '../../../components/Onboarding/rounded_button.dart';
import '../../../components/Onboarding/rounded_input_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utilities/auth_helper.dart' as authHelper;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = new GoogleSignIn(
      // signInOption: SignInOption.standard,
      // scopes: [
      //   'email',
      //   'https://www.googleapis.com/auth/contacts.readonly',
      // ],
      );

  bool _isLoading = false;
  bool _isPasswordHidden = true;
  bool _forgotpass = false;
  var _email;
  var _password;

  Future signInWithGoogle(BuildContext context) async {
    // final sharedPref = await SharedPreferences.getInstance();
    try {
      print('line 40');
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      print('line 43');
      if (googleSignInAccount != null) {
        print(googleSignInAccount.email);
        print('line 45');
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        print('line 48:' + googleSignInAuthentication.accessToken);

        final response = await ApiHelper().googleLogIn(
          {
            "access_token": "${googleSignInAuthentication.accessToken}",
            "code": "${googleSignInAuthentication.serverAuthCode}"
          },
          'rest-auth/google/',
        );
        Navigator.of(context).pushNamed(MyHomePage.routeName);
        // print(response);
        print('line 53');
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  _signIn() async {
    print('object');
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await authHelper.logIn(_email.trim(), _password.trim());
      print('uID: ${ApiHelper().getUID()}');
      Flushbar(
        message: "Logged In Successfully!",
        duration: Duration(seconds: 3),
      )..show(context);

      ApiResponse response =
          await ApiHelper().getRequest(endpoint: 'leadgrow/business');

      print(response.data.length);
      if (response.data.length != 0) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AddBusinessDetailsScreen()),
            (route) => false);
      }
    } on HttpException catch (error) {
      Flushbar(
        message: '${error.toString()}',
        duration: Duration(seconds: 3),
      )..show(context);
    } catch (error) {
      print(error);
      Flushbar(
        message: "Error Logging In",
        duration: Duration(seconds: 3),
      )..show(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: _forgotpass
            ? ForgotPassword(() {
                setState(() {
                  _forgotpass = !_forgotpass;
                });
              })
            : Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/images/icons/login.svg",
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      onSaved: (value) {
                        _email = value;
                      },
                      hintText: "Your Email",
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        obscureText: _isPasswordHidden,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: kPrimaryColor,
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password can\'t be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : RoundedButton(
                            text: "LOGIN",
                            press: () {
                              _signIn();
                            },
                          ),

                    TextButton(
                      child: Text("LOGIN WITH GOOGLE"),
                      onPressed: () {
                        signInWithGoogle(context);
                      },
                    ),
                    // (_isLoading)
                    //     ? SpinKitThreeBounce(
                    //         color: Theme.of(context).primaryColor,
                    //       )
                    //     :
                    SizedBox(height: size.height * 0.03),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _forgotpass = !_forgotpass;
                          });
                        },
                        child: Text('Forgot Password?')),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
