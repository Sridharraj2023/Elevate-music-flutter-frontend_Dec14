import 'dart:convert';
import 'package:elevate/Model/music_item.dart';
import '../utlis/api_constants.dart';
import 'package:http/http.dart' as http;

class BinauralController {
  Future<List<Category>> fetchBinauralCategory() async {
    final response =
        await http.get(Uri.parse('${ApiConstants.resolvedApiUrl}/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final binaural = data.firstWhere(
        (cat) => cat['name'] == 'Binaural',
        orElse: () => null,
      );

      if (binaural != null && binaural['types'] != null) {
        final typesList = binaural['types'] as List<dynamic>;
        return typesList
            .map((typeJson) => Category.fromJson(typeJson))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch binaural categories');
    }
  }

  // Fetch binaural music by category
  Future<List<MusicItem>> fetchBinauralMusic(String categoryId) async {
    final response = await http.get(
        Uri.parse('${ApiConstants.resolvedApiUrl}/music/category/$categoryId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => MusicItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch binaural music');
    }
  }

  // Fetch all binaural music
  Future<List<MusicItem>> fetchAllBinauralMusic() async {
    final response =
        await http.get(Uri.parse('${ApiConstants.resolvedApiUrl}/music'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Filter for binaural music only
      return data
          .where((json) => 
              json['category'] != null && 
              json['category']['name'] == 'Binaural')
          .map((json) => MusicItem.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch binaural music');
    }
  }
}
