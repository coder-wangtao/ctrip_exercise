class DestinationSearchModel {
  ResponseStatus? responseStatus;
  List<DestinationSearchItem>? modules;
  String? keyword;

  DestinationSearchModel({this.responseStatus, this.modules, this.keyword});

  DestinationSearchModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['ResponseStatus'] != null
        ? new ResponseStatus.fromJson(json['ResponseStatus'])
        : null;
    if (json['modules'] != null) {
      modules = [];
      json['modules'].forEach((v) {
        modules?.add(new DestinationSearchItem.fromJson(v));
      });
      keyword = json['keyword'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseStatus != null) {
      data['ResponseStatus'] = this.responseStatus?.toJson();
    }
    if (this.modules != null) {
      data['modules'] = this.modules?.map((v) => v?.toJson()).toList();
    }
    data['keyword'] = this.keyword;

    return data;
  }
}

class ResponseStatus {
  String? timestamp;
  String? ack;
  List<Extension>? extension;

  ResponseStatus({this.timestamp, this.ack, this.extension});

  ResponseStatus.fromJson(Map<String, dynamic> json) {
    timestamp = json['Timestamp'];
    ack = json['Ack'];
    if (json['Extension'] != null) {
      extension = [];
      json['Extension'].forEach((v) {
        extension?.add(new Extension.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Timestamp'] = this.timestamp;
    data['Ack'] = this.ack;
    if (this.extension != null) {
      data['Extension'] = this.extension?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Extension {
  String? id;
  String? value;

  Extension({this.id, this.value});

  Extension.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Value'] = this.value;
    return data;
  }
}

class DestinationSearchItem {
  int? id;
  String? name;
  int? style;
  List<Items>? items;
  String? title;

  DestinationSearchItem(
      {this.id, this.name, this.style, this.items, this.title});

  DestinationSearchItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    style = json['style'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(new Items.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['style'] = this.style;
    if (this.items != null) {
      data['items'] = this.items?.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }
}

class Items {
  int? id;
  String? type;
  String? name;
  String? displayName;
  String? upperName;
  List<Infos>? infos;
  Url? url;

  Items(
      {this.id,
      this.type,
      this.name,
      this.displayName,
      this.upperName,
      this.infos,
      this.url});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    displayName = json['displayName'];
    upperName = json['upperName'];
    if (json['infos'] != null) {
      infos = [];
      json['infos'].forEach((v) {
        infos?.add(new Infos.fromJson(v));
      });
    }
    url = json['url'] != null ? new Url.fromJson(json['url']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['upperName'] = this.upperName;
    if (this.infos != null) {
      data['infos'] = this.infos?.map((v) => v.toJson()).toList();
    }
    if (this.url != null) {
      data['url'] = this.url?.toJson();
    }
    return data;
  }
}

class Infos {
  String? key;
  String? value;

  Infos({this.key, this.value});

  Infos.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Url {
  String? app;
  String? h5;
  String? online;

  Url({this.app, this.h5, this.online});

  Url.fromJson(Map<String, dynamic> json) {
    app = json['app'];
    h5 = json['h5'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app'] = this.app;
    data['h5'] = this.h5;
    data['online'] = this.online;
    return data;
  }
}
