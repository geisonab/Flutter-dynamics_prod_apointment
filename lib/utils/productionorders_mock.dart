import 'package:dynamics_prod_apointment/models/productionorder_model.dart';

class ProductionOrdersMock {
  static getProductionOrders() {
    return [
      ProductionOrderModel(
          id: "OP000001",
          title: "Nome do item",
          value: 200.50,
          date: DateTime.now().subtract(const Duration(days: 3))),
      ProductionOrderModel(
          id: "OP000002",
          title: "Nome do item2",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 4))),
      ProductionOrderModel(
          id: "antiga",
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: "antiga",
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: "antiga",
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: "antiga",
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: "antiga",
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: "antiga",
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: "antiga",
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
      ProductionOrderModel(
          id: "antiga",
          title: "antiga",
          value: 100,
          date: DateTime.now().subtract(const Duration(days: 33))),
    ];
  }
}
