import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerExpandable extends StatefulWidget {
  const DrawerExpandable(
      {super.key, required this.cateName, required this.cateIcon});
  final String cateName;
  final String cateIcon;

  @override
  State<DrawerExpandable> createState() => _DrawerExpandableState();
}

class _DrawerExpandableState extends State<DrawerExpandable> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                          widget.cateIcon,
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.cateName,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )),
                collapsed: const Text(""),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(1))
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            SizedBox(
                              height: 5,
                            ),
                            Text("Shirt"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Short"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Shoes"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Equipment"),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
