import 'package:flutter/material.dart';
import 'package:layou_catalogue/widget/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(T item);
typedef ReorderItem<T> = void Function(int oldIndex, int newIndex);

class ReorderListBuilder<T> extends StatefulWidget {
  ReorderListBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
    @required this.onReorder,
    this.controller,
  }) : super(key: key);

  final ScrollController controller;
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final ReorderItem<T> onReorder;

  @override
  _ReorderListBuilderState createState() => _ReorderListBuilderState();
}

class _ReorderListBuilderState<T> extends State<ReorderListBuilder<T>> {
  List<T> _list;

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      final List<T> items = widget.snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return const EmptyContent();
      }
    } else if (widget.snapshot.hasError) {
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
    return ReorderableListView(
        onReorder: widget.onReorder,
        children: [for (final item in items) widget.itemBuilder(item)]);
  }
}
