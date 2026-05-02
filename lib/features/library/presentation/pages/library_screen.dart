import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';
import '../../../../shared/widgets/section_header.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Bibliothèque')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionHeader(title: 'Domaines de vie'),
          const SizedBox(height: 12),
          ...mockLifeAreas.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MvCard(
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text(a.emoji, style: const TextStyle(fontSize: 20))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Text(a.name, style: AppTextStyles.h3)),
                  Text('${a.noteCount} notes', style: AppTextStyles.caption),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, color: AppColors.muted, size: 18),
                ],
              ),
            ),
          )),

          const SizedBox(height: 24),
          SectionHeader(title: 'Sujets'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: mockLibrarySubjects.map((s) => GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(s.name, style: AppTextStyles.label),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(8)),
                      child: Text('${s.noteCount}', style: AppTextStyles.caption),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
