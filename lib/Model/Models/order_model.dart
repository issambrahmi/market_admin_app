import 'package:intl/intl.dart';
import 'package:market_admin_app/Model/Models/product_model.dart';

class OrderModel {
  final int? id;
  final String clientName;
   String? workerName;
  final String date;
  final double totalePrice;
  final String status;
  final List<OrderItem> orderItems;

  OrderModel({
    this.id,
    required this.clientName,
    required this.workerName,
    required this.date,
    required this.totalePrice,
    required this.status,
    required this.orderItems,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    String date =
        DateFormat('MMM d, h.mm a').format(DateTime.parse(data['date']));

    return OrderModel(
      id: data['id'],
      clientName: data['client_name'],
      workerName: data['worker_name'],
      date: date,
      orderItems: [],
      totalePrice: (data['total_price'] as num).toDouble(),
      status: data['status'],
    );
  }
}

class OrderItem {
  final int? id;
  final int orderId;
  final ProductModel product;
  final String type;
  final int qnt;

  OrderItem({
    this.id,
    required this.orderId,
    required this.product,
    required this.type,
    required this.qnt,
  });

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      id: data['id'],
      orderId: data['order_id'],
      product: data['product'],
      type: data['type'],
      qnt: data['qnt'],
    );
  }
}
