import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinks extends StatelessWidget {
  final bool showText;
  final double iconSize;

  const SocialMediaLinks({
    super.key,
    this.showText = false,
    this.iconSize = 40,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Connect With Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.facebook,
              color: const Color(0xFF1877F2),
              url: 'https://facebook.com/profile.php?id=61578944600390',
              label: 'Facebook',
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              customChild: Center(
                child: Text(
                  '𝕏',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: iconSize * 0.5,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              ),
              color: Colors.black,
              url: 'https://x.com/FrequencyTuning',
              label: 'X',
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              customChild: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFCAF45),
                      Color(0xFFFF5B5B),
                      Color(0xFFD62976),
                      Color(0xFFD62976),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer rounded square
                      Container(
                        width: iconSize * 0.65,
                        height: iconSize * 0.65,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: iconSize * 0.06),
                          borderRadius: BorderRadius.circular(iconSize * 0.15),
                        ),
                      ),
                      // Inner circle
                      Container(
                        width: iconSize * 0.4,
                        height: iconSize * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: iconSize * 0.06),
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Top right dot
                      Positioned(
                        top: iconSize * 0.15,
                        right: iconSize * 0.15,
                        child: Container(
                          width: iconSize * 0.08,
                          height: iconSize * 0.08,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              color: Colors.transparent,
              url: 'https://www.instagram.com/frequencytuningaudio/',
              label: 'Instagram',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    IconData? icon,
    Widget? customChild,
    required Color color,
    required String url,
    required String label,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color == Colors.transparent 
                  ? Colors.black26 
                  : color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: customChild ?? Icon(
          icon,
          color: Colors.white,
          size: iconSize * 0.5,
        ),
      ),
    );
  }
}
