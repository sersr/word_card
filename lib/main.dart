import 'package:flutter/material.dart';
import 'package:useful_tools/binding.dart';
import 'pages/app.dart';

void main() {
  NopWidgetsFlutterBinding.ensureInitialized();
  runApp(const AllProviders());
}
