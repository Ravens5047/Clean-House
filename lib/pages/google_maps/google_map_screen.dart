// import 'dart:async';
// import 'dart:developer';
// import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
// import 'package:capstone2_clean_house/model/google_map_model.dart';
// import 'package:capstone2_clean_house/pages/booking_services/booking_services_Place.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({super.key});

//   @override
//   State<GoogleMapScreen> createState() => _GoogleMapScreenState();
// }

// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   // controller dieu khien

//   final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
//   // doi tuong geolocator de lay vi tri hien tai

//   TextEditingController searchController = TextEditingController();
//   List<GoogleMapModel> searchGoogleMapModel = [];
//   GoogleMapModel selectedShop = GoogleMapModel();
//   bool showCardShop = false;

//   // position current
//   Position? currentPosition;
//   Marker? currentMarker;
//   bool isCurrentPosition = false;
//   Set<Circle> circles = {};
//   Set<Marker> markersAdd = {};

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   void _createCicles() {
//     circles = {
//       Circle(
//         strokeColor: Colors.pink.withOpacity(0.14), // vien ben ngoai
//         strokeWidth: 2,
//         circleId: const CircleId('a'),
//         center: LatLng(
//           currentPosition!.latitude,
//           currentPosition!.longitude,
//         ),
//         radius: 2000,
//         fillColor: Colors.pink.withOpacity(0.12),
//       ),
//       Circle(
//         strokeColor: Colors.pink.withOpacity(0.14), // vien ben ngoai
//         strokeWidth: 2,
//         circleId: const CircleId('b'),
//         center: LatLng(
//           currentPosition?.latitude ?? 0.0,
//           currentPosition?.longitude ?? 0.0,
//         ),
//         radius: 1380,
//         fillColor: Colors.pink.withOpacity(0.10),
//       ),
//     };
//   }

//   void _search(String searchText) {
//     searchText = searchText.toLowerCase();
//     searchGoogleMapModel = coffeeShops
//         .where((e) => (e.name ?? '').toLowerCase().contains(searchText))
//         .toList();
//     showCardShop = false;
//     setState(() {});
//   }

//   Future<bool> _handlePermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     // su dung _geolocatorPlatform khai bao o tren de xin quyen
//     // Test if location services are enabled.
//     serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return false;
//     }

//     permission = await _geolocatorPlatform.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await _geolocatorPlatform.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return false;
//     }

//     return true;
//   }

//   void _getCurrentLocation() async {
//     final hasPermission = await _handlePermission();

//     if (!hasPermission) {
//       return;
//     }

//     try {
//       currentPosition = await _geolocatorPlatform.getCurrentPosition(
//         locationSettings:
//             const LocationSettings(accuracy: LocationAccuracy.high),
//       );
//       // khi da lay duoc currentPosition thi dua vao currentMarker
//       currentMarker = Marker(
//           zIndex: 9999.0,
//           markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
//           position: LatLng(
//             currentPosition!.latitude,
//             currentPosition!.longitude,
//           ),
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//           // infoWindow: const InfoWindow(title: "Hello World"),
//           onTap: () {
//             if (circles.length == 2) {
//               circles.removeWhere(
//                 (element) {
//                   return element.mapsId == const CircleId('a');
//                 },
//               );
//             } else {
//               _createCicles();
//             }
//             setState(() {});
//           });

//       _createCicles();

//       setState(() {});
//       onCamera();
//     } on TimeoutException catch (e) {
//       print('onError $e');
//     }
//   }

//   // camera move
//   void onCamera() async {
//     // tao doi tuong googleMapController, khoi tao camera va dua ve vi tri hien tai
//     final GoogleMapController controller = await _controller.future;

//     // await Future.delayed(const Duration(milliseconds: 2600));
//     // khoang thoi gian du de di chuyen camera

//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(
//             currentPosition?.latitude ?? 0.0,
//             currentPosition?.longitude ?? 0.0,
//           ),
//           zoom: 13.2,
//         ),
//       ),
//     );
//     // setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final outlineInputBorder = OutlineInputBorder(
//       borderSide: const BorderSide(color: Colors.orange),
//       borderRadius: BorderRadius.circular(16.0),
//     );

//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         showCardShop = false;
//         setState(() {});
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.orange, width: 1.2),
//               ),
//               child: GoogleMap(
//                 onMapCreated: (GoogleMapController controller) {
//                   _controller.complete(controller);
//                 },
//                 onCameraMove: (position) {
//                   // so sanh position cua google map tra ve
//                   // va position cua geolocator
//                   if ((position.target.latitude.toStringAsFixed(3) ==
//                           currentPosition!.latitude.toStringAsFixed(3)) &&
//                       (position.target.longitude.toStringAsFixed(3) ==
//                           currentPosition!.longitude.toStringAsFixed(3))) {
//                     isCurrentPosition = true;
//                   } else {
//                     isCurrentPosition = false;
//                   }
//                   setState(() {});
//                 },
//                 minMaxZoomPreference: const MinMaxZoomPreference(8.0, 16.0),
//                 myLocationEnabled: true,
//                 onTap: (p) {
//                   log('onTap ${p.latitude}, ${p.longitude}');

