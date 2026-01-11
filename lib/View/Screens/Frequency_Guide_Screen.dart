import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/Social_Media_Links.dart';

class FrequencyGuideScreen extends StatelessWidget {
  const FrequencyGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6F41F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6F41F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Frequency Guide',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Brainwave Frequencies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildFrequencyCard(
            'Gamma (30-100 Hz)',
            'Increased cognitive enhancement',
            Colors.purple.shade700,
          ),
          _buildFrequencyCard(
            'Beta (13–30 Hz)',
            'Focused, alert wakefulness. (Sometimes subdivided into low/mid/high Beta.)',
            Colors.blue.shade700,
          ),
          _buildFrequencyCard(
            'Alpha (8–12 Hz)',
            'Relaxed wakefulness, inward focus, light meditation.',
            Colors.green.shade700,
          ),
          _buildFrequencyCard(
            'Theta (4–7 Hz)',
            'Deep relaxation, hypnagogic states, dreamlike imagery, creative insight.',
            Colors.orange.shade700,
          ),
          _buildFrequencyCard(
            'Delta (0.5–3 Hz)',
            'Deep, dreamless sleep or very profound meditation states.',
            Colors.indigo.shade700,
          ),
          const SizedBox(height: 24),
          const Text(
            'Solfeggio Tones',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSolfeggioCard('174 Hz', 'Foundation frequency for comfort and stability.'),
          _buildSolfeggioCard('285 Hz', 'Linked to holistic health and tissue regeneration.'),
          _buildSolfeggioCard('396 Hz', 'Associated with liberating guilt and fear; grounding.'),
          _buildSolfeggioCard('417 Hz', 'Associated with breaking old patterns and facilitating change.'),
          _buildSolfeggioCard('528 Hz', 'The "miracle" tone; associated with transformation, love, and harmony.'),
          _buildSolfeggioCard('639 Hz', 'Linked to relationships, connection, and balance.'),
          _buildSolfeggioCard('741 Hz', 'Associated with intuition, clarity, and problem-solving.'),
          _buildSolfeggioCard('852 Hz', 'Tied to spiritual order, awakening intuition.'),
          _buildSolfeggioCard('963 Hz', 'The "pure miracle" or "pineal gland activation" tone; associated with oneness and higher consciousness.'),
          const SizedBox(height: 32),
          const Divider(color: Colors.white54, thickness: 1),
          const SizedBox(height: 24),
          const SocialMediaLinks(showText: true, iconSize: 50),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildFrequencyCard(String title, String description, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.waves, color: Colors.white, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF6F41F3),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolfeggioCard(String frequency, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.amber.shade700,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.music_note, color: Colors.white, size: 24),
        ),
        title: Text(
          frequency,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF6F41F3),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
