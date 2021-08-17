import 'package:auth_file/auth/widget/auth_main.dart';
import 'package:auth_file/constant.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',style: tabTextStyle.copyWith(fontSize: 26),),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.logout,color: tabTextColor,size: 30,), onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return AuthMainPage();
            }));
          })
        ],
        backgroundColor: defaultColor, brightness: Brightness.light,),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Text('Welcome',style: homeTextStyle,),
      ),
    );
  }
}