//                   markersAdd = {
//                     ...markersAdd,
//                     Marker(
//                         markerId: MarkerId(p.latitude.toString()),
//                         position: p,
//                         icon: BitmapDescriptor.defaultMarkerWithHue(
//                           BitmapDescriptor.hueYellow,
//                         ),
//                         onTap: () {
//                           markersAdd.removeWhere(
//                               (e) => e.mapsId == MarkerId('${p.latitude}'));
//                         })
//                   };
//                   setState(() {});
//                 },
//                 scrollGesturesEnabled: true, // di chuyen
//                 rotateGesturesEnabled: false, // xoay
//                 circles: circles,
//                 initialCameraPosition: CameraPosition(
//                   // target: LatLng(16.06774, 108.21386),
//                   target: LatLng(currentPosition?.latitude ?? 0.0,
//                       currentPosition?.longitude ?? 0.0),
//                   zoom: 13.2, // max = 16, 18
//                 ),
//                 markers: {
//                   if (currentMarker != null) currentMarker!,
//                   ...List.generate(
//                     coffeeShops.length,
//                     (index) => Marker(
//                       onTap: () {
//                         print('index $index');
//                         selectedShop.name = coffeeShops[index].name;
//                         selectedShop.address = coffeeShops[index].address;
//                         showCardShop = true;
//                         setState(() {});
//                       },
//                       zIndex: index.toDouble(),
//                       markerId: MarkerId(coffeeShops[index].id ?? ''),
//                       position: LatLng(
//                         coffeeShops[index].latitude ?? 0.0,
//                         coffeeShops[index].longitude ?? 0.0,
//                       ),
//                     ),
//                   ),
//                   ...markersAdd

