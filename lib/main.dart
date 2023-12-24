import 'package:flutter/material.dart';
import 'home.dart';
import 'dashboard.dart';

void main() => runApp(MaterialApp(
initialRoute: '/',
routes:
{
  '/': (context) => DashBoard(),

},
));
