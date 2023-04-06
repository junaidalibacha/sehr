class ordersModel {
  List<Orders>? orders;
  int? total;

  ordersModel({this.orders, this.total});

  ordersModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class Orders {
  int? id;
  String? date;
  String? amount;
  String? status;
  String? comments;
  String? commission;

  Orders(
      {this.id,
      this.date,
      this.amount,
      this.status,
      this.comments,
      this.commission});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    amount = json['amount'];
    status = json['status'];
    comments = json['comments'];
    commission = json['commission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['amount'] = amount;
    data['status'] = status;
    data['comments'] = comments;
    data['commission'] = commission;
    return data;
  }
}
