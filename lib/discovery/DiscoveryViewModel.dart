import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_eyevideo/entity/category_entity.dart';
import 'package:flutter_eyevideo/entity/issue_entity.dart';
import 'package:flutter_eyevideo/http/http.dart';

import '../constant.dart';

class DiscoveryViewModel {
  List<CategoryEntity> categoryList = [];
  List<Item> followItemList = [];
  String _nextFollowUrl;

  Future<List<CategoryEntity>> loadCategoryList() async {
    try {
      var response = await HttpUtil.doGet(Constant.categoryUrl,
          options: Options(
            headers: httpHeaders,
            responseType: ResponseType.plain,
          ));
      List<dynamic> list = json.decode(response.toString());
      List<CategoryEntity> memberList =
          list.map((value) => CategoryEntity.fromJson(value)).toList();
      print("获取　_loadCategoryList　");
      this.categoryList = memberList;
    } catch (e) {
      print("获取　_loadCategoryList　失败" + e.toString());
    }
    return categoryList;
  }

  Future<List<Item>> loadFollowItemList() async {
    try {
      var response = await HttpUtil.doGet(_nextFollowUrl ?? Constant.followUrl);
      var map = json.decode(response.toString());
      var followEntity = Issue.fromJson(map);
      _nextFollowUrl = followEntity.nextPageUrl;
      followItemList = followEntity.itemList;
      print("获取　loadFollowItemList　成功");
    } catch (e) {
      print("获取　loadFollowItemList　失败" + e.toString());
    }
    return followItemList;
  }
}
