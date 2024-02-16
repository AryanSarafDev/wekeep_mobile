import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wekeep_mobile/cubits/login_cubit/login_state.dart';
import 'package:wekeep_mobile/service/auth.dart';

class LoginCubit extends Cubit<Login> {
  LoginCubit() : super(LoginLoad()) {
    checkuser();
  }
  void checkuser() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user);
      emit(LoginTrue(user));
    } else {
      emit(LoginFalse());
    }
  }

  void login(var user) async {
    emit(LoginLoad());
    if (user != null) {
      emit(LoginTrue(user));
    } else
      emit(LoginFalse());
  }
  Future logout() async{
    return emit(LoginFalse());
  }
}
