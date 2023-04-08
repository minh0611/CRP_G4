import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class AboutUsExpandable extends StatefulWidget {
  const AboutUsExpandable(
      {super.key,
      required this.infoTitle,
      required this.infoIcon,
      required this.infoContent});
  final String infoTitle;
  final IconData infoIcon;
  final String infoContent;

  @override
  State<AboutUsExpandable> createState() => _AboutUsExpandableState();
}

class _AboutUsExpandableState extends State<AboutUsExpandable> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
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
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        widget.infoIcon,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.infoTitle,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  )),
              collapsed: const Text(""),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (var _ in Iterable.generate(1))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.infoContent,
                            style: const TextStyle(fontSize: 17),
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
    ));
  }
}
