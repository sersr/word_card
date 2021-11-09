import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:useful_tools/binding.dart';
import 'pages/app.dart';

void main() {
  NopWidgetsFlutterBinding.ensureInitialized();
  // RendererBinding.instance!.renderView.automaticSystemUiAdjustment = false;
  runApp(const AllProviders());
}
