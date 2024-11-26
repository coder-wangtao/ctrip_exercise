import 'package:ctrip_exercise/model/travel_model.dart';
import 'package:flutter/material.dart';

class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  const TravelItemWidget({super.key, required this.item});

  _itemImage(BuildContext context) {
    return Stack(
      children: [
        Image.network(item!.article!.images![0]!.dynamicUrl!),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                  maxWidth: MediaQuery.of(context).size.width / 2 - 66,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemImage(context),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article!.articleTitle!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  String _poiName() {
    return item.article!.pois == null || item.article!.pois!.length == 0
        ? "未知"
        : item.article?.pois![0]?.poiName ?? "未知";
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item!.article!.author!.coverImage!.dynamicUrl!,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 80,
                child: Text(
                  item.article!.author!.nickName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3, top: 2),
                child: Text(
                  item.article!.likeCount!.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
