import 'package:flutter/material.dart';
import 'package:layou_catalogue/database/evo.dart';
import 'package:layou_catalogue/model/evo.dart';
import 'package:layou_catalogue/service/flushbar_message.dart';
import 'package:layou_catalogue/subapp/evo_tag/tag_list.dart';
import 'package:layou_catalogue/utils/screen_size.dart';

class EditAudioScreen extends StatefulWidget {
  final EvoDatabase database;
  final Evo evo;

  const EditAudioScreen({Key key, this.database, this.evo}) : super(key: key);

  static Future<void> show(BuildContext context, EvoDatabase database,
      {Evo audio}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditAudioScreen(
          database: database,
          evo: audio,
        ),
        fullscreenDialog: false,
      ),
    );
  }

  @override
  _EditAudioState createState() => _EditAudioState();
}

class _EditAudioState extends State<EditAudioScreen> {
  String _name;
  int _min = null;
  int _sec = null;
  String _audioId;
  List<dynamic> _selectedTags = [];

  final FocusNode _minFocusNode = FocusNode();
  final FocusNode _secFocusNode = FocusNode();
  final FocusNode _audioIdFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.evo != null) {
      _name = widget.evo?.name;
      if (widget.evo.url != null) {
        _audioId = widget.evo.url.split('/')[3];
      }
      if (widget.evo.duration != null) {
        _min = widget.evo.duration ~/ 60;
        _sec = widget.evo.duration % 60;
      }

      if (widget.evo.tags != null) {
        _selectedTags = widget.evo.tags;
      }
    }
  }

  void _editingComplete(String type) {
    switch (type) {
      case 'name':
        FocusScope.of(context).requestFocus(_minFocusNode);
        break;
      case 'min':
        FocusScope.of(context).requestFocus(_secFocusNode);
        break;
      case 'sec':
        FocusScope.of(context).requestFocus(_audioIdFocusNode);
        break;
      default:
    }
  }

  Widget _buildAudioUrl() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: _audioIdFocusNode,
        keyboardType: TextInputType.text,
        controller: TextEditingController(text: _audioId),
        decoration: InputDecoration(
          labelText: 'Nom du fichier audio',
          labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        style: TextStyle(fontSize: 14.0, color: Colors.black),
        onChanged: (value) => _audioId = value,
      ),
    );
  }

  Widget _buildNameInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.text,
        maxLength: 30,
        controller: TextEditingController(text: _name),
        decoration: InputDecoration(
          labelText: 'Nom',
          labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        style: TextStyle(fontSize: 14.0, color: Colors.black),
        onChanged: (name) => _name = name,
        onEditingComplete: () => _editingComplete('name'),
      ),
    );
  }

  Widget _buildTagsInput() {
    return TagList(
      database: widget.database,
      selectedTags: _selectedTags,
      onSelected: (item) {
        if (_selectedTags.contains(item.title)) {
          _selectedTags.remove(item.title);
        } else {
          _selectedTags.add(item.title);
        }
      },
    );
  }

  Evo _evoFromState() {
    final id = widget.evo?.id ?? _audioId;
    return Evo(
      id: id,
      name: _name,
      duration: _min * 60 + _sec,
      url: "https://evolum.s3.eu-west-3.amazonaws.com/$_audioId",
      tags: _selectedTags,
      type: 'audio',
    );
  }

  Widget _buildDuration() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: TextField(
            focusNode: _minFocusNode,
            keyboardType: TextInputType.text,
            controller: TextEditingController(
                text: _min != null ? _min.toString() : ''),
            decoration: InputDecoration(
              labelText: 'Min',
              labelStyle:
                  TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
            ),
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            onChanged: (value) => _min = int.parse(value),
            onEditingComplete: () => _editingComplete('min'),
          ),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            focusNode: _secFocusNode,
            keyboardType: TextInputType.text,
            controller: TextEditingController(
                text: _sec != null ? _sec.toString() : ''),
            decoration: InputDecoration(
              labelText: 'Sec',
              labelStyle:
                  TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
            ),
            onChanged: (seconde) => _sec = int.parse(seconde),
            onEditingComplete: () => _editingComplete('sec'),
          ),
        ),
      ],
    );
  }

  Future<void> _setEntryAndDismiss(BuildContext context) async {
    String errorMessage = null;

    if (_name != null && _name.length < 3) {
      errorMessage = 'nom trop petit';
    }

    if (_selectedTags.isEmpty) {
      errorMessage = 'Il faut au moins un tag';
    }

    if (_min == null || _sec == null) {
      errorMessage = 'La durée est incorrect';
    }

    if (errorMessage != null) {
      Info.showInfoFlushBar(context, errorMessage);
      return;
    }

    try {
      final Evo evo = _evoFromState();
      await widget.database.setEvo(evo);
      Navigator.of(context).pop();
    } catch (e) {
      Info.showInfoFlushBar(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.evo == null ? 'Ajouter un audio' : 'Editer un audio'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNameInput(),
            const YMargin(20),
            _buildDuration(),
            const YMargin(20),
            _buildAudioUrl(),
            const YMargin(20),
            _buildTagsInput(),
            const YMargin(40),
            RaisedButton(
              onPressed: () => _setEntryAndDismiss(context),
              child: const Text("Enregistrer"),
            ),
          ],
        ),
      ),
    );
  }
}
