import 'package:agriconnect/bloc/auth_bloc.dart';
import 'package:agriconnect/uicomponents/uicomponents.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double padding = 30;
  @override 
  Widget build(BuildContext context) 
  {
    var state = BlocProvider.of<AuthBloc>(context).state;
    return Scaffold(
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            if (state is AuthSuccessful) Text(
              "Welcome "+ state.username,
              style: TextStyle( 
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Noto',
                fontWeight: FontWeight.bold
              ),
            )
            else Text(
              "Welcome",
              style: TextStyle( 
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Noto',
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "What would you like to explore",
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
            BigNavButton(name: "Crops", color: Colors.cyan, onPressed: () {Navigator.of(context).pushNamed("/prodserv", arguments: ["crop"]);}),
            BigNavButton(name: "Transport", color: Colors.green, onPressed: () {Navigator.of(context).pushNamed("/prodserv", arguments: ["transport"]);}),
            BigNavButton(name: "Land", color: Colors.pink, onPressed: () {Navigator.of(context).pushNamed("/prodserv", arguments: ["land"]);}),
            BigNavButton(name: "Storage", color: Colors.yellow, onPressed: () {Navigator.of(context).pushNamed("/prodserv", arguments: ["storage"]);}),
            
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/speech"),
        child: Icon(Icons.mic),
      ),
    );
  }
}
