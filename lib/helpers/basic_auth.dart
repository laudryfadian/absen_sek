// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class BasicAuth {
//   getBasic() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? email = prefs.getString('email');
//     String? token = prefs.getString('token');

//     String basicAuth = 'Basic ' + base64.encode(utf8.encode('$email:$token'));

//     return basicAuth;
//   }
// }
