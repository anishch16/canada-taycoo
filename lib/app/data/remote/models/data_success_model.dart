class ResponseModel {
  String? success;
  String? message;
  Data? data;

  ResponseModel({this.success, this.message, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> responseData = <String, dynamic>{};
    responseData['success'] = success;
    responseData['message'] = message;
    if (data != null) {
      responseData['data'] = data!.toJson();
    }
    return responseData;
  }
}

class Data {
  String? orderId;
  String? planeDate;
  List<Item>? items;

  Data({this.orderId, this.planeDate, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    planeDate = json['plane_date'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['plane_date'] = planeDate;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? itemId;
  String? quantity;
  String? itemDescription;
  String? uom;
  String? smallText;
  PickArea? pickArea;

  Item(
      {this.itemId,
        this.quantity,
        this.itemDescription,
        this.uom,
        this.smallText,
        this.pickArea});

  Item.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    quantity = json['quantity'];
    itemDescription = json['item_description'];
    uom = json['uom'];
    smallText = json['small_text'];
    pickArea = json['pick_area'] != null
        ? PickArea.fromJson(json['pick_area'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['quantity'] = quantity;
    data['item_description'] = itemDescription;
    data['uom'] = uom;
    data['small_text'] = smallText;
    if (pickArea != null) {
      data['pick_area'] = pickArea!.toJson();
    }
    return data;
  }
}

class PickArea {
  String? pickAreaNo;
  String? pickAreaName;

  PickArea({this.pickAreaNo, this.pickAreaName});

  PickArea.fromJson(Map<String, dynamic> json) {
    pickAreaNo = json['pick_area_no'];
    pickAreaName = json['pick_area_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pick_area_no'] = pickAreaNo;
    data['pick_area_name'] = pickAreaName;
    return data;
  }
}
