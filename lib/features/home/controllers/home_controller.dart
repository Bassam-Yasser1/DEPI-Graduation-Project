// import 'package:depi_graduation_project/core/database/models/region_places.dart';
// import 'package:depi_graduation_project/core/database/models/region_requests.dart';
// import 'package:depi_graduation_project/core/services/api_services/geoapify_services.dart';
// import 'package:depi_graduation_project/models/place_model.dart';
// import 'package:depi_graduation_project/main.dart';
// import 'package:flutter/cupertino.dart' hide Page;
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
//
// import '../../../core/services/api_services/api_services1.1.dart';
//
// class HomeController extends GetxController {
//   final searchController = TextEditingController();
//   final selectedCard = 1.obs;
//   final position = Rxn<Position>();
//
//   final places = <PlaceModel>[].obs;
//   final museums = <PlaceModel>[].obs;
//   final restaurant = <PlaceModel>[].obs;
//   final keywords = [
//     "mosque",
//     "museum",
//     "park",
//     "temple",
//     "pyramid",
//     "fort",
//     "castle",
//     "citadel",
//     "historical",
//     "archaeological",
//     "landmark",
//     "tourist",
//   ];
//
//   final api = Get.find<ApiServices>();
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     loadAll();
//   }
//
//   void loadAll() async {
//     // position.value= await Location().getPosition();
//     final data = await api.getPlacesWithDetails(
//       lat: 29.979235,
//       long: 31.134202,
//     );
//     places.value =
//         data?.where((p) {
//           final title = p.title.toLowerCase();
//           final desc = p.description?.toLowerCase() ?? "";
//           return keywords.any((k) {
//             final key = k.toLowerCase();
//             return title.contains(key) || desc.contains(key);
//           });
//         }).toList() ??
//         [];
//
//     final regionId = await database.regionrequestdao.insertRegionRequest(
//       RegionRequest(lat: 29.979235, lng: 31.134202),
//     );
//
//     List<RegionPlace> list = [];
//     for (var element in data!) {
//       list.add(
//         RegionPlace(
//           region_id: regionId,
//           place_id: element.placeId.toString(),
//           lat: element.coordinates![0].lat,
//           lng: element.coordinates![0].lon,
//         ),
//       );
//     }
//     await database.regionplacedao.insertRespPlaces(list);
//   }
// }



import 'package:depi_graduation_project/core/database/models/region_places.dart';
import 'package:depi_graduation_project/core/database/models/region_requests.dart';
import 'package:depi_graduation_project/core/services/api_services/geoapify_services.dart';
import 'package:depi_graduation_project/models/place_model.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:flutter/cupertino.dart' hide Page;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services1.1.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final selectedCard = 1.obs;
  final position = Rxn<Position>();

  final places = <PlaceModel>[].obs;
  final museums = <PlaceModel>[].obs;
  final restaurant = <PlaceModel>[].obs;
  final keywords = [
    "mosque",
    "museum",
    "park",
    "temple",
    "pyramid",
    "fort",
    "castle",
    "citadel",
    "historical",
    "archaeological",
    "landmark",
    "tourist",
  ];

  final api = Get.find<ApiServices>();
  final geoapify = Get.find<GeoapifyService>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAll();
  }

  void loadAll() async {
    // position.value= await Location().getPosition();
    // final data = await api.getPlacesWithDetails(
    //   lat: 29.979235,
    //   long: 31.134202,
    // );

    final double lat = 29.979235;
    final double lon = 31.134202;

    // final results = await Future.wait([
    //   api.getPlacesWithDetails(lat: lat, long: lon),
    //   geoapify.getPlaces(lat: lat, lon: lon),]);
    final wikiFuture = api.getPlacesWithDetails(lat: lat, long: lon)
        .catchError((_) => []);
    final geoFuture = geoapify.getPlaces(lat: lat, lon: lon)
        .catchError((_) => []);

    final results = await Future.wait([wikiFuture, geoFuture]);


    final wikiPlaces = results[0] ?? [];
    final geoPlaces = results[1] ?? [];

    final merged = [...wikiPlaces,...geoPlaces];

    print('damn');
    print(merged);
    places.value =
        merged.where((p) {
          final title = p.title.toLowerCase();
          final desc = p.description?.toLowerCase() ?? "";
          return keywords.any((k) {
            final key = k.toLowerCase();
            return title.contains(key) || desc.contains(key);
          });
        }).toList() ??
        [];

    final regionId = await database.regionrequestdao.insertRegionRequest(
      RegionRequest(lat: 29.979235, lng: 31.134202),
    );

    List<RegionPlace> list = [];
    for (var element in merged) {
      list.add(
        RegionPlace(
          region_id: regionId,
          place_id: element.placeId.toString(),
          lat: element.coordinates![0].lat,
          lng: element.coordinates![0].lon,
        ),
      );
    }
    await database.regionplacedao.insertRespPlaces(list);
  }
}
