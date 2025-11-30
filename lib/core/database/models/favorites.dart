import 'package:floor/floor.dart';

@Entity(tableName: 'favorites')
class Favorite {
  @PrimaryKey(autoGenerate: true)
  final int? fav_id;
  final int? place_id;
  final int? added_at;

  final String user_id;
  final String name;
  final String? image;
  final String? desc;
  final String? category;

  final double? lat;
  final double? lng;

  Favorite({
    this.fav_id,
    this.place_id,
    this.added_at,
    required this.name,
    required this.user_id,
    this.desc,
    this.image,
    this.category,
    this.lat,
    this.lng,
  });
  // factory Favorite.fromJson(Map<String, dynamic> json) {
  //   return Favorite(
  //     fav_id: json['fav_id'],
  //     place_id: json['place_id'],
  //     added_at: json['added_at'],
  //     name: json['name'],
  //     user_id: json['user_id'],
  //     desc: json['desc'],
  //     image: json['image'],
  //     category: json['category'],
  //     lat: json['lat'] != null ? (json['lat'] as num).toDouble() : null,
  //     lng: json['lng'] != null ? (json['lng'] as num).toDouble() : null,
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'fav_id': fav_id,
  //     'place_id': place_id,
  //     'added_at': added_at,
  //     'name': name,
  //     'user_id': user_id,
  //     'desc': desc,
  //     'image': image,
  //     'category': category,
  //     'lat': lat,
  //     'lng': lng,
  //   };
  // }
}
