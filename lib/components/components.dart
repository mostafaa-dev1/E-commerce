import 'package:flutter/material.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/search/search_model.dart';

// void ShowTaost({
//   required String message,
//   required LoginShowState state
// })=> Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: ChoseColorState(state),
//     textColor: Colors.white,
//     fontSize: 16.0
// );
enum LoginShowState { SUCCESS, EROOR, WARNING }

Color ChoseColorState(LoginShowState state) {
  Color color;
  switch (state) {
    case LoginShowState.SUCCESS:
      color = Colors.green;
      break;

    case LoginShowState.EROOR:
      color = Colors.green;
      break;

    case LoginShowState.WARNING:
      color = Colors.green;
      break;
  }
  return color;
}
