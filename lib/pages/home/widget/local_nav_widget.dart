import 'package:flutter/material.dart';

import '../../../model/common_model.dart';

class LocalNavWidget extends StatelessWidget {
  final List<CommonModel>? localNavList;
  const LocalNavWidget({super.key, this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12.0)]),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList!.forEach((model) {
      items.add(_item(context, model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        //tood
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            model.icon!,
            width: 40,
            height: 40,
          ),
          Text(
            model.title!,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
