import 'package:dynamics_prod_apointment/models/productionorder_model.dart';

class ProductionOrdersMock {
  static getProductionOrders() {
    return [
      ProductionOrderModel(
          id: 1,
          title: "Nome do item",
          value: 200.50,
          date: DateTime.now().subtract(const Duration(days: 3))),
      ProductionOrderModel(
          id: 2,
          title: "Nome do item2",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 4))),
      ProductionOrderModel(
          id: 3,
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: 4,
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: 5,
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: 6,
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: 7,
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: 8,
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: 9,
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: 10,
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
    ];
  }
}
