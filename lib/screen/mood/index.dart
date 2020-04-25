import 'package:flutter/material.dart';
import 'package:layou_catalogue/database/evo.dart';
import 'package:layou_catalogue/model/evo_package.dart';
import 'package:layou_catalogue/model/evo_tag.dart';
import 'package:layou_catalogue/subapp/evo_list/evo_list_screen.dart';
import 'package:provider/provider.dart';

import 'card_expandable_list.dart';

class MoodRoot extends StatelessWidget {
  const MoodRoot({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<EvoDatabase>(context);

    return StreamBuilder<EvoPackage>(
      stream: database.evoPackageStream('mood'),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (snapshot.data != null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: snapshot.data.list.map((item) {
              return SizedBox(
                width: 250,
                height: 60,
                child: RaisedButton(
                  onPressed: () => EvoListScreen.show(
                    context,
                    database,
                    item['tags'],
                  ),
                  child: Text(item['name']),
                ),
              );
            }).toList(),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
