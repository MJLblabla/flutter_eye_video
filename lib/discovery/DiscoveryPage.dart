import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'CategoryItemWidget.dart';
import 'DiscoveryViewModel.dart';
import 'FollowItemWidget.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with AutomaticKeepAliveClientMixin {
  var _discoveryViewModel = DiscoveryViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _discoveryViewModel.loadCategoryList().then((_) {
      setState(() {});
    });
    _discoveryViewModel.loadFollowItemList().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "发现",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
      ),
      body: Container(
          color: Colors.white,
          child: EasyRefresh.custom(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  color: Color(0xFFF4F4F4),
                  width: double.infinity,
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 13),
                  child: Text(
                    '热门分类',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 12),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _discoveryViewModel.categoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      return CategoryItemWidget(
                          item: _discoveryViewModel.categoryList[index]);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Color(0xFFF4F4F4),
                  width: double.infinity,
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                child: _renderFollowTitleWidget(context),
              ),
              SliverToBoxAdapter(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _discoveryViewModel.followItemList.length,
                    itemBuilder: (context, index) {
                      return FollowItemWidget(
                          item: _discoveryViewModel.followItemList[index]);
                    }),
              ),
              SliverPadding(
                  padding: EdgeInsets.only(bottom: 20, top: 10),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 70,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: InkWell(
                          onTap: () {
                            _discoveryViewModel.loadFollowItemList().then((_) {
                              setState(() {});
                            });
                          },
                          child: Text(
                            '换一换',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }

  /// 推荐关注标题
  Widget _renderFollowTitleWidget(context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 5),
      child: Row(
        children: <Widget>[
          Text(
            '推荐关注',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    '查看更多 >>',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    /// 跳转热门关注列表页
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => FollowListPage(),
//                      ),
//                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
