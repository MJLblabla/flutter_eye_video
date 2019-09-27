import 'package:flutter/material.dart';

import 'HotViewModel.dart';
import 'RankPage.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with SingleTickerProviderStateMixin {
  var _viewModel = HotViewModel();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _viewModel.getTabInfo().then((_) {
      _tabController = new TabController(vsync: this, length: 3);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _viewModel.tabItems.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "热门",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 1,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black38,
            tabs: _viewModel.tabItems.map((e) => Tab(text: e.name)).toList(),
            indicatorColor: Colors.white,
            controller: _tabController,
            onTap: (index) {},
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: _viewModel.tabItems
                .map((e) => RankPage(
                      pageUrl: e.apiUrl,
                    ))
                .toList()),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
