import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';

class ProjectsScreen extends StatelessWidget {
  final ValueChanged<String> onOpenProject;

  const ProjectsScreen({super.key, required this.onOpenProject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Projets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...mockProjects.map((p) {
            final color = Color(int.parse(p.color.replaceFirst('#', '0xFF')));
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MvCard(
                onTap: () => onOpenProject(p.id),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(p.name, style: AppTextStyles.h3)),
                      Text('${p.progress}%', style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w700)),
                    ]),
                    const SizedBox(height: 6),
                    Text(p.goal, style: AppTextStyles.bodyMuted, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: p.progress / 100,
                        backgroundColor: AppColors.secondary,
                        valueColor: AlwaysStoppedAnimation(color),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(children: [
                      Icon(Icons.description_outlined, size: 14, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Text('${p.noteCount} notes', style: AppTextStyles.caption),
                      const SizedBox(width: 16),
                      Icon(Icons.check_circle_outline, size: 14, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Text('${p.taskCount} tâches', style: AppTextStyles.caption),
                      if (p.deadline != null) ...[
                        const Spacer(),
                        Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.muted),
                        const SizedBox(width: 4),
                        Text(
                          '${p.deadline!.day}/${p.deadline!.month}/${p.deadline!.year}',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ]),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 4),
          MvCard(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: AppColors.primary),
                const SizedBox(width: 8),
                Text('Nouveau projet', style: AppTextStyles.label.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
