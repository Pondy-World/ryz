import 'package:shared_preferences/shared_preferences.dart';

class RyzAppState {
  static final RyzAppState _instance = RyzAppState._internal();

  factory RyzAppState() {
    return _instance;
  }

  RyzAppState._internal() {
    initializePersistedState();
  }

  Future<SharedPreferences> initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool('ryz_isLogin') ?? _isLogin;
    _id = prefs.getString('ryz_id') ?? _id;
    _name = prefs.getString('ryz_name') ?? _name;
    _email = prefs.getString('ryz_email') ?? _email;
    _phone = prefs.getString('ryz_phone') ?? _phone;
    return prefs;
  }

  late SharedPreferences prefs;

  bool _isLogin = false;
  String _id = '';
  String _name = '';
  String _email = '';
  String _phone = '';

  bool get isLogin => _isLogin;
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;

  set isLogin(bool _value) {
    _isLogin = _value;
    prefs.setBool('ryz_isLogin', _value);
  }

  set id(String _value) {
    _id = _value;
    prefs.setString('ryz_id', _value);
  }

  set name(String _value) {
    _name = _value;
    prefs.setString('ryz_name', _value);
  }

  set email(String _value) {
    _email = _value;
    prefs.setString('ryz_email', _value);
  }

  set phone(String _value) {
    _phone = _value;
    prefs.setString('ryz_phone', _value);
  }
}
