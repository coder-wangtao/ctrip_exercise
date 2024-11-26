import 'package:ctrip_exercise/model/common_model.dart';
import 'package:flutter/material.dart';

class SubNavWidget extends StatelessWidget {
  List<CommonModel>? subNavList;
  SubNavWidget({super.key, this.subNavList});

  @override
  build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList!.forEach((model) {
      items.add(_item(context, model));
    });
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(separate, subNavList!.length),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            //todo
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                model!.icon!,
                width: 28,
                height: 28,
              ),
              Text(
                model!.title!,
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ));
  }
}
