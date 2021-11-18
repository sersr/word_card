import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_tools/useful_tools.dart';

import '../event/repository.dart';
import '../provider/home_list.dart';
import 'home.dart';

class WorldCard extends StatefulWidget {
  const WorldCard({Key? key}) : super(key: key);

  @override
  _WorldCardState createState() => _WorldCardState();
}

class _WorldCardState extends State<WorldCard> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeApp());
  }
}

/// providers
class AllProviders extends StatelessWidget {
  const AllProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (_) {
        Log.i('create');
        return Repository();
      }),
      ChangeNotifierProvider(
          create: (context) => HomeListNotifier(repository: context.read())),
    ], child: const WorldCard());
  }
}
