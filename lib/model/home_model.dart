import 'common_model.dart';

class HomeModel {
  ConfigModel? config;
  List<CommonModel>? bannerList;
  List<CommonModel>? localNavList;
  List<CommonModel>? subNavList;
  GridNavModel? gridNav;
  SalesBoxModel? salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.salesBox,
      this.gridNav});

  HomeModel.fromJson(Map<String, dynamic> json) {
    config = json['config'] != null
        ? new ConfigModel.fromJson(json['config'])
        : null;
    if (json['bannerList'] != null) {
      bannerList = [];
      json['bannerList'].forEach((v) {
        bannerList?.add(new CommonModel.fromJson(v));
      });
    }
    if (json['localNavList'] != null) {
      localNavList = [];
      json['localNavList'].forEach((v) {
        localNavList?.add(new CommonModel.fromJson(v));
      });
    }
    if (json['subNavList'] != null) {
      subNavList = [];
      json['subNavList'].forEach((v) {
        subNavList?.add(new CommonModel.fromJson(v));
      });
    }
    gridNav = json['gridNav'] != null
        ? new GridNavModel.fromJson(json['gridNav'])
        : null;

    salesBox = json['salesBox'] != null
        ? new SalesBoxModel.fromJson(json['salesBox'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config?.toJson();
    }
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList?.map((v) => v.toJson()).toList();
    }
    if (this.localNavList != null) {
      data['localNavList'] = this.localNavList?.map((v) => v.toJson()).toList();
    }
    if (this.gridNav != null) {
      data['gridNav'] = this.gridNav?.toJson();
    }
    if (this.subNavList != null) {
      data['subNavList'] = this.subNavList?.map((v) => v.toJson()).toList();
    }
    if (this.salesBox != null) {
      data['salesBox'] = this.salesBox?.toJson();
    }
    return data;
  }
}

class ConfigModel {
  String? searchUrl;

  ConfigModel({this.searchUrl});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    searchUrl = json['searchUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchUrl'] = this.searchUrl;
    return data;
  }
}

class GridNavModel {
  GridNavItem? hotel;
  GridNavItem? flight;
  GridNavItem? travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  GridNavModel.fromJson(Map<String, dynamic> json) {
    hotel =
        json['hotel'] != null ? new GridNavItem.fromJson(json['hotel']) : null;
    flight = json['flight'] != null
        ? new GridNavItem.fromJson(json['flight'])
        : null;
    travel = json['travel'] != null
        ? new GridNavItem.fromJson(json['travel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotel != null) {
      data['hotel'] = this.hotel?.toJson();
    }
    if (this.flight != null) {
      data['flight'] = this.flight?.toJson();
    }
    if (this.travel != null) {
      data['travel'] = this.travel?.toJson();
    }
    return data;
  }
}

class GridNavItem {
  String? startColor;
  String? endColor;
  CommonModel? mainItem;
  CommonModel? item1;
  CommonModel? item2;
  CommonModel? item3;
  CommonModel? item4;

  GridNavItem(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});

  GridNavItem.fromJson(Map<String, dynamic> json) {
    startColor = json['startColor'];
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null
        ? new CommonModel.fromJson(json['mainItem'])
        : null;
    item1 =
        json['item1'] != null ? new CommonModel.fromJson(json['item1']) : null;
    item2 =
        json['item2'] != null ? new CommonModel.fromJson(json['item2']) : null;
    item3 =
        json['item3'] != null ? new CommonModel.fromJson(json['item3']) : null;
    item4 =
        json['item4'] != null ? new CommonModel.fromJson(json['item4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    if (this.mainItem != null) {
      data['mainItem'] = this.mainItem?.toJson();
    }
    if (this.item1 != null) {
      data['item1'] = this.item1?.toJson();
    }
    if (this.item2 != null) {
      data['item2'] = this.item2?.toJson();
    }
    if (this.item3 != null) {
      data['item3'] = this.item3?.toJson();
    }
    if (this.item4 != null) {
      data['item4'] = this.item4?.toJson();
    }
    return data;
  }
}

class SalesBoxModel {
  String? icon;
  String? moreUrl;
  CommonModel? bigCard1;
  CommonModel? bigCard2;
  CommonModel? smallCard1;
  CommonModel? smallCard2;
  CommonModel? smallCard3;
  CommonModel? smallCard4;

  SalesBoxModel(
      {this.icon,
      this.moreUrl,
      this.bigCard1,
      this.bigCard2,
      this.smallCard1,
      this.smallCard2,
      this.smallCard3,
      this.smallCard4});

  SalesBoxModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    moreUrl = json['moreUrl'];
    bigCard1 = json['bigCard1'] != null
        ? new CommonModel.fromJson(json['bigCard1'])
        : null;
    bigCard2 = json['bigCard2'] != null
        ? new CommonModel.fromJson(json['bigCard2'])
        : null;
    smallCard1 = json['smallCard1'] != null
        ? new CommonModel.fromJson(json['smallCard1'])
        : null;
    smallCard2 = json['smallCard2'] != null
        ? new CommonModel.fromJson(json['smallCard2'])
        : null;
    smallCard3 = json['smallCard3'] != null
        ? new CommonModel.fromJson(json['smallCard3'])
        : null;
    smallCard4 = json['smallCard4'] != null
        ? new CommonModel.fromJson(json['smallCard4'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['moreUrl'] = this.moreUrl;
    if (this.bigCard1 != null) {
      data['bigCard1'] = this.bigCard1?.toJson();
    }
    if (this.bigCard2 != null) {
      data['bigCard2'] = this.bigCard2?.toJson();
    }
    if (this.smallCard1 != null) {
      data['smallCard1'] = this.smallCard1?.toJson();
    }
    if (this.smallCard2 != null) {
      data['smallCard2'] = this.smallCard2?.toJson();
    }
    if (this.smallCard3 != null) {
      data['smallCard3'] = this.smallCard3?.toJson();
    }
    if (this.smallCard4 != null) {
      data['smallCard4'] = this.smallCard4?.toJson();
    }
    return data;
  }
}
