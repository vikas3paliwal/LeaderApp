import 'dart:math';

import 'package:Leader/models/customer.dart';
import 'package:Leader/providers/customers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddLeadScreen extends StatefulWidget {
  final Function callback;
  AddLeadScreen(this.callback);
  @override
  _AddLeadScreenState createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController leadNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController eventController = TextEditingController();
  DateTime eventDate;
  //focus node contorller
  FocusNode leadNamenode = FocusNode();
  FocusNode locationnode = FocusNode();
  FocusNode budgetnode = FocusNode();
  FocusNode mobilenode = FocusNode();
  FocusNode emailnode = FocusNode();
  FocusNode addressnode = FocusNode();
  FocusNode eventnode = FocusNode();
  void addLead() {
    try {
      if (_formKey.currentState.validate()) {
        final customer = Provider.of<Customers>(context, listen: false);
        customer.addLead(Customer(
            customerId: UniqueKey().toString(),
            name: leadNameController.text,
            location: locationController.text,
            budget: int.parse(budgetController.text),
            phoneNos: [int.parse(mobileController.text)],
            emails: [emailController.text],
            addresses: [addressController.text],
            events: [Event(day: eventDate, eventName: eventController.text)]));
        widget.callback();
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    mobileController.dispose();
    leadNameController.dispose();
    locationController.dispose();
    budgetController.dispose();
    addressController.dispose();
    eventController.dispose();
    emailnode.dispose();
    mobilenode.dispose();
    leadNamenode.dispose();
    locationnode.dispose();
    budgetnode.dispose();
    addressnode.dispose();
    eventnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Lead"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: leadNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Lead Name',
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(
                          Icons.person,
                          color: Colors.deepOrange[300],
                        ),
                        contentPadding: EdgeInsets.fromLTRB(
                            20.0,
                            MediaQuery.of(context).size.height * 0.02,
                            20.0,
                            MediaQuery.of(context).size.height * 0.02),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                      ),
                      focusNode: leadNamenode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(locationnode),
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'This field can\'t be empty';
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: locationController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(Icons.location_city,
                            color: Colors.deepOrange[300]),
                        contentPadding: EdgeInsets.fromLTRB(
                            20.0,
                            MediaQuery.of(context).size.height * 0.02,
                            20.0,
                            MediaQuery.of(context).size.height * 0.02),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                      ),
                      focusNode: locationnode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(budgetnode),
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'This field can\'t be empty';
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: budgetController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp('[0-9]'),
                            allow: true)
                      ],
                      decoration: InputDecoration(
                        labelText: 'Budget',
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(Icons.attach_money,
                            color: Colors.deepOrange[300]),
                        contentPadding: EdgeInsets.fromLTRB(
                            20.0,
                            MediaQuery.of(context).size.height * 0.02,
                            20.0,
                            MediaQuery.of(context).size.height * 0.02),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                      ),
                      focusNode: budgetnode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(mobilenode),
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'This field can\'t be empty';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp('[0-9]'),
                            allow: true),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Mobile No.',
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(Icons.call, color: Colors.deepOrange[300]),
                        contentPadding: EdgeInsets.fromLTRB(
                            20.0,
                            MediaQuery.of(context).size.height * 0.02,
                            20.0,
                            MediaQuery.of(context).size.height * 0.02),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                      ),
                      focusNode: mobilenode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(emailnode),
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'This field can\'t be empty';
                        if (value.length != 10 &&
                            !RegExp(r"^((\+){1}91){1}[1-9]{1}[0-9]{9}$",
                                    multiLine: true)
                                .hasMatch(value))
                          return 'Please enter valid Number';

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Id',
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(Icons.email, color: Colors.deepOrange[300]),
                        contentPadding: EdgeInsets.fromLTRB(
                            20.0,
                            MediaQuery.of(context).size.height * 0.02,
                            20.0,
                            MediaQuery.of(context).size.height * 0.02),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                      ),
                      focusNode: emailnode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(addressnode),
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'This field can\'t be empty';
                        if (!RegExp(
                                r'^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()\.,;\s@\"]+\.{0,1})+([^<>()\.,;:\s@\"]{2,}|[\d\.]+))$',
                                multiLine: true)
                            .hasMatch(value))
                          return 'Please enter valid email address';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        filled: true,
                        fillColor: Colors.white,
                        icon:
                            Icon(Icons.pin_drop, color: Colors.deepOrange[300]),
                        contentPadding: EdgeInsets.fromLTRB(
                            20.0,
                            MediaQuery.of(context).size.height * 0.02,
                            20.0,
                            MediaQuery.of(context).size.height * 0.02),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2)),
                      ),
                      focusNode: addressnode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(eventnode),
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'This field can\'t be empty';
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // GestureDetector(
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 7),
                        //     child: Icon(
                        //       Icons.add_circle,
                        //       size: 30,
                        //       color: Colors.deepOrange[300],
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: TextFormField(
                            controller: eventController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              labelText: 'Event',
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.event,
                                    color: Colors.deepOrange[300],
                                  ),
                                  onPressed: () async {
                                    eventDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1965, 7),
                                        lastDate: DateTime(2101));
                                    print(eventDate);
                                  }),
                              contentPadding: EdgeInsets.fromLTRB(
                                  20.0,
                                  MediaQuery.of(context).size.height * 0.02,
                                  20.0,
                                  MediaQuery.of(context).size.height * 0.02),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 2)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 2)),
                            ),
                            focusNode: eventnode,
                            validator: (value) {
                              // if (value.trim().isEmpty)
                              //   return 'This field can\'t be empty';
                              if (value.isNotEmpty && eventDate == null) {
                                return 'please select event date';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  // InkWell(
                  //   onTap: () => addLead(),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(50),
                  //     child: Container(
                  //       width: 100,
                  //       height: 30,
                  //       color: Theme.of(context).primaryColor,
                  //       child: Center(
                  //         child: Text(
                  //           "Add Lead",
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w500),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addLead(),
        label: Text(
          'Add',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        icon: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
