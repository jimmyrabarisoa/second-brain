import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/mv_card.dart';

enum SortDestination { project, domain, library, archive }

class SortScreen extends StatelessWidget {
  final String noteId;
  final VoidCallback onDone;

  const SortScreen({super.key, required this.noteId, required this.onDone});

  static const _destinations = [
    (
      SortDestination.project,
      '🎯',
      'Projet en cours',
      'Quelque chose à terminer',
      'Ex : lancer mon app, préparer ma présentation',
      AppColors.primarySoft,
      AppColors.primary,
    ),
    (
      SortDestination.domain,
      '🌿',
      'Domaine de vie',
      'Quelque chose à maintenir',
      'Ex : Santé, Finances, Relations',
      AppColors.successSoft,
      AppColors.success,
    ),
    (
      SortDestination.library,
      '📚',
      'Bibliothèque',
      'Sujet à garder ou apprendre',
      'Ex : Flutter, Stoïcisme, Nutrition',
      AppColors.accentSoft,
      AppColors.accent,
    ),
    (
      SortDestination.archive,
      '🗄️',
      'Archives',
      'À garder sans avoir sous les yeux',
      'Ex : anciens projets, références ponctuelles',
      AppColors.secondary,
      AppColors.muted,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Où ranger ?')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Choisis l\'endroit qui correspond le mieux à cette note.', style: AppTextStyles.bodyMuted),
          const SizedBox(height: 20),
          ..._destinations.map((d) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MvCard(
              color: d.$6.withValues(alpha: 0.15),
              onTap: onDone,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: d.$6.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(d.$2, style: const TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d.$3, style: AppTextStyles.h3),
                        Text(d.$4, style: AppTextStyles.caption.copyWith(color: d.$7)),
                        const SizedBox(height: 2),
                        Text(d.$5, style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: AppColors.muted),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
