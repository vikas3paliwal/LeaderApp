import '../constant.dart';
import 'package:flutter/material.dart';

class ImageBottomSheet extends StatelessWidget {
  final Function onTapCamera;
  final Function onTapGallery;
  ImageBottomSheet({this.onTapCamera, this.onTapGallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
          color: Theme.of(context).primaryColor,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0)),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                child: Text(
                  "Choose",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24.0,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: onTapCamera,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              'Camera',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.17),
                              blurRadius: 10.0, // soften the shadow
                              //extend the shadow
                              offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  5.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onTapGallery,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.image,
                              size: 60.0,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.17),
                              blurRadius: 10.0, // soften the shadow
                              //extend the shadow
                              offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  5.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}