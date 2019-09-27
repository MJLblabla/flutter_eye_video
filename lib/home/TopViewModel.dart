import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyevideo/entity/issue_entity.dart';
import 'package:flutter_eyevideo/http/http.dart';

import '../constant.dart';

class TopSelectViewModel {
  EasyRefreshController controller = EasyRefreshController();
  ScrollController scrollController = ScrollController();

  String nextPageUrl;
  bool isRefresh = true;
  List<Item> itemList = [];
  List<Item> bannerList = [];

  Future<List<Item>> _loadBanner() async {
    try {
      var response = await HttpUtil.doGet(
        Constant.homePageUrl,
      );

      Map map = json.decode(response.toString());
      var issueEntity = IssueEntity.fromJson(map);
      nextPageUrl = issueEntity.nextPageUrl;

      var list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });
      bannerList.clear();
      bannerList.addAll(list);

      await _loadData(url: nextPageUrl);
      return itemList;
    } catch (e, s) {
      return null;
    }
  }

  /// 加载数据
  Future<List<Item>> _loadData({String url}) async {
    try {
      var response = await HttpUtil.doGet(url);

      Map map = json.decode(response.toString());
      var issueEntity = IssueEntity.fromJson(map);
      nextPageUrl = issueEntity.nextPageUrl;
      var list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });

      if (isRefresh) {
        itemList.clear();
        itemList.addAll(list);
        controller.resetLoadState();
        controller.finishRefresh();
      } else {
        itemList.addAll(list);
        controller.finishLoad();
      }

      return itemList;
    } catch (e, s) {
      if (isRefresh) {
        controller.resetLoadState();
        controller.finishRefresh(
          success: false,
        );
      } else {
        controller.finishLoad();
      }
      return null;
    }
  }

  /// 下拉刷新
  Future<List<Item>> onRefresh() async {
    isRefresh = true;
    return await _loadBanner();
  }

  /// 上拉加载
  Future<List<Item>> onLoadMore() async {
    isRefresh = false;
    return await _loadData(url: nextPageUrl);
  }
}
