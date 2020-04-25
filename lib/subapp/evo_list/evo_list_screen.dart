import 'package:flutter/material.dart';
import 'package:layou_catalogue/database/evo.dart';
import 'package:layou_catalogue/model/evo.dart';
import 'package:layou_catalogue/subapp/evo_builder/widget/slidable/index.dart';
import 'package:layou_catalogue/subapp/evo_edit/edit_audio.dart';
import 'package:provider/provider.dart';

import 'evo_list_builder.dart';

class EvoListScreen extends StatefulWidget {
  final String type;
  final List<dynamic> tags;
  const EvoListScreen({
    Key key,
    @required this.tags,
    this.type = 'slidable',
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
    EvoDatabase database,
    List<dynamic> tags,
  ) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (ctxt) => Provider<EvoDatabase>.value(
        value: database,
        child: Scaffold(
          appBar: AppBar(
            title: Text(tags.toString()),
            backgroundColor: Colors.blueGrey,
          ),
          body: EvoListScreen(
            tags: tags,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => EditAudioScreen.show(context, database),
            child: Icon(Icons.add),
          ),
        ),
      ),
    ));
  }

  @override
  _EvoListScreenState createState() => _EvoListScreenState();
}

class _EvoListScreenState extends State<EvoListScreen> {
  Widget _buildSlidebar(BuildContext context, Evo model) {
    if (widget.type == 'slidable') {
      return EvoSlidable(key: ValueKey(model.id), model: model);
    }

    return const Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return EvoListBuilder(
      tags: widget.tags,
      itemBuilder: _buildSlidebar,
    );
  }
}
