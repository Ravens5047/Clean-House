class ServicesModel {
  int? service_id;
  String? description;
  String? name_service;
  double? unit_price;
  String? created_at;
  int? created_by_id;
  String? updated_at;
  int? updated_by_id;
  String? image;
  int? category_id;

  ServicesModel({
    this.service_id,
    this.description,
    this.name_service,
    this.unit_price,
    this.created_at,
    this.created_by_id,
    this.updated_at,
    this.updated_by_id,
    this.image,
    this.category_id,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      service_id: json['service_id'] as int?,
      description: json['description'] as String?,
      name_service: json['name_service'] as String?,
      unit_price: json['unit_price'] != null
          ? double.tryParse(json['unit_price'].toString())
          : null,
      created_at: json['created_at'] as String?,
      created_by_id: json['created_by_id'] as int?,
      updated_at: json['updated_at'] as String?,
      updated_by_id: json['updated_by_id'] as int?,
      image: json['image'] as String?,
      category_id: json['category_id'] as int?,
    );
  }
}
