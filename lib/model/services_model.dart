import 'package:flutter/material.dart';

class ServicesModel {
  String? servicesid;
  String? description;
  String? nameservices;
  String? unitprice;
  String? createdAt;
  String? createdbyid;
  String? updatedAt;
  String? updatebyid;
  Image? image;
  String? categoryid;
  int? v;

  ServicesModel({
    this.servicesid,
    this.description,
    this.nameservices,
    this.unitprice,
    this.createdAt,
    this.createdbyid,
    this.updatedAt,
    this.updatebyid,
    this.image,
    this.categoryid,
    this.v,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      servicesid: json['servicesid'] as String?,
      description: json['description'] as String?,
      nameservices: json['nameservices'] as String?,
      unitprice: json['unitprice'] as String?,
      createdAt: json['createdAt'] as String?,
      createdbyid: json['createbyid'] as String?,
      updatedAt: json['updatedAt'] as String?,
      updatebyid: json['updatebyid'] as String?,
      categoryid: json['categoryid'] as String?,
      v: json['__v'] as int?,
    );
  }
}
