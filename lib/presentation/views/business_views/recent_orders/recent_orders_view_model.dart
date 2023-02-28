import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/models.dart';

class RecentOrdersViewModel extends ChangeNotifier {
  final List<RecentOrdersModel> _recentOrders = [
    RecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: true,
    ),
    RecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: true,
    ),
    RecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    RecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
    RecentOrdersModel(
      customerName: 'customer name',
      shopName: 'Waroenk kita',
      price: 35,
      isCompleted: false,
    ),
  ];
  List<RecentOrdersModel> get recentOrders => [..._recentOrders];
}
