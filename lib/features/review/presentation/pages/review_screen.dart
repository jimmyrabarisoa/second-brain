import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';
import '../../../../shared/widgets/note_type_icon.dart';

class ReviewScreen extends StatelessWidget {
  final ValueChanged<String> onOpenNote;

  const ReviewScreen({super.key, required this.onOpenNote});

  @override
  Widget build(BuildContext context) {
    final toReview = mockNotes.where((n) => n.toReview).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('À revoir')),
      body: toReview.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('✨', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  Text('Rien à revoir !', style: AppTextStyles.h3),
                  Text('Tu es à jour.', style: AppTextStyles.bodyMuted),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: toReview.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final n = toReview[i];
                return MvCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        NoteTypeIcon(type: n.type),
                        const SizedBox(width: 10),
                        Expanded(child: Text(n.title, style: AppTextStyles.h3)),
                      ]),
                      const SizedBox(height: 6),
                      Text(n.excerpt, style: AppTextStyles.bodyMuted, maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 14),
                      Row(children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => onOpenNote(n.id),
                            icon: const Icon(Icons.auto_awesome, size: 16),
                            label: const Text('Résumer'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: const BorderSide(color: AppColors.primarySoft),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.rocket_launch_outlined, size: 16),
                            label: const Text('En action'),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.success,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