//                   // const Marker(
//                   //   zIndex: 0,
//                   //   markerId: MarkerId('a'),
//                   //   position: LatLng(16.0998, 108.1645),
//                   // ),
//                   // const Marker(
//                   //   zIndex: 1,
//                   //   markerId: MarkerId('b'),
//                   //   position: LatLng(16.0992, 108.1646),
//                   // ),
//                 },
//               ),
//             ),
//             Positioned(
//               left: 8.0,
//               top: MediaQuery.of(context).padding.top + 8.0,
//               right: 8.0,
//               child: Visibility(
//                 visible: searchGoogleMapModel.isNotEmpty,
//                 child: Stack(
//                   children: [
//                     Container(
//                       constraints: const BoxConstraints(maxHeight: 236.0),
//                       margin: const EdgeInsets.only(bottom: 12.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: Colors.orange),
//                         borderRadius: const BorderRadius.only(
//                           bottomLeft: Radius.circular(16.0),
//                           bottomRight: Radius.circular(16.0),
//                         ),
//                       ),
//                       child: ListView.separated(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12.0, vertical: 12.0),
//                         shrinkWrap: true, // lay kich thuoc nho nhat
//                         itemCount: searchGoogleMapModel.length,
//                         itemBuilder: (context, index) {
//                           final coffeeShop = searchGoogleMapModel[index];
//                           return InkWell(
//                             highlightColor: Colors.transparent,
//                             splashColor: Colors.transparent,
//                             onTap: () async {
//                               final GoogleMapController controller =
//                                   await _controller.future;
//                               await controller.animateCamera(
//                                 CameraUpdate.newCameraPosition(
//                                   CameraPosition(
//                                     target: LatLng(
//                                       coffeeShop.latitude ?? 0.0,
//                                       coffeeShop.longitude ?? 0.0,
//                                     ),
//                                     zoom: 13.2,
//                                   ),
//                                 ),
//                               );
//                               selectedShop.name = coffeeShop.name;
//                               selectedShop.address = coffeeShop.address;
//                               showCardShop = true;
//                               setState(() {});
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(6.0),
//                               color: Colors.white,
//                               child: Row(
//                                 children: [
//                                   const CircleAvatar(
//                                     backgroundColor: Colors.orange,
//                                     radius: 2.6,
//                                   ),
//                                   const SizedBox(width: 10.0),
//                                   Expanded(
//                                     child: Text(
//                                       coffeeShop.name ?? '-:-',
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) => Container(
//                           margin: const EdgeInsets.symmetric(vertical: 8.0),
//                           height: 1.0,
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 0.0,
//                       right: 4.0,
//                       child: SizedBox.square(
//                         dimension: 36.0,
//                         child: IconButton(
//                           onPressed: () {
//                             searchGoogleMapModel.clear();
//                             searchController.clear();
//                             setState(() {});
//                             FocusScope.of(context).unfocus();
//                           },
//                           icon: const Icon(Icons.cancel_outlined,
//                               size: 28.0, color: Colors.red),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 16.0,
//               bottom: 36.0,
//               child: InkWell(
//                 onTap: () {
//                   _getCurrentLocation();
//                 },
//                 highlightColor: Colors.transparent,
//                 splashColor: Colors.transparent,
//                 child: Container(
//                   padding: const EdgeInsets.all(6.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.red, width: 1.6),
//                   ),
//                   child: isCurrentPosition
//                       ? Assets.icons.menuVector.svg(
//                           width: 28.0,
//                           // ignore: deprecated_member_use_from_same_package
//                           color: Colors.red,
//                         )
//                       : Assets.icons.menuVectorBorder.svg(
//                           width: 28.0,
//                           // ignore: deprecated_member_use_from_same_package
//                           color: Colors.red,
//                         ),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 76.0,
//               right: 16.0,
//               bottom: 16.0,
//               child: Visibility(
//                 visible: showCardShop,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const BookingServicesPlace(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.orange, width: 1.2),
//                       borderRadius: BorderRadius.circular(12.0),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black26,
//                           offset: Offset(0.0, 3.0),
//                           blurRadius: 6.0,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           selectedShop.name ?? '-:-',
//                           style: const TextStyle(
//                               color: Colors.red,
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         const Divider(
//                             height: 26.0, thickness: 1.2, color: Colors.orange),
//                         Text(
//                           selectedShop.address ?? '-:-',
//                           style: const TextStyle(
//                               color: Colors.brown, fontSize: 16.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
//               top: 20.0,
//               bottom: MediaQuery.of(context).viewInsets.bottom + 20.0),
//           color: Colors.pink[50],
//           child: Container(
//             // height: 52.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16.0),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   offset: Offset(0.0, 3.0),
//                   blurRadius: 6.0,
//                 ),
//               ],
//             ),
//             child: TextField(
//               controller: searchController,
//               onChanged: _search,
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 16.0, vertical: 12.0),
//                 filled: true,
//                 fillColor: const Color.fromRGBO(255, 255, 255, 1),
//                 border: outlineInputBorder,
//                 focusedBorder: outlineInputBorder,
//                 enabledBorder: outlineInputBorder,
//                 hintText: 'Search Coffee Shops',
//                 hintStyle: const TextStyle(color: Colors.grey),
//                 prefixIcon:
//                     const Icon(Icons.search, size: 30.0, color: Colors.orange),
//                 prefixIconConstraints: const BoxConstraints(minWidth: 46.0),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
