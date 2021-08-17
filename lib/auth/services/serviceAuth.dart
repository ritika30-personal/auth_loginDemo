import 'package:auth_file/auth/services/model.dart';
import 'package:dio/dio.dart';

class Services{

  Dio dio = new Dio();

  ///// FOR SIGNUP
  signUpServices(Map<String, dynamic> map) async{
    try{
     var res = await dio.post('https://vasts.in/test/public/api/signup',data: map);
     SuccessResponse response = SuccessResponse.fromJson(res.data);
      return response;
    }on DioError catch(e){
      print(e.toString());
    }
  }

  ////// FOR SIGNIN
  signInServices(Map<String, dynamic> map) async{
    try{
      var res = await dio.post('https://vasts.in/test/public/api/login',data: map);
      var resp = res.data['message'];
      if(resp == 'Login success'){
        return true;
      }
      else{
        return false;
      }
    } on DioError catch(e){
      return false;
    }
  }
}