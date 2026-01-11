import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/Search_Results_Screen.dart';

class SearchBar1 extends StatefulWidget {
  const SearchBar1({super.key});

  @override
  State<SearchBar1> createState() => _SearchBar1State();
}

class _SearchBar1State extends State<SearchBar1> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Get.to(() => SearchResultsScreen(query: query));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onSubmitted: (_) => _performSearch(),
              decoration: const InputDecoration(
                hintText: "Song, Artist, Album, Genres, Etc",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          IconButton(
            onPressed: _performSearch,
            icon: const Icon(Icons.search, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
