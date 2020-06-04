

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartfarmer/src/screens/landing.dart';
import 'package:smartfarmer/src/screens/login.dart';
import 'package:smartfarmer/src/screens/signup.dart';

abstract class Routes{
  static MaterialPageRoute materialRoutes(RouteSettings settings){

    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (context)=>Landing());
        break;
      case"/signup":
        return MaterialPageRoute(builder: (context)=>Signup());
        break;
      case "/login" :
          return MaterialPageRoute(builder: (context)=>Login());
      default:
          return MaterialPageRoute(builder: (context)=>Login());
    }
  }

}