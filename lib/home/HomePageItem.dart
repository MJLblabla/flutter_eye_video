import 'package:flutter/material.dart';
import 'package:flutter_eyevideo/entity/issue_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyevideo/video/VideoDetailsPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePageItem extends StatelessWidget {
  final Item item;

  HomePageItem({Key key, this.item}) : super(key: key);

  String formatDuration(duration) {
    var minute = duration ~/ 60;
    var second = duration % 60;
    var str;
    if (minute <= 9) {
      if (second <= 9) {
        str = "0$minute:0$second";
      } else {
        str = "0$minute:$second";
      }
    } else {
      if (second <= 9) {
        str = "$minute:0$second";
      } else {
        str = "$minute:$second";
      }
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoDetailsPage(
                              item: this.item,
                            ),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: item.data.cover.feed,
                        errorWidget: (context, url, error) =>
                            Image.asset('images/img_load_fail.png'),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        // 外边距
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            item.data.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          // color: Color(0x4DFAEBD7),
                          gradient: LinearGradient(
                            colors: [Color(0x4DCD8C95), Color(0x4DF0FFFF)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.all(10.0), // 外边距

                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            formatDuration(item.data.duration),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: GestureDetector(
                        onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => AuthorDetailsPage(
//                            item: this.item,
//                          ),
//                        ),
//                      );
                        },
                        child: CachedNetworkImage(
                          imageUrl: item.data.author.icon,
                          width: 40,
                          height: 40,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                                strokeWidth: 2.5,
                                backgroundColor: Colors.deepPurple[600],
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.data.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 2, bottom: 2)),
                            Text(
                              item.data.author.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset('images/icon_share.png',
                          width: 25, height: 25),

                      /// TODO 从底部弹出分享框
                      onTap: () => Fluttertoast.showToast(
                        msg: '分享',
                        fontSize: 15,
                        textColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
