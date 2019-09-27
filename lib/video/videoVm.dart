


import 'dart:convert';

import 'package:flutter_eyevideo/entity/issue_entity.dart';
import 'package:flutter_eyevideo/http/http.dart';

import '../constant.dart';

class VideoViewModel{

  List<Item> itemList = [];

  int id;
  VideoViewModel(this.id){
    print("视频id ${id}");
  }



  Future loadVideoList() async {
    try {
      var response = await HttpUtil.doGet(
        Constant.videoRelatedUrl,
        queryParameters: {
          "id": this.id,
        },
      );
      Map map = json.decode(response.toString());
      var issue = Issue.fromJson(map);
      itemList = issue.itemList;
      print("获取相关视频成功");
    } catch (e, s) {
      print("获取相关视频失败"+e.toString());
      print(e);
    }
  }


}