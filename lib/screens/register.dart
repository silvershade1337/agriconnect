import 'package:agriconnect/apihandler/apihandler.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailorphonectl = TextEditingController(), passwordctl = TextEditingController(), usernamectl = TextEditingController();
  double padding = 30;
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
              "Create an AgriConnect account",
              style: TextStyle( 
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Noto',
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Please enter your details",
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
                  padding: EdgeInsets.symmetric(vertical:5,horizontal: padding),
                  child: TextField(
                    controller: usernamectl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                        contentPadding: const EdgeInsets.only(left: 15),
                        alignLabelWithHint: true,
                        hintText: "Name",
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                      )
                  )
            ),
            Padding( 
                  padding: EdgeInsets.symmetric(vertical:10,horizontal: padding),
                  child: TextField(
                    controller: emailorphonectl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                        contentPadding: const EdgeInsets.only(left: 15),
                        alignLabelWithHint: true,
                        hintText: "Email or phone number", 
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
                        hintText: "Create a password",
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                      )
                  )
            ),
            Padding( 
              padding: EdgeInsets.only(top:padding, bottom: 5,left: padding, right: padding),
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Register", style: TextStyle(fontSize: 20),),
                ),
                onPressed: () async {
                  try {
                    if (emailorphonectl.text.isNotEmpty && passwordctl.text.isNotEmpty && usernamectl.text.isNotEmpty) {
                      var response = await register(usernamectl.text, emailorphonectl.text, passwordctl.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successful. Please login")));
                      Navigator.of(context).popAndPushNamed("/login");
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fields can not be empty")));
                    }
                  } on Exception catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                  }
                  
                },
              )
            ),
             TextButton(
               child: const Text("Have an account? Log in instead", style: TextStyle(color: Colors.white),),
               onPressed: () {
                 Navigator.of(context).pop();
               },
             ),
          ]
        )
      ),
    );
  }
}
