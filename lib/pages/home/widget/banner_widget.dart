import 'package:carousel_slider/carousel_slider.dart';
import 'package:ctrip_exercise/pages/home/widget/local_nav_widget.dart';
import 'package:flutter/material.dart';

import '../../../model/common_model.dart';

class BannerWidget extends StatefulWidget {
  final List<CommonModel>? bannerList;
  final List<CommonModel>? localNavList;

  const BannerWidget({super.key, this.bannerList, this.localNavList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      height: 262,
      child: Stack(
        children: [
          Container(
            child: CarouselSlider(
              carouselController: _controller,
              items: widget.bannerList!
                  .map((item) => _tabImage(item, width))
                  .toList(),
              options: CarouselOptions(
                  height: 210,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  onPageChanged: (index, _reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Positioned(bottom: 80, left: 0, right: 0, child: _indicator()),
          Positioned(
              top: 188,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(14, 0, 16, 0),
                child: LocalNavWidget(
                  localNavList: widget.localNavList,
                ),
              ))
        ],
      ),
    );
  }

  Widget _tabImage(CommonModel item, double width) {
    return GestureDetector(
      onTap: () {
        //TODO
      },
      child: Image.network(
        item.icon!,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.bannerList!.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () {
            _controller.animateToPage(entry.key);
          },
          child: Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  (Colors.white).withOpacity(_current == entry.key ? 0.9 : 0.4),
            ),
          ),
        );
      }).toList(),
    );
  }
}
