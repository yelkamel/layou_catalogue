import 'package:flutter/material.dart';
import 'package:layou_catalogue/widget/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  ListItemBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
    this.controller,
  }) : super(key: key);

  final ScrollController controller;
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return const EmptyContent();
      }
    } else if (snapshot.hasError) {
      return const EmptyContent(
        title: 'Connexion internet interrompu',
        message: "Pas possible d'avoir les sugestions",
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.builder(
      controller: controller,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 200.0),
            child: Container(
              alignment: Alignment.center,
              //  child: Text("tout en bas"),
            ),
          );
        }
        return itemBuilder(context, items[index]);
      },
    );
  }
}
