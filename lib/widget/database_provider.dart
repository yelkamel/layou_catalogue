import 'package:flutter/material.dart';
import 'package:layou_catalogue/database/evo.dart';
import 'package:layou_catalogue/database/user.dart';
import 'package:provider/provider.dart';

class DatabaseProvider extends StatelessWidget {
  final Widget child;
  const DatabaseProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EvoDatabase>(
          create: (_) => EvoDatabase(),
        ),
        Provider<UserDatabase>(
          create: (_) => UserDatabase(),
        ),
      ],
      child: child,
    );
  }
}
