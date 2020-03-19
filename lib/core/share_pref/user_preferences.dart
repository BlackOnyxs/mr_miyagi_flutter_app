import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  SharedPreferences _prefs;

  initPref( )async{
    this._prefs = await SharedPreferences.getInstance();
  }

  get aplicationVersion => _prefs.getInt('version') ?? 1;

  set aplicationVersion( int value ){
    _prefs.setInt('version', value);
  }
}