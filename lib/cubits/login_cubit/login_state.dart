import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Login {}

class LoginLoad extends Login {}

class LoginTrue extends Login {
   var user;
  LoginTrue(this.user);
}

class LoginFalse extends Login {}
