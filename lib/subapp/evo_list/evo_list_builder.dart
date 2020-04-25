import 'package:flutter/material.dart';
import 'package:layou_catalogue/database/evo.dart';
import 'package:layou_catalogue/model/evo.dart';
import 'package:layou_catalogue/widget/empty_content.dart';
import 'package:layou_catalogue/widget/list_items_builder.dart';
import 'package:layou_catalogue/widget/list_reorder_builder.dart';
import 'package:provider/provider.dart';

class EvoListBuilder extends StatelessWidget {
  final List<dynamic> tags;
  final Function itemBuilder;
  final bool isReorderable;
  const EvoListBuilder(
      {Key key,
      this.tags = const ["ALL"],
      @required this.itemBuilder,
      this.isReorderable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<EvoDatabase>(context);

    return StreamBuilder<List<Evo>>(
      stream:
          tags[0] == "ALL" ? database.allEvoStream() : database.evoStream(tags),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (snapshot.data == null) return const EmptyContent();

        if (isReorderable) {
          return ReorderListBuilder<Evo>(
            snapshot: snapshot,
            itemBuilder: itemBuilder,
            onReorder: (oldIndex, newIndex) {
              final Evo evo_1 = snapshot.data[oldIndex];
              final Evo evo_2 = snapshot.data[newIndex];

              evo_1.position = newIndex + 1;
              evo_2.position = oldIndex + 1;
              database.setEvo(evo_1);
              database.setEvo(evo_2);
            },
          );
        }
        return ListItemBuilder<Evo>(
          snapshot: snapshot,
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
