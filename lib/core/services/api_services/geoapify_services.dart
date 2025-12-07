import 'package:depi_graduation_project/models/place_model.dart';
import 'package:dio/dio.dart';
import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/functions/has_internet.dart';

class GeoapifyService {
  final dio = Dio();
  final String baseUrl = "https://api.geoapify.com/v2/places";

  final String apiKey = "29d9a542ed1f4de1994142b6ca3675dc";

  Future<List<PlaceModel>?> getPlaces({
    required double lat,
    required double lon,
    int radius = 5000,
  }) async {
    if (await hasInternet()) {
      final response = await Dio().get(
        baseUrl,
        queryParameters: {
          "categories": "airport,commercial.shopping_mall,commercial.gift_and_souvenir"
              ",catering,,accommodation.hotel,national_park,entertainment,sport,beach,religion,natural",
          "filter": "circle:$lon,$lat,$radius",
          "limit": "20",
          "apiKey": apiKey,
        },
      );


      if (response.statusCode == 200 &&
          response.data['features'] != null) {
        final features = response.data['features'] as List;

        return features
            .map((f) => PlaceModel.fromJson(f))
            .toList();
      }
      return null;
    } else {
      throw AppException(msg: "Check your internet connection");
    }
  }
}
