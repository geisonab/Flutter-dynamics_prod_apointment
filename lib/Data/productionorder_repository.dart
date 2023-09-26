import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dynamics_prod_apointment/models/productionorder_model.dart';

class ProductionOrderRepository {
  Future<List<ProductionOrderModel>> getProductionOrders() async {
    try {
      final http.Response response = await http.get(
        Uri.parse(
            "https://aspnetcore-backend-despesas.azurewebsites.net/v1/Despesas/BuscarTodos"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("OK: $response");
        return parseModel(response.body);
      } else {
        print("Error: $response");
        return List<ProductionOrderModel>.empty(growable: true);
      }
    } catch (e) {
      print("Error: $e");
      return List<ProductionOrderModel>.empty(growable: true);
    }
  }

  List<ProductionOrderModel> parseModel(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<ProductionOrderModel>(
            (json) => ProductionOrderModel.fromJson(json))
        .toList();
  }

  Future<void> addProductionOrder(ProductionOrderModel newTransaction) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(
            "https://aspnetcore-backend-despesas.azurewebsites.net/v1/Despesas/Cadastrar"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "idDespesa": 0,
          "titulo": newTransaction.title,
          "valor": newTransaction.value,
          "data": newTransaction.date.toIso8601String()
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("OK: $response");
      } else {
        print("Error: $response");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> removeProductionOrder(int id) async {
    ProductionOrderModel newTransaction = ProductionOrderModel(
      id: id,
      value: 0,
      date: DateTime.now(),
      title: '',
    );

    try {
      final http.Response response = await http.delete(
        Uri.parse(
            "https://aspnetcore-backend-despesas.azurewebsites.net/v1/Despesas/Excluir"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "idDespesa": newTransaction.id,
          "titulo": newTransaction.title,
          "valor": newTransaction.value,
          "data": newTransaction.date.toIso8601String(),
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("OK: $response");
      } else {
        print("Error: $response");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
