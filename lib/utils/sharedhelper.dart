import 'package:shared_preferences/shared_preferences.dart';

class Sharedhelper{
  Sharedhelper._();
  static Sharedhelper sharedhelper = Sharedhelper._();


  Future<void> islogin(islogin) async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setBool('islogin', islogin);
  }
  Future<bool?> readlogin() async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    bool? islogin =  sharedPreferences.getBool('islogin');
    return islogin;
  }

}