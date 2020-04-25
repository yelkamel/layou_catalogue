import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key key,
    this.title = 'Il y a rien',
    this.message = 'aucune donnée est arrivé',
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Text(title, style: TextStyle(fontSize: 35)),
          SizedBox(height: 30),
          Text(message, style: TextStyle(fontSize: 25)),
        ],
      ),
    );
  }
}
