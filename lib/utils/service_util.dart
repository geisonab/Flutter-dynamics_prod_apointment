class ServiceUtil {
  //https://zanini-sandbox2.sandbox.operations.dynamics.com/api/services/INOWorkOrderServiceGroup/INOWorkOrderService/startOperation
  static const String oAuthHeader = "Authorization";

  static String getServiceURI(String d365FOURI, String servicePath) {
    return "$d365FOURI$servicePath";
  }
}
