import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';
import '../../../../shared/widgets/note_type_icon.dart';
import '../../../../shared/widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenInbox;
  final VoidCallback onOpenReview;
  final ValueChanged<String> onOpenProject;
  final ValueChanged<String> onOpenNote;

  const HomeScreen({
    super.key,
    required this.onOpenInbox,
    required this.onOpenReview,
    required this.onOpenProject,
    required this.onOpenNote,
  });

  @override
  Widget build(BuildContext context) {
    final unsorted = mockStats['unsortedCount'] as int;
    final toReview = mockStats['toReviewCount'] as int;
    final recentNotes = mockNotes.take(3).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            title: Text('Bonjour 👋', style: AppTextStyles.h2),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),

                // Cartes action rapide
                Row(
                  children: [
                    Expanded(
                      child: MvCard(
                        color: AppColors.warningSoft,
                        onTap: onOpenInbox,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              const Text('📥', style: TextStyle(fontSize: 20)),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.warning,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text('$unsorted', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                              ),
                            ]),
                            const SizedBox(height: 10),
                            Text('À ranger', style: AppTextStyles.h3),
                            Text('notes non classées', style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MvCard(
                        color: AppColors.accentSoft,
                        onTap: onOpenReview,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              const Text('🔁', style: TextStyle(fontSize: 20)),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text('$toReview', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                              ),
                            ]),
                            const SizedBox(height: 10),
                            Text('À revoir', style: AppTextStyles.h3),
                            Text('notes en attente', style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),
                SectionHeader(title: 'Projets en cours', action: 'Voir tout', onAction: () {}),
                const SizedBox(height: 12),
                ...mockProjects.take(2).map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MvCard(
                    onTap: () => onOpenProject(p.id),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(width: 10, height: 10, decoration: BoxDecoration(color: Color(int.parse(p.color.replaceFirst('#', '0xFF'))), shape: BoxShape.circle)),
                          const SizedBox(width: 8),
                          Expanded(child: Text(p.name, style: AppTextStyles.h3)),
                          Text('${p.progress}%', style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                        ]),
                        const SizedBox(height: 6),
                        Text(p.goal, style: AppTextStyles.bodyMuted, maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: p.progress / 100,
                            backgroundColor: AppColors.secondary,
                            valueColor: AlwaysStoppedAnimation(Color(int.parse(p.color.replaceFirst('#', '0xFF')))),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),

                const SizedBox(height: 28),
                SectionHeader(title: 'Notes récentes', action: 'Voir tout', onAction: () {}),
                const SizedBox(height: 12),
                ...recentNotes.map((n) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MvCard(
                    onTap: () => onOpenNote(n.id),
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        NoteTypeIcon(type: n.type, size: 18),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n.title, style: AppTextStyles.label, maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text(n.excerpt, style: AppTextStyles.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        if (n.important)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppColors.warningSoft, borderRadius: BorderRadius.circular(6)),
                            child: Text('⭐', style: const TextStyle(fontSize: 10)),
                          ),
                      ],
                    ),
                  ),
                )),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
