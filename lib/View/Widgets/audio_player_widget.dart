import 'dart:developer';

import 'package:elevate/Model/music_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/BottomBar_Controller.dart';
import '../../utils/responsive_helper.dart';
import 'full_audio_player.dart';

class AudioPlayerWidget extends StatefulWidget {
  final List<MusicItem> musicList;
  final List<MusicItem> binauralList;

  const AudioPlayerWidget(
      {super.key, required this.musicList, required this.binauralList});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final BottomBarController bottomBarController =
      Get.put(BottomBarController());

  @override
  void initState() {
    super.initState();
    bottomBarController.setAllMusic(widget.musicList);
    bottomBarController.setAllBinaural(widget.binauralList);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Only show player when actively playing
      final isPlaying = bottomBarController.isBinauralPlaying.value ||
          bottomBarController.isMusicPlaying.value;

      if (!isPlaying) {
        return const SizedBox.shrink();
      }

      final bool showMusic = bottomBarController.isMusicSelected.value;
      // Deeper, richer purple for binaural, vibrant blue for music
      final Color activeBg = showMusic
          ? const Color(0xFF1E3A8A) // Deep blue
          : const Color(0xFF4C1D95); // Deep rich purple

      const double _cardHeight = 146; // Increased to accommodate all content

      return GestureDetector(
        onTap: () {
          // Open full player based on which is currently selected
          if (showMusic && bottomBarController.musicTrack.value.isNotEmpty) {
            Get.to(() => FullAudioPlayerScreen(
                  isBinaural: false,
                  track: bottomBarController.musicTrack.value,
                ));
          } else if (!showMusic && bottomBarController.binauralTrack.value.isNotEmpty) {
            Get.to(() => FullAudioPlayerScreen(
                  isBinaural: true,
                  track: bottomBarController.binauralTrack.value,
                ));
          }
        },
        child: Container(
        height: _cardHeight,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: activeBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Horizontal toggle switch at the top
                  Container(
                height: 32,
                decoration: BoxDecoration(
                  color: showMusic
                      ? const Color(0xFF1E40AF).withOpacity(0.4) // Darker blue with transparency
                      : const Color(0xFF5B21B6).withOpacity(0.4), // Darker muted purple with transparency
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: bottomBarController.selectBinaural,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: !showMusic
                              ? Colors.white.withOpacity(0.35)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'BINAURAL',
                          style: TextStyle(
                            color: !showMusic ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: bottomBarController.selectMusic,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: showMusic
                              ? Colors.white.withOpacity(0.35)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'MUSIC',
                          style: TextStyle(
                            color: showMusic ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Player content based on selection
              Expanded(
                child: showMusic
                    ? _buildMusicPlayer()
                    : _buildBinauralPlayer(),
              ),
                ],
              ),
              // Close button in top right corner - closes both players
              Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  onTap: () {
                    bottomBarController.stopMusic();
                    bottomBarController.stopBinaural();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white70,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      );
    });
  }

  Widget _buildMusicPlayer() {
    final controller = bottomBarController;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Track info
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.25), // Lighter blue shade
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Music',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade300,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Obx(() {
                        if (controller.musicPlaylists.isEmpty) {
                          return const Text(
                            'No tracks',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 9,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          );
                        }
                        final index = controller.currentMusicIndex.value <
                                controller.musicPlaylists.length
                            ? controller.currentMusicIndex.value
                            : 0;
                        final currentTrack = controller.musicPlaylists[index];
                        return Text(
                          currentTrack.title,
                          style: TextStyle(
                            color: controller.isMusicPlaying.value
                                ? Colors.white
                                : Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          // Progress bar row
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (controller.musicPlaylists.isEmpty) return;
                  if (controller.isMusicPlaying.value) {
                    controller.toggleMusicPlayback();
                  } else if (controller.musicTrack.value.isNotEmpty) {
                    controller.toggleMusicPlayback();
                  } else {
                    final index = controller.currentMusicIndex.value <
                            controller.musicPlaylists.length
                        ? controller.currentMusicIndex.value
                        : 0;
                    final track = controller.musicPlaylists[index];
                    controller.playMusic(track.fileUrl);
                  }
                },
                child: Obx(() {
                  final isPlaying = controller.isMusicPlaying.value;
                  return Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 16,
                  );
                }),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Obx(() {
                  if (!controller.hasMusicPlayed.value &&
                      !controller.isMusicPlaying.value) {
                    return const SizedBox.shrink();
                  }
                  final position = controller.musicPosition.value;
                  final duration = controller.musicDuration.value;
                  return Row(
                    children: [
                      Text(
                        controller.formatDuration(position),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white70,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: position.inSeconds.toDouble(),
                          min: 0,
                          max: duration.inSeconds > 0
                              ? duration.inSeconds.toDouble()
                              : 1,
                          onChanged: (value) {
                            controller.seekMusic(
                                Duration(seconds: value.toInt()));
                          },
                          activeColor: const Color(0xFF6366F1), // Vibrant blue
                          inactiveColor: Colors.white.withOpacity(0.3), // Muted grey
                        ),
                      ),
                      Text(
                        controller.formatDuration(duration),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  if (controller.musicTrack.value.isNotEmpty) {
                    Get.to(() => FullAudioPlayerScreen(
                          isBinaural: false,
                          track: controller.musicTrack.value,
                        ));
                  }
                },
                child: const Icon(
                  Icons.fullscreen,
                  color: Colors.white70,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Volume control row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  controller.setMusicVolume(
                      controller.musicVolume.value > 0 ? 0 : 0.5);
                },
                child: Obx(() => Icon(
                      controller.musicVolume.value == 0
                          ? Icons.volume_off
                          : Icons.volume_up,
                      color: Colors.white,
                      size: 12,
                    )),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 80,
                height: 12,
                child: Slider(
                  value: controller.musicVolume.value,
                  onChanged: (value) {
                    controller.setMusicVolume(value);
                  },
                  min: 0,
                  max: 1,
                  activeColor: const Color(0xFF6366F1), // Vibrant blue
                  inactiveColor: Colors.white.withOpacity(0.3), // Muted grey
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBinauralPlayer() {
    final controller = bottomBarController;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Track info
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED).withOpacity(0.25), // Lighter purple shade
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Binaural',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade300,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Obx(() {
                        if (controller.binauralPlaylists.isEmpty) {
                          return const Text(
                            'No tracks',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 9,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          );
                        }
                        final index = controller.currentBinauralIndex.value <
                                controller.binauralPlaylists.length
                            ? controller.currentBinauralIndex.value
                            : 0;
                        final currentTrack =
                            controller.binauralPlaylists[index];
                        return Text(
                          currentTrack.title,
                          style: TextStyle(
                            color: controller.isBinauralPlaying.value
                                ? Colors.white
                                : Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          // Progress bar row
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (controller.binauralPlaylists.isEmpty) return;
                  if (controller.isBinauralPlaying.value) {
                    controller.toggleBinauralPlayback();
                  } else if (controller.binauralTrack.value.isNotEmpty) {
                    controller.toggleBinauralPlayback();
                  } else {
                    final index = controller.currentBinauralIndex.value <
                            controller.binauralPlaylists.length
                        ? controller.currentBinauralIndex.value
                        : 0;
                    final track = controller.binauralPlaylists[index];
                    controller.playBinaural(track.fileUrl);
                  }
                },
                child: Obx(() {
                  final isPlaying = controller.isBinauralPlaying.value;
                  return Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 16,
                  );
                }),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Obx(() {
                  if (!controller.hasBinauralPlayed.value &&
                      !controller.isBinauralPlaying.value) {
                    return const SizedBox.shrink();
                  }
                  final position = controller.binauralPosition.value;
                  final duration = controller.binauralDuration.value;
                  return Row(
                    children: [
                      Text(
                        controller.formatDuration(position),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white70,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: position.inSeconds.toDouble(),
                          min: 0,
                          max: duration.inSeconds > 0
                              ? duration.inSeconds.toDouble()
                              : 1,
                          onChanged: (value) {
                            controller.seekBinaural(
                                Duration(seconds: value.toInt()));
                          },
                          activeColor: const Color(0xFF8B5CF6), // Vibrant purple
                          inactiveColor: Colors.white.withOpacity(0.3), // Muted grey
                        ),
                      ),
                      Text(
                        controller.formatDuration(duration),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  if (controller.binauralTrack.value.isNotEmpty) {
                    Get.to(() => FullAudioPlayerScreen(
                          isBinaural: true,
                          track: controller.binauralTrack.value,
                        ));
                  }
                },
                child: const Icon(
                  Icons.fullscreen,
                  color: Colors.white70,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Volume control row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  controller.setBinauralVolume(
                      controller.binauralVolume.value > 0 ? 0 : 0.5);
                },
                child: Obx(() => Icon(
                      controller.binauralVolume.value == 0
                          ? Icons.volume_off
                          : Icons.volume_up,
                      color: Colors.white,
                      size: 12,
                    )),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 80,
                height: 12,
                child: Slider(
                  value: controller.binauralVolume.value,
                  onChanged: (value) {
                    controller.setBinauralVolume(value);
                  },
                  min: 0,
                  max: 1,
                  activeColor: const Color(0xFF8B5CF6), // Vibrant purple
                  inactiveColor: Colors.white.withOpacity(0.3), // Muted grey
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
