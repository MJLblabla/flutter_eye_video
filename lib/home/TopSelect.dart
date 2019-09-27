import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyevideo/entity/issue_entity.dart';

import 'HomePageItem.dart';
import 'TimeTitleItem.dart';
import 'TopViewModel.dart';

class TopSelectPage extends StatefulWidget {
  @override
  _TopSelectPageState createState() => _TopSelectPageState();
}

class _TopSelectPageState extends State<TopSelectPage> with AutomaticKeepAliveClientMixin {
  var _topViewModel = TopSelectViewModel();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _topViewModel.onRefresh().then((_){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("每日精选", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Color(0xFFF4F4F4),
        child: EasyRefresh.custom(
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          taskIndependence: true,
          controller: _topViewModel.controller,
          scrollController: _topViewModel.scrollController,
          onRefresh: () {

            _topViewModel.onRefresh().then((_){
              setState(() {});
            });

          },
          onLoad: () {
            _topViewModel.onLoadMore().then((_){
              setState(() {});
            });
          },
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                child: HomePageListWidget(itemList:_topViewModel.itemList),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HomePageListWidget extends StatelessWidget {
  List<Item> itemList;

  HomePageListWidget({Key key, this.itemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var item = itemList[index];
          if (item.type == 'textHeader') {
            return TimeTitleItem(timeTitle: item.data.text);
          }
          return HomePageItem(item: item);
        },
        separatorBuilder: (context, index) {
          var item = itemList[index];
          var itemNext = itemList[index + 1];
          if (item.type == 'textHeader' || itemNext.type == 'textHeader') {
            return Divider(
              height: 0,
              color: Color(0xFFF4F4F4),

              /// indent: 前间距, endIndent: 后间距
            );
          }
          return Divider(
            height: 10,
            color: Color(0xFFF4F4F4),

            /// indent: 前间距, endIndent: 后间距
          );
        },
        itemCount: itemList.length);
  }
}
