import 'package:flutter/material.dart';

class WorldCard extends StatefulWidget {
  const WorldCard({Key? key}) : super(key: key);

  @override
  _WorldCardState createState() => _WorldCardState();
}

class _WorldCardState extends State<WorldCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Container());
  }
}

/// providers
class AllProviders extends StatelessWidget {
  const AllProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WorldCard();
  }
}
