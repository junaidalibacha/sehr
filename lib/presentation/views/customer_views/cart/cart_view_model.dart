import 'package:sehr/app/index.dart';
import 'package:sehr/domain/models/models.dart';

class CompleteOrdersViewModel extends ChangeNotifier {
  final List<CompleteOrdersModel> _orders = [
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
    CompleteOrdersModel(
      itemName: 'Spacy fresh crab',
      shopName: 'Waroenk kita',
      price: 35,
    ),
  ];

  List<CompleteOrdersModel> get orders => [..._orders];
}
