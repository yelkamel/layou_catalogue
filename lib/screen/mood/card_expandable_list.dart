import 'package:flutter/material.dart';
import 'package:layou_catalogue/subapp/evo_list/evo_list_screen.dart';

class CardExpandableList extends StatefulWidget {
  final String name;
  final List<dynamic> list;
  const CardExpandableList({Key key, this.name, this.list}) : super(key: key);

  @override
  _CardExpandableListState createState() => _CardExpandableListState();
}

class Item {
  Item({
    this.name,
    this.tags,
    this.isExpanded = false,
  });

  String name;
  List<dynamic> tags;
  bool isExpanded;
}

class _CardExpandableListState extends State<CardExpandableList> {
  List<Item> _data;

  @override
  void initState() {
    _data = widget.list.map((item) {
      return Item(
        name: item["name"],
        tags: item['tags'],
        isExpanded: false,
      );
    }).toList();
    super.initState();
  }

  Widget _buildHeader(Item item) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(item.name, style: TextStyle(fontSize: 20)),
      Text('#${item.tags[0]}', style: TextStyle(fontSize: 12)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map((value) {
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) => _buildHeader(value),
          isExpanded: value.isExpanded,
          body: Container(
            height: 300,
            child: EvoListScreen(
              tags: value.tags,
            ),
          ),
        );
      }).toList(),
    );
  }
}
