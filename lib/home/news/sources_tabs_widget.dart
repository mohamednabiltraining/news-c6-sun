import 'package:flutter/material.dart';
import 'package:news_c6_sun/api/model/sources_response.dart';
import 'package:news_c6_sun/home/news/news_list.dart';
import 'package:news_c6_sun/home/news/tab_widget.dart';

class SourcesTabs extends StatefulWidget {
  List<Source> sourcesList;
  SourcesTabs(this.sourcesList);

  @override
  State<SourcesTabs> createState() => _SourcesTabsState();
}

class _SourcesTabsState extends State<SourcesTabs> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
              onTap: (index){
                setState(() {
                  selectedIndex=index;
                });
              },
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: widget.sourcesList.map((source){
                  bool isSelected = widget.sourcesList.indexOf(source) == selectedIndex;
                  return Tab(
                child: TabWidget(source,isSelected),
              );
            }).toList()
            ),
            NewsList(widget.sourcesList[selectedIndex])
          ],
        ));
  }
}
