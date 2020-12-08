import 'package:flutter/material.dart';

class PageBottomNavigationBar extends StatefulWidget {
  final PageController controller;
  final List<BottomNavigationBarItem> items;

  const PageBottomNavigationBar({Key key, this.controller, this.items})
      : super(key: key);

  @override
  _PageBottomNavigationBarState createState() =>
      _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar> {
  int index;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        index = widget.controller.page.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index ?? 0,
      items: widget.items,
      onTap: (index) {
        setState(() {
          this.index = index;
        });
        widget.controller.animateToPage(index,
            curve: Curves.ease, duration: Duration(milliseconds: 500));
      },
    );
  }
}
