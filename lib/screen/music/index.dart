import 'package:flutter/material.dart';
import 'package:layou_catalogue/model/evo.dart';
import 'package:layou_catalogue/subapp/evo_builder/widget/slidable/index.dart';
import 'package:layou_catalogue/subapp/evo_list/evo_list_builder.dart';

const tags = ['musique'];

class MusicRoot extends StatelessWidget {
  const MusicRoot({Key key}) : super(key: key);

  Widget _buildSlidebar(BuildContext context, Evo model) {
    return EvoSlidable(model: model);
  }

  @override
  Widget build(BuildContext context) {
    return EvoListBuilder(
      tags: tags,
      itemBuilder: _buildSlidebar,
    );
  }
}
