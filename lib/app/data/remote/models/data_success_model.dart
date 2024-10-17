class ResponseModel {
  int? count;
  String? next;
  String? previous;
  List<OrderData>? data;

  ResponseModel({this.count, this.next, this.previous, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['count'] = count;
    dataMap['next'] = next;
    dataMap['previous'] = previous;
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class OrderData {
  OrderHeader? orderHeader;
  List<Result>? results;

  OrderData({this.orderHeader, this.results});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderHeader = json['order_header'] != null
        ? OrderHeader.fromJson(json['order_header'])
        : null;
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderHeader != null) {
      data['order_header'] = orderHeader!.toJson();
    }
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  Item? item;
  int? quantity;
  int? orderHeader;

  Result({this.id, this.item, this.quantity, this.orderHeader});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    quantity = json['quantity'];
    orderHeader = json['order_header'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    data['quantity'] = quantity;
    data['order_header'] = orderHeader;
    return data;
  }
}

class Item {
  int? id;
  PickArea? pickArea;
  String? itemNumber;
  String? itemDescription;
  String? uom;
  String? smallText;

  Item(
      {this.id,
        this.pickArea,
        this.itemNumber,
        this.itemDescription,
        this.uom,
        this.smallText});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickArea = json['pick_area'] != null
        ? PickArea.fromJson(json['pick_area'])
        : null;
    itemNumber = json['item_number'];
    itemDescription = json['item_description'];
    uom = json['uom'];
    smallText = json['small_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (pickArea != null) {
      data['pick_area'] = pickArea!.toJson();
    }
    data['item_number'] = itemNumber;
    data['item_description'] = itemDescription;
    data['uom'] = uom;
    data['small_text'] = smallText;
    return data;
  }
}

class OrderHeader {
  int? id;
  String? planDate;
  String? orderNumber;

  OrderHeader({this.id, this.planDate, this.orderNumber});

  OrderHeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planDate = json['plan_date'];
    orderNumber = json['order_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan_date'] = planDate;
    data['order_number'] = orderNumber;
    return data;
  }
}

class PickArea {
  int? id;
  String? pickAreaNumber;
  String? pickAreaName;

  PickArea({this.id, this.pickAreaNumber, this.pickAreaName});

  PickArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickAreaNumber = json['pick_area_number'];
    pickAreaName = json['pick_area_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pick_area_number'] = pickAreaNumber;
    data['pick_area_name'] = pickAreaName;
    return data;
  }
}
