
import 'package:floor/floor.dart';

class CategoriesConverter extends TypeConverter<List<String>, String>{
  @override
  List<String> decode(String? databaseValue) {
    if (databaseValue == null || databaseValue.isEmpty) return [];
    return databaseValue.split(',');
  }

  @override
  String encode(List<String> value) {
    // TODO: implement encode
    return value.join(',');
  }
  
}