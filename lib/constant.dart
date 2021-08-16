 import 'package:flutter/material.dart';

Color defaultColor = Colors.deepPurple.shade300.withOpacity(0.8);
Color tabTextColor = Colors.white;
Color fieldContainerColor = Colors.white;
Color textFieldColor = Colors.grey.shade400;

final tabTextStyle = TextStyle(color: tabTextColor,fontSize: 14,fontWeight: FontWeight.bold);
final hintTextStyle = TextStyle(color: textFieldColor,fontSize: 20,fontWeight: FontWeight.bold);
final btnTextStyle = TextStyle(color: tabTextColor,fontWeight: FontWeight.bold);
final homeTextStyle = TextStyle(color: defaultColor,fontSize: 50,fontWeight: FontWeight.bold);
final toastTextStyle = TextStyle(color: defaultColor,fontSize: 24,fontWeight: FontWeight.bold);

final borderSide = BorderSide(color: textFieldColor,width: 2.0);

String  tabText1  = 'SIGN IN';
String  tabText2  = 'SIGN UP';
String  allFieldText  = 'Fill the details to continue.';
String  nameFieldText  = 'Name is required.';
String  emailFieldText  = 'Email is required.';
String  passFieldText  = 'Password is required.';

final snackBarAll =  SnackBar(content:Text(allFieldText,style: toastTextStyle,),backgroundColor: defaultColor,);
final snackBarName =  SnackBar(content:Text(nameFieldText,style: toastTextStyle,),backgroundColor: defaultColor,);
final snackBarEmail =  SnackBar(content:Text(emailFieldText,style: toastTextStyle,),backgroundColor: defaultColor,);
final snackBarPass =  SnackBar(content:Text(passFieldText,style: toastTextStyle,),backgroundColor: defaultColor,);