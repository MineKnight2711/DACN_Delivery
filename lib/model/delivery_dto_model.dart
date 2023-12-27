import 'package:dat_delivery/model/account_model.dart';
import 'package:dat_delivery/model/voucher_model.dart';

class DeliveryDTO {
  Delivery? delivery;
  DeliveryDetailsDTO? details;
  DeliveryDTO({
    this.delivery,
    this.details,
  });
  factory DeliveryDTO.fromJson(Map<String, dynamic> json) {
    return DeliveryDTO(
      delivery:
          json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null,
      details: json['details'] != null
          ? DeliveryDetailsDTO.fromJson(json['details'])
          : null,
    );
  }
}

class OrderModel {
  String? orderID;
  String? status;
  String? deliveryInfo;
  int? quantity;
  double? score;
  String? feedBack;
  DateTime? dateFeedBack;
  VoucherModel? voucher;
  AccountModel? account;
  DateTime? orderDate;

  OrderModel({
    this.orderID,
    this.status,
    this.deliveryInfo,
    this.quantity,
    this.score,
    this.feedBack,
    this.dateFeedBack,
    this.voucher,
    this.account,
    this.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderID: json['orderID'],
      status: json['status'],
      deliveryInfo: json['deliveryInfo'],
      quantity: json['quantity'],
      score: json['score'],
      feedBack: json['feedBack'],
      dateFeedBack: json['dateFeedBack'] != null
          ? DateTime.parse(json['dateFeedBack'])
          : null,
      voucher: json['voucher'] != null
          ? VoucherModel.fromJson(json['voucher'])
          : null,
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
      orderDate:
          json['orderDate'] != null ? DateTime.parse(json['orderDate']) : null,
    );
  }
}

class Delivery {
  String? deliveryId;
  DateTime? dateAccepted;
  DateTime? dateDelivered;
  AccountModel? account;
  Delivery({
    this.deliveryId,
    this.dateAccepted,
    this.dateDelivered,
    this.account,
  });
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      deliveryId: json['deliveryId'],
      dateAccepted: json['dateAccepted'] != null
          ? DateTime.parse(json['dateAccepted'])
          : null,
      dateDelivered: json['dateDelivered'] != null
          ? DateTime.parse(json['dateDelivered'])
          : null,
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
    );
  }
}

class DeliveryDetailsDTO {
  OrderModel? order;
  DeliveryDetailsDTO({
    this.order,
  });
  factory DeliveryDetailsDTO.fromJson(Map<String, dynamic> json) {
    return DeliveryDetailsDTO(
      order: json['order'] != null ? OrderModel.fromJson(json['order']) : null,
    );
  }
}
