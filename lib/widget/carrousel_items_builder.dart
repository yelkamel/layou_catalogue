import 'package:flutter/material.dart';

import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(
    BuildContext context, T item, bool active);

class CarouselItemBuilder<T> extends StatefulWidget {
  const CarouselItemBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
    this.firstItem,
    this.lastItem,
  }) : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final Widget firstItem;

  final Widget lastItem;

  @override
  _CarouselItemBuilderState createState() => _CarouselItemBuilderState();
}

class _CarouselItemBuilderState<T> extends State<CarouselItemBuilder<T>> {
  final PageController _ctrl = PageController(viewportFraction: 0.8);

  int currentPage = 0;

  @override
  void initState() {
    _ctrl.addListener(() {
      int next = _ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      final List<T> items = widget.snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return widget.lastItem;
      }
    } else if (widget.snapshot.hasError) {
      return EmptyContent(
        title: 'Probleme de Connexion internet',
        message: "Pas possible d'avoir la liste",
      );
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T> items) {
    return PageView.builder(
      controller: _ctrl,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length + 1) {
          return widget.lastItem;
        }
        return widget.itemBuilder(
            context, items[index], currentPage == index + 1);
      },
    );
  }
}
