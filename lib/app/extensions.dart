import 'package:new_project/app/constants.dart';

extension NonNullString on String? {
  String orEmpty(){
    return this ?? Constants.empty ;
  }
}

extension NonNullInteger on int? {
  int orZero(){
    return this ?? Constants.zero;
  }
}