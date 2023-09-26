class ProductionOrderModel {
  late final int id;
  late final String title;
  late final double value;
  late final DateTime date;

  ProductionOrderModel({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  ProductionOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['idDespesa'];
    title = json['titulo'];
    value = json['valor'];
    date = json['data'] == null ? DateTime.now() : DateTime.parse(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDespesa'] = this.id;
    data['titulo'] = this.title;
    data['valor'] = this.value;
    data['data'] = this.date;
    return data;
  }
}
