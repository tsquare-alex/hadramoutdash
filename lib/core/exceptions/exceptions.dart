// import 'package:flutter/material.dart';
// import '/main.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

///can be used for throwing [NoInternetException]
// class NoInternetException implements Exception {
//   late String _message;

//   NoInternetException([String message = 'No Internet Exception Occurred']) {
//     if (globalMessengerKey.currentState != null) {
//       globalMessengerKey.currentState!
//           .showSnackBar(SnackBar(content: Text(message)));
//     }
//     _message = message;
//   }

//   @override
//   String toString() {
//     return _message;
//   }
// }
