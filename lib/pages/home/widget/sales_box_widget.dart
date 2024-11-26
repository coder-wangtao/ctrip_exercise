import 'package:ctrip_exercise/model/common_model.dart';
import 'package:ctrip_exercise/model/home_model.dart';
import 'package:flutter/material.dart';

class SalesBoxWidget extends StatelessWidget {
  late SalesBoxModel? salesBoxModel;

  SalesBoxWidget({super.key, this.salesBoxModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBoxModel == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBoxModel!.bigCard1, salesBoxModel!.bigCard2, true));
    items.add(_doubleItem(
        context, salesBoxModel!.smallCard1, salesBoxModel!.smallCard2, false));
    items.add(_doubleItem(
        context, salesBoxModel!.smallCard3, salesBoxModel!.smallCard4, false));
    return Column(
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salesBoxModel!.icon!,
                height: 15,
                width: 79,
              ),
              GestureDetector(
                onTap: () {
                  //todo
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffff4e63), Color(0xffff6cc9)]),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '获取更多福利 >',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4)),
        items[0],
        Padding(padding: EdgeInsets.only(top: 4)),
        items[1],
        Padding(padding: EdgeInsets.only(top: 4)),
        items[2],
      ],
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel? leftCard,
      CommonModel? rightCard, bool big) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCard, big, true),
        _item(context, leftCard, big, false)
      ],
    );
  }

  _item(BuildContext context, CommonModel? model, bool big, bool left) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        //todo
      },
      child: Container(
        height: big ? 130 : 82,
        margin: left ? EdgeInsets.only(right: 4) : EdgeInsets.zero,
        decoration: BoxDecoration(color: Colors.white),
        child: Image.network(
          model!.icon!,
          fit: BoxFit.fill,
        ),
      ),
    ));
  }
}
