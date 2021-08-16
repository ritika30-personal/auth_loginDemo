import 'package:rxdart/rxdart.dart';

class AuthBloc{

  final nameController = BehaviorSubject<String>();
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();

  postAuthentication({String name,String email,String password}){

  }

  dispose(){
    nameController.close();
    emailController.close();
    passwordController.close();
  }

}