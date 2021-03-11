import 'package:flutter/material.dart';
import './text_field_container.dart';
import 'package:Leader/constant.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function onSaved;
  final TextEditingController controller;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.controller,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        // cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        onSaved: onSaved,
        validator: (value) {
          if (value.isEmpty) {
            return 'Email can\'t be empty';
          }
          return null;
        },
      ),
    );
  }
}
