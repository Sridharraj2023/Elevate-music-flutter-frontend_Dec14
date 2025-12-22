import 'package:elevate/Model/music_item.dart';
import '../Model/Song.dart';
import '../utlis/api_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MusicController {
  List<Song> getRecentlyPlayed() {
    return [
      Song(title: "Sail", artist: "Awolnation"),
      Song(title: "BOOM", artist: "X Ambassadors"),
      Song(title: "Hunger", artist: "TheFatRat"),
      Song(title: "Sacred Ri", artist: "Blackmill"),
    ];
  }

  List<String> getGenres() {
    return ["Rock", "EDM", "Pop", "Country"];
  }

  Future<List<Category>> fetchMusicCategory() async {
    final response =
        await http.get(Uri.parse('${ApiConstants.resolvedApiUrl}/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final musicCategory = data.firstWhere(
        (cat) => cat['name'] == 'Music',
        orElse: () => null,
      );

      if (musicCategory != null && musicCategory['types'] != null) {
        final typesList = musicCategory['types'] as List<dynamic>;
        return typesList
            .map((typeJson) => Category.fromJson(typeJson))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch music categories');
    }
  }

  // Fetch all music items
  Future<List<MusicItem>> fetchAllMusic() async {
    final response =
        await http.get(Uri.parse('${ApiConstants.resolvedApiUrl}/music'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => MusicItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch music');
    }
  }

  // Fetch music by category
  Future<List<MusicItem>> fetchMusicByCategory(int categoryId) async {
    final response = await http.get(
        Uri.parse('${ApiConstants.resolvedApiUrl}/music/category/$categoryId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => MusicItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch music by category');
    }
  }
}
