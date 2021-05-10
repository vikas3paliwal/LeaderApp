import 'package:Leader/components/Onboarding/rounded_button.dart';
import 'package:Leader/components/Onboarding/rounded_input_field.dart';
import 'package:Leader/utilities/api-response.dart';
import 'package:Leader/utilities/api_helper.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final Function callback;
  ForgotPassword(this.callback);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Enter Email here',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 30,
        ),
        RoundedInputField(
          hintText: 'Your email',
          controller: _controller,
        ),
        SizedBox(
          height: 10,
        ),
        RoundedButton(
          text: 'Reset',
          color: Colors.yellow,
          press: () async {
            ApiResponse response;
            response = await ApiHelper().forgotpass(
                '/rest-auth/password/reset/', {"email": "${_controller.text}"});
            if (!response.error) {
              Flushbar(
                message: 'Password reset e-mail has been sent.',
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              )..show(context);
              callback();
            }
            print(response.errorMessage);
            print(response.error);
          },
        )
      ],
    );
  }
}
