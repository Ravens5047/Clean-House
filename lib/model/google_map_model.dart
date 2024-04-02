import 'package:capstone2_clean_house/utils/util.dart';

class GoogleMapModel {
  String? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
}

List<GoogleMapModel> coffeeShops = [
  GoogleMapModel()
    ..id = Util.getID()
    ..name = 'Nhà Hưng'
    ..address = '162/5 Đống Đa, Phường Thuận Phước, Quận Hải Châu, Đà Nẵng'
    ..latitude = 16.079773
    ..longitude = 108.217708,
  GoogleMapModel()
    ..id = Util.getID()
    ..name = 'M Cafe'
    ..address = '306 Đống Đa, Thanh Bình, Hải Châu, Đà Nẵng'
    ..latitude = 16.07558
    ..longitude = 108.21509,
];
