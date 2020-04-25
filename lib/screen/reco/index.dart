import 'package:flutter/material.dart';
import 'package:layou_catalogue/database/evo.dart';
import 'package:layou_catalogue/model/evo.dart';
import 'package:layou_catalogue/subapp/evo_builder/index.dart';
import 'package:layou_catalogue/subapp/evo_edit/edit_audio.dart';

import 'package:layou_catalogue/subapp/evo_list/evo_list_builder.dart';
import 'package:provider/provider.dart';

class RecoRoot extends StatelessWidget {
  const RecoRoot({Key key}) : super(key: key);

  Widget _buildSlidebar(BuildContext context, Evo model) {
    final database = Provider.of<EvoDatabase>(context);

    return EvoBuilder(
        model: model,
        onPress: () {
          EditAudioScreen.show(context, database, audio: model);
        });
  }

  @override
  Widget build(BuildContext context) {
    return EvoListBuilder(
      itemBuilder: _buildSlidebar,
    );
  }
}
