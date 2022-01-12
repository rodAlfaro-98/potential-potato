import 'package:flutter/material.dart';
import 'package:pet_home/pages/home.dart';
import 'package:pet_home/pages/login.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => Login(),
    'home': (BuildContext context) => Home(),
  };
}
