import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyevideo/home/HomePageItem.dart';

import 'HotViewModel.dart';

class RankPage extends StatefulWidget {
  final String pageUrl;

  const RankPage({Key key, this.pageUrl}) : super(key: key);

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>  with AutomaticKeepAliveClientMixin {
  var _hotViewModel = HotViewModel();

  _refresh() {
    _hotViewModel.loadHotPageData(widget.pageUrl).then((_) {
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Color(0xFFF4F4F4),

        child: EasyRefresh.custom(
          enableControlFinishRefresh: true,
          controller: _hotViewModel.controller,
          scrollController: _hotViewModel.scrollController,
          onRefresh: () {
            _refresh();
          },
          slivers: <Widget>[

            SliverToBoxAdapter(
              child: Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 10,
                      color: Color(0xFFF4F4F4),
                    );
                  },
                  itemCount: _hotViewModel.itemList.length,
                  itemBuilder: (context, index) {
                    return HomePageItem(item: _hotViewModel.itemList[index]);
                  },

                ),
              ),
            ),
          ],
        )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
