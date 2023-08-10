import 'dart:convert';
import 'package:food_app/model.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  //Publishing api keys to public repo is not good idea
  static const _appId = "5aa58b16";
  static const _appKey = "2d88cb812911ae9b8b5ce4f129ddfdf9";

  static Future<List<ReciepeModel>> getRecipes(String? query) async {
    query ??= "test"; //TODO Figure out how to get recipes without query
    final response = await http.get(Uri.https("api.edamam.com", "/search",
        {"q": query, "app_id": _appId, "app_key": _appKey}));
    final Map json = jsonDecode(response.body);
    List<ReciepeModel> result = [];
    for (var hit in json["hits"]) {
      result.add(ReciepeModel.fromMap(hit["recipe"]));
    }
    return result;
  }
}
