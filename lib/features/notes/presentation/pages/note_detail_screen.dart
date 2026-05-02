import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';
import '../../../../shared/widgets/note_type_icon.dart';

class NoteDetailScreen extends StatelessWidget {
  final String noteId;

  const NoteDetailScreen({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    final note = mockNotes.firstWhere((n) => n.id == noteId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: NoteTypeIcon(type: note.type, size: 20),
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(note.title, style: AppTextStyles.h1),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: note.tags.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(10)),
              child: Text(t, style: AppTextStyles.caption),
            )).toList(),
          ),
          const SizedBox(height: 20),
          Text(note.excerpt, style: AppTextStyles.body),
          const SizedBox(height: 8),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
            style: AppTextStyles.body,
          ),

          const SizedBox(height: 24),
          MvCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Résumé', style: AppTextStyles.h3.copyWith(color: AppColors.primary)),
                const SizedBox(height: 8),
                Text('L\'essentiel de cette note en une phrase.', style: AppTextStyles.body),
              ],
            ),
          ),

          const SizedBox(height: 12),
          MvCard(
            color: AppColors.accentSoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Idées clés', style: AppTextStyles.h3.copyWith(color: AppColors.accent)),
                const SizedBox(height: 8),
                ...[
                  'Point important numéro 1',
                  'Point important numéro 2',
                  'Point important numéro 3',
                ].map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 6, color: AppColors.accent),
                      const SizedBox(width: 8),
                      Text(item, style: AppTextStyles.body),
                    ],
                  ),
                )),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Text('Actions', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.auto_awesome,
                  label: 'Résumer',
                  color: AppColors.primary,
                  bgColor: AppColors.primarySoft,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  icon: Icons.rocket_launch_outlined,
                  label: 'En action',
                  color: AppColors.success,
                  bgColor: AppColors.successSoft,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  icon: Icons.folder_outlined,
                  label: 'Lier projet',
                  color: AppColors.accent,
                  bgColor: AppColors.accentSoft,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
