
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyevideo/entity/issue_entity.dart';
import 'package:flutter_eyevideo/entity/tab_info_entity.dart';
import 'package:flutter_eyevideo/http/http.dart';

import '../constant.dart';

class HotViewModel{

  List<TabInfoItem> tabItems = [];

  EasyRefreshController controller = EasyRefreshController();
  ScrollController scrollController = ScrollController();
  List<Item> itemList = [];



  Future getTabInfo() async {
    try {
      var response = await HttpUtil.doGet(Constant.rankListUrl,);
      Map map = json.decode(response.toString());
      var tabInfoEntity = TabInfoEntity.fromJson(map);

      tabItems = tabInfoEntity.tabInfo.tabList;
      print("获取热门标题成功");
    } catch (e, s) {
      print("获取热门标题失败"+e.toString());
      print(e);
    }
  }


  Future loadHotPageData(String pageUrl) async {
    try {
      var response = await HttpUtil.doGet(
        pageUrl,
      );
      Map map = json.decode(response.toString());
      var issueEntity = Issue.fromJson(map);
      this.itemList = issueEntity.itemList;

      controller.resetLoadState();
      controller.finishRefresh();

      return itemList;
    } catch (e, s) {
      controller.resetLoadState();
      controller.finishRefresh();
      return null;
    }
  }


}