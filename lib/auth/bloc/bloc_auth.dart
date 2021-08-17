import 'dart:developer';

import 'package:auth_file/auth/services/model.dart';
import 'package:auth_file/auth/services/serviceAuth.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  Services services = Services();

  final showMessageController = BehaviorSubject<String>();
  final successController = BehaviorSubject<bool>();

  postAuthentication({String name, String email, String password}) async {
    try {
      Map<String, dynamic> map = Map<String, dynamic>();
      map.putIfAbsent('username', () => name);
      map.putIfAbsent('email', () => email);
      map.putIfAbsent('password', () => password);
        SuccessResponse getResponse = await services.signUpServices(map);
        if (getResponse.success == true) {
          showMessageController.sink.add(getResponse.message);
          successController.sink.add(true);
        } else {
          showMessageController.sink.add(getResponse.message);
          successController.sink.add(false);
        }

    } catch (e) {
      successController.sink.add(false);
    }
  }

  loginAuthentication({ String email, String password}) async {
    try {
      Map<String, dynamic> map = Map<String, dynamic>();
      map.putIfAbsent('email', () => email);
      map.putIfAbsent('password', () => password);
      var getResponse = await services.signInServices(map);
      if (getResponse == false) {
        showMessageController.sink.add('Invalid credential.');
        successController.sink.add(false);
      } else {
        showMessageController.sink.add('Login success.');
        successController.sink.add(true);
      }
    } catch (e) {
      successController.sink.add(false);
    }
  }

  dispose() {
    successController.close();
    showMessageController.close();
  }
}
