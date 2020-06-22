import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapploginassignment/homescreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


enum FormType{
  login,register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

 bool validateAndSave(){

    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      print("Form is valid. Email: $_email and password: $_password");
      return true;
    }else{
      print("Form is invalid");
      return false;

    }

    print("Im here");
  }


  moveToLogin(){

   setState(() {
     _formType = FormType.login;
   });

  }

  void moveToRegistet() async {
    setState(() {
      _formType = FormType.register;
    });
  }
  void validateAndSubmit() async {
    if(validateAndSave()){

      try{
        if(_formType == FormType.login){
          FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
          print('Signed in  ${user.uid}');


          if(user != null){
            _email = null;
            _password = null;
            Navigator.push(context, MaterialPageRoute(builder: (context) => homescreen(user)));
          }

        }else{
          FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print('Registered user  ${user.uid}');
        }

      }
      catch(e){
        print(e);
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Login Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: buildInputs()+buildSubmitButton() ,
        )),
      ),
    );
  }

  List<Widget> buildInputs(){
   return [
     TextFormField(
       onSaved: (value) => _email = value,
       validator: (value) => value.isEmpty ? "Email can't be empty" : null ,
       decoration:  InputDecoration(labelText: "Email"),
     ),
     TextFormField(
       onSaved: (value) => _password = value,
       validator: (value) => value.isEmpty ? "Password can't be empty" : null ,
       decoration:  InputDecoration(labelText: "Password"),
       obscureText: true,
     ),
   ];
  }


  List<Widget> buildSubmitButton(){
   if(_formType == FormType.login){

     return [

       RaisedButton(onPressed: (){
         validateAndSubmit();

       },child: Text("Login",style: TextStyle(fontSize: 20.0,),),),

       FlatButton(onPressed: (){
         moveToRegistet();
       }, child: Text("Create an Account")),

       Text("Ps. Ignore the deisgn",style: TextStyle(fontSize: 10),),


     ];
   }else{
     return [

       RaisedButton(onPressed: (){
         validateAndSubmit();

       },child: Text("Create an Account",style: TextStyle(fontSize: 20.0,),),),

       FlatButton(onPressed: (){
         moveToLogin();
       }, child: Text("Have an account?")),

       Text("Ps. Ignore the deisgn",style: TextStyle(fontSize: 10),),
     ];
   }



  }
}
