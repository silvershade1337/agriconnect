import 'package:agriconnect/apihandler/apihandler.dart';
import 'package:agriconnect/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override 
  _LoginPage createState() => _LoginPage();
}


class _LoginPage extends State<LoginPage> {
  double padding = 30;
  TextEditingController emailorphonectl = TextEditingController(), passwordctl = TextEditingController();
  @override 
  Widget build(BuildContext context) 
  {
    return Scaffold(
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const SizedBox(height: 100),
            const Text(
              "Welcome back to Agriconnect!",
              style: TextStyle( 
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Noto',
                fontWeight: FontWeight.bold
              ),              
            ),
            const SizedBox(height: 5),
            const Text(
              "We're so excited to see you again!",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle( 
                fontSize: 15,
                color: Colors.grey,
                fontFamily: "Noto",
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(vertical:10,horizontal: padding),
              child: const SizedBox(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "LOG IN TO YOUR ACCOUNT",
                    style: TextStyle( 
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
            ),
            Padding( 
                  padding: EdgeInsets.symmetric(vertical:10,horizontal: padding),
                  child: TextField(
                    controller: emailorphonectl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                        contentPadding: const EdgeInsets.only(left: 15),
                        alignLabelWithHint: true,
                        hintText: "Enter your email or phone number", 
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          
                        ),
                      )
                  )
            ),
            Padding( 
                  padding: EdgeInsets.symmetric(vertical:5,horizontal: padding),
                  child: TextField(
                    controller: passwordctl,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                        contentPadding: const EdgeInsets.only(left: 15),
                        alignLabelWithHint: true,
                        hintText: "Enter your password",
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          
                        ),
                      )
                  )
            ),
            Padding( 
              padding: EdgeInsets.only(top:padding, bottom: 5,left: padding, right: padding),
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("Login", style: TextStyle(fontSize: 20),),
                ),
                onPressed: () async {
                  try {
                    if (emailorphonectl.text.isNotEmpty && passwordctl.text.isNotEmpty) {
                      var response = await login(emailorphonectl.text, passwordctl.text);
                      String username = response.data['user']['username'];
                      BlocProvider.of<AuthBloc>(context).add(AuthSuccess(username));
                      print("USERNAME FETCHED "+username);
                      Navigator.of(context).pushNamed("/home");
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fields can not be empty")));
                    }
                  } on Exception catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password or User does not exist")));
                  }
                },
              )
            ),
             TextButton(
               child: const Text("Dont have an account? Register", style: TextStyle(color: Colors.white),),
               onPressed: () {
                 Navigator.of(context).pushNamed("/register");
               },
             ),
          ]
        )
      ),
    );
  }
}

