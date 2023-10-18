import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ShowAlert {
  static alertSuccessWithRoutePushRemove(
      BuildContext context, String title, route) {
    Alert(
      context: context,
      type: AlertType.success,
      title: title,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => route,
            ),
            (route) => false,
          ),
          width: 120,
          child: const Text(
            "Okey",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  static alertSuccessWithNavigatePop(BuildContext context, String title) {
    Alert(
      context: context,
      type: AlertType.success,
      title: title,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "Okey",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        )
      ],
    );
  }

  static alertFailedWithNavigatePop(BuildContext context, String title) {
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "Okey",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  static alertFailedWithNavigatePush(
      BuildContext context, String title, route) {
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => route),
            );
          },
          width: 120,
          child: const Text(
            "Okey",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
}
