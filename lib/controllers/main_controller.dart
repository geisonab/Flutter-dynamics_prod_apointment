import 'package:dynamics_prod_apointment/utils/token_oauth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/service_util.dart';

class MainController {
  //static String sessionUrl = "/data/ReleasedProductsV2";
  static String sessionUrl =
      "/api/services/DynamicsProdApointment/DynamicsProdApointmentWorkOrderService/GetWorkOrder";
  static String environmetUri =
      "https://zanini-dev-gsn2c5fc7c06dcd9bcddevaos.axcloud.dynamics.com";

  String productionOrder = "";
  double qty = 0.0;

  Future<void> send() async {
    var tokenModel = await TokenOAuth.instance.getToken();
    String token = tokenModel.token;
    String fullUri = ServiceUtil.getServiceURI(environmetUri, sessionUrl);

    // body data
    Map mapdata = {'_order': productionOrder, '_qty': qty};
    // encode Map to JSON
    var body = json.encode(mapdata);

    var response = await http.post(Uri.parse(fullUri),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);

    var data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);

      if (kDebugMode) {
        print(data.toString());
      }
    }
  }
}
