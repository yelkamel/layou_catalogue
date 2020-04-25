import 'package:flutter/material.dart';
import 'package:layou_catalogue/model/evo.dart';

class EvoBuilder extends StatelessWidget {
  final Evo model;
  final Function onPress;
  const EvoBuilder({Key key, this.model, this.onPress}) : super(key: key);

  Widget _buildCarrousel(BuildContext context, Evo evo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(evo.name),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: evo.list.map((item) {
              return SizedBox(
                height: 100,
                width: 100,
                child: Card(
                  child: Center(
                      child: Text(
                    item['name'],
                    style: TextStyle(fontSize: 10),
                  )),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (model.type) {
      case 'audio':
        return InkWell(
          onTap: onPress,
          child: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              height: 150,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(model.name, style: TextStyle(fontSize: 16)),
                    Text(model.id, style: TextStyle(fontSize: 10)),
                    Text(model.tags.toString(), style: TextStyle(fontSize: 10)),
                    Text(model.type, style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          ),
        );
      default:
        return Placeholder();
    }
  }
}
