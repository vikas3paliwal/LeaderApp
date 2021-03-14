import 'dart:async';
import 'package:flushbar/flushbar.dart';
// import 'package:coach_app/Dialogs/SucessDialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: 30.0 + 16.0,
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        margin: EdgeInsets.only(top: 66.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Please Choose your langauge'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      EasyLocalization.of(context)
                          .setLocale(context.supportedLocales[1]);
                      Navigator.of(context).pop();
                      Flushbar(
                        message: "भाषा सफलतापूर्वक बदल गई",
                        duration: Duration(seconds: 3),
                      )..show(context);

                      // showDialog(
                      //     context: context,
                      //     builder: (context) => SuccessDialog(
                      //         success:
                      //             'प्रभाव देखने के लिए, ऐप को पुनरारंभ करें'));
                      // Timer(Duration(seconds: 1), () {
                      //   Navigator.of(context).pop();
                      //   if (Navigator.of(context).canPop()) {
                      //     Navigator.of(context).pop();
                      //   }
                      // });
                    },
                    child: Text('हिन्दी'),
                  ),
                  FlatButton(
                    color: Color(0xffF36C24),
                    onPressed: () {
                      EasyLocalization.of(context)
                          .setLocale(context.supportedLocales[0]);
                      Navigator.of(context).pop();
                      Flushbar(
                        message: "Language changed successfully",
                        duration: Duration(seconds: 3),
                      )..show(context);
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => SuccessDialog(
                      //         success: 'To See effect, Restart the App'));
                      // Timer(Duration(seconds: 2), () {
                      //   Navigator.of(context).pop();
                      //   if (Navigator.of(context).canPop()) {
                      //     Navigator.of(context).pop();
                      //   }
                      // });
                    },
                    child: Text(
                      'English',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
