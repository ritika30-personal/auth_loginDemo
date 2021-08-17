import 'package:auth_file/auth/bloc/bloc_auth.dart';
import 'package:auth_file/constant.dart';
import 'package:auth_file/home/myHome.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthMainPage extends StatefulWidget {
  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  AuthBloc bloc = AuthBloc();
  var emailVal = RegExp(r'^([A-Za-z0-9+_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,63})$');
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int index = 0;
  List<Widget> list = [
    Tab(child: Text(tabText1,style: tabTextStyle,),),
    Tab(
      child: Text(tabText2,style: tabTextStyle,),
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: list.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      primary: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: defaultColor, brightness: Brightness.light,),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100)),
                  color: defaultColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size. height * 0.1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    onTap: (selectedIndex) {
                      setState(() {
                        index = selectedIndex;
                        _tabController.animateTo(index);
                        if(_tabController.index == 1){
                          _emailController.clear();
                          _passwordController.clear();
                        }else{
                          _nameController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                        }
                      });
                    },
                    automaticIndicatorColorAdjustment: false,
                    controller: _tabController,
                    tabs: list,
                  ),
                ),
                SizedBox(height: 20,),
                index == 0 ?
                Container(
                  height:  MediaQuery.of(context).size. height * 0.22,
                  child:  selectField(0),
                ) : Container(
                  height:  MediaQuery.of(context).size. height * 0.25,
                  child:  selectField(1),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: RawMaterialButton(
                    shape: StadiumBorder(),
                    onPressed: () async{
                      bool check = validateField(index);
                      if(!check){
                        return;
                      }else{
                        if(index == 1){
                         await bloc.postAuthentication(name: _nameController.text.trim(),
                          email: _emailController.text.trim(),password: _passwordController.text.trim());
                         if(bloc.successController.value == true){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                             return MyHomePage();
                           }));
                           var toast = SnackBar(content:Text(bloc.showMessageController.value,style: toastTextStyle,),backgroundColor: defaultColor,);
                           ScaffoldMessenger.of(context).showSnackBar(toast);
                         }else{
                           var toast = SnackBar(content:Text(bloc.showMessageController.value,style: toastTextStyle,),backgroundColor: defaultColor,);
                           ScaffoldMessenger.of(context).showSnackBar(toast);
                         }
                        }
                        else{
                          await bloc.loginAuthentication(
                              email: _emailController.text.trim(),password: _passwordController.text.trim());
                          if(bloc.successController.value == true){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return MyHomePage();
                            }));
                            var toast = SnackBar(content:Text(bloc.showMessageController.value,style: toastTextStyle,),backgroundColor: defaultColor,);
                            ScaffoldMessenger.of(context).showSnackBar(toast);
                          }else{
                            var toast = SnackBar(content:Text(bloc.showMessageController.value,style: toastTextStyle,),backgroundColor: defaultColor,);
                            ScaffoldMessenger.of(context).showSnackBar(toast);
                          }
                        }
                      }
                    },
                    fillColor: defaultColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                          btnText,
                        style: btnTextStyle
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  selectField(int index) {
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: 40),
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: fieldContainerColor),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom:14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                index == 1 ? field(controller : _nameController, hintText: 'Name')  : Container(),
                field(controller : _emailController,hintText: 'Email'),
                field(controller : _passwordController,hintText: 'Password',isPass: true),
              ],),
          ),),
    );
  }

  field({controller,hintText,bool isPass}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      child: TextField(
        controller: controller,
        cursorColor: defaultColor,
        obscureText: isPass == true ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintTextStyle,
          border: UnderlineInputBorder(borderSide: borderSide),
          focusedBorder: UnderlineInputBorder(borderSide: borderSide),
          enabledBorder: UnderlineInputBorder(borderSide: borderSide)
        ),
        style: hintTextStyle,
      ),
    );
  }

  validateField(index){
    if((_nameController.text == null || _nameController.text.trim().isEmpty) &&
        (_emailController.text == null || _emailController.text.trim().isEmpty) &&
        (_passwordController.text == null || _passwordController.text.trim().isEmpty)
    ){
      ScaffoldMessenger.of(context).showSnackBar(snackBarAll);
      return false;
    }else if(index == 1 && (_nameController.text == null || _nameController.text.trim().isEmpty)){

      ScaffoldMessenger.of(context).showSnackBar(snackBarName);
      return false;
    }else if(_emailController.text == null || _emailController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(snackBarEmail);
      return false;
    } else if(_passwordController.text == null || _passwordController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(snackBarPass);
      return false;
    }else if(_emailController.text != null && !emailVal.hasMatch(_emailController.text.trim())){
      ScaffoldMessenger.of(context).showSnackBar(snackBarEmailVal);
      return false;
    }else if( _passwordController.text != null   &&  _passwordController.text.length <= 5){
      ScaffoldMessenger.of(context).showSnackBar(snackBarPassVal);
      return false;
    }else{
      return true;
    }
  }
}
