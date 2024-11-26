import 'package:ctrip_exercise/pages/travel/widget/travel_item_widget.dart';
import 'package:ctrip_exercise/request/travel/travel_dao.dart';
import 'package:ctrip_exercise/widget/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/travel_model.dart';

const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  String? travelUrl;
  Map? params;
  String? groupChannelCode;
  TravelTabPage(
      {super.key, this.groupChannelCode, this.params, this.travelUrl});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  ScrollController _scrollController = ScrollController();
  late List<TravelItem> travelItems = [];
  bool _loading = true;
  bool _loadMore = false;
  int pageIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
            color: Colors.blue,
            onRefresh: _handleRefresh,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Column(
                  children: [
                    Expanded(
                        child: MasonryGridView.count(
                            controller: _scrollController,
                            crossAxisCount: 2,
                            itemCount: travelItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TravelItemWidget(item: travelItems[index]);
                            })),
                    _loadMoreIndicator(_loadMore)
                  ],
                ))),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    _loadData();
  }

  void _loadData({loadMore = false}) {
    if (loadMore) {
      setState(() {
        _loadMore = true;
      });
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    TravelDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.params ?? {},
            widget.groupChannelCode, pageIndex, PAGE_SIZE)
        .then((TravelItemModel model) async {
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems.length != 0) {
          travelItems.addAll(items);
          _loadMore = false;
        } else {
          travelItems = items;
        }
      });
      setState(() {
        _loading = false;
      });
    }).catchError((e) {
      setState(() {
        _loading = false;
      });
    });
  }

  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        //移除article为空的模型
        filterItems.add(item);
      }
    });
    return filterItems;
  }

  _loadMoreIndicator(bool loadMore) {
    return loadMore
        ? Padding(
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 24,
                ),
                Padding(padding: EdgeInsets.only(right: 5)),
                Text(
                  "加载中...",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                )
              ],
            ),
          )
        : Container();
  }
}
