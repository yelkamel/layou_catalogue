import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:layou_catalogue/database/evo.dart';
import 'package:layou_catalogue/model/evo.dart';
import 'package:layou_catalogue/subapp/evo_edit/edit_audio.dart';
import 'package:provider/provider.dart';

class EvoSlidable extends StatefulWidget {
  final Evo model;
  const EvoSlidable({Key key, this.model}) : super(key: key);

  @override
  _EvoSlidableState createState() => _EvoSlidableState();
}

class _EvoSlidableState extends State<EvoSlidable> {
  int _position;
  final FocusNode _positionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _position = widget.model.position;
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<EvoDatabase>(context);

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => database.deleteEvo(widget.model)),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blueGrey,
          icon: Icons.edit,
          onTap: () =>
              EditAudioScreen.show(context, database, audio: widget.model),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(widget.model.name),
          subtitle: Text(widget.model.tags.toString()),
          leading: Icon(Icons.done),
          trailing: SizedBox(
            width: 20,
            child: TextField(
              focusNode: _positionFocusNode,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              controller: TextEditingController(
                  text: _position != null
                      ? widget.model.position.toString()
                      : _position),
              style: TextStyle(fontSize: 14.0, color: Colors.black),
              onChanged: (value) {
                _position = int.parse(value);
              },
              onEditingComplete: () {
                final Evo evo = widget.model;
                evo.position = _position;
                database.setEvo(evo);
                _positionFocusNode.unfocus();
              },
            ),
          ),
        ),
      ),
    );
  }
}
