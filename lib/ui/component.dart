import 'package:fluttertoast/fluttertoast.dart';

// write functions or components that are common for whole project

showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
  );
}
