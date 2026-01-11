import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/BottomBar_Controller.dart';
import '../../Controller/Home_Controller.dart';
import '../../Model/music_item.dart';
import '../../utlis/api_constants.dart';
import '../Widgets/Gradient_Container.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final HomeController _homeController = HomeController();
  final BottomBarController bottomBarController = Get.find<BottomBarController>();
  List<MusicItem> _searchResults = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _performSearch();
  }

  Future<void> _performSearch() async {
    setState(() => _isLoading = true);

    try {
      final musicItems = await _homeController.fetchMusic();
      final binauralItems = await _homeController.fetchBinauralMusic();
      final allItems = [...musicItems, ...binauralItems];

      final query = widget.query.toLowerCase();
      _searchResults = allItems.where((item) {
        return item.title.toLowerCase().contains(query) ||
            item.artist.toLowerCase().contains(query) ||
            item.category.name.toLowerCase().contains(query) ||
            item.categoryType.name.toLowerCase().contains(query);
      }).toList();
    } catch (e) {
      print('Search error: $e');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                    Expanded(
                      child: Text(
                        'Search: "${widget.query}"',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : _searchResults.isEmpty
                        ? Center(
                            child: Text(
                              'No results found for "${widget.query}"',
                              style: const TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 136),
                            itemCount: _searchResults.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final item = _searchResults[index];
                              final isBinaural = item.category.name == 'Binaural';

                              return GestureDetector(
                                onTap: () {
                                  if (isBinaural) {
                                    bottomBarController.isBinauralPlaying.value = true;
                                    bottomBarController.playBinaural(item.fileUrl);
                                  } else {
                                    bottomBarController.isMusicPlaying.value = true;
                                    bottomBarController.playMusic(item.fileUrl);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomLeft: Radius.circular(16),
                                        ),
                                        child: item.imageUrl.isNotEmpty
                                            ? Image.network(
                                                '${ApiConstants.baseUrl}${item.imageUrl}',
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) =>
                                                    Container(
                                                  width: 80,
                                                  height: 80,
                                                  color: Colors.white.withOpacity(0.1),
                                                  child: const Icon(Icons.music_note,
                                                      color: Colors.white, size: 40),
                                                ),
                                              )
                                            : Container(
                                                width: 80,
                                                height: 80,
                                                color: Colors.white.withOpacity(0.1),
                                                child: const Icon(Icons.music_note,
                                                    color: Colors.white, size: 40),
                                              ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.title,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item.artist,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                '${item.category.name} • ${item.categoryType.name}',
                                                style: const TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.play_circle_fill,
                                          size: 36, color: Colors.white70),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
