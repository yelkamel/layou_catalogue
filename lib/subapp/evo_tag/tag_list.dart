import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:layou_catalogue/database/evo.dart';
import 'package:layou_catalogue/model/evo_tag.dart';

class TagList extends StatefulWidget {
  final EvoDatabase database;
  final Function onSelected;
  final List<dynamic> selectedTags;

  const TagList({
    Key key,
    this.onSelected,
    this.selectedTags = const [],
    this.database,
  }) : super(key: key);
  @override
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EvoTag>(
      stream: widget.database.tagsStream(), // a Stream<int> or null
      builder: (BuildContext context, AsyncSnapshot<EvoTag> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return Tags(
            key: _tagStateKey,
            spacing: 10,
            runSpacing: 10,
            itemCount: snapshot.data.list.length, // required
            itemBuilder: (int index) {
              final tag = snapshot.data.list[index];
              return ItemTags(
                key: Key(index.toString()),
                index: index,
                active: widget.selectedTags.contains(tag['name']),
                title: tag["name"],
                combine: ItemTagsCombine.withTextBefore,
                onPressed: widget.onSelected,
              );
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
