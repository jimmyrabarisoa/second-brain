import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';
import '../../../../shared/widgets/note_type_icon.dart';
import '../../../../shared/widgets/section_header.dart';

class ProjectScreen extends StatefulWidget {
  final String projectId;
  final ValueChanged<String> onOpenNote;

  const ProjectScreen({super.key, required this.projectId, required this.onOpenNote});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final Set<int> _checked = {};

  static const _tasks = ['Définir le design system', 'Créer les maquettes', 'Implémenter la navigation', 'Configurer la base de données', 'Tester sur Android'];

  @override
  Widget build(BuildContext context) {
    final project = mockProjects.firstWhere((p) => p.id == widget.projectId);
    final color = Color(int.parse(project.color.replaceFirst('#', '0xFF')));
    final notes = mockNotes.where((n) => n.projectId == widget.projectId).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: color.withValues(alpha: 0.12),
            foregroundColor: AppColors.foreground,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(project.name, style: AppTextStyles.h3),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withValues(alpha: 0.15), AppColors.background],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                MvCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Objectif', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
                      const SizedBox(height: 4),
                      Text(project.goal, style: AppTextStyles.body),
                      if (project.deadline != null) ...[
                        const SizedBox(height: 8),
                        Row(children: [
                          Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.muted),
                          const SizedBox(width: 4),
                          Text('Échéance : ${project.deadline!.day}/${project.deadline!.month}/${project.deadline!.year}', style: AppTextStyles.caption),
                        ]),
                      ],
                      const SizedBox(height: 12),
                      Row(children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: project.progress / 100,
                              backgroundColor: AppColors.secondary,
                              valueColor: AlwaysStoppedAnimation(color),
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('${project.progress}%', style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w700)),
                      ]),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                SectionHeader(title: 'Tâches'),
                const SizedBox(height: 12),
                MvCard(
                  child: Column(
                    children: List.generate(_tasks.length, (i) => CheckboxListTile(
                      dense: true,
                      value: _checked.contains(i),
                      onChanged: (v) => setState(() => v == true ? _checked.add(i) : _checked.remove(i)),
                      title: Text(_tasks[i], style: AppTextStyles.body.copyWith(
                        decoration: _checked.contains(i) ? TextDecoration.lineThrough : null,
                        color: _checked.contains(i) ? AppColors.muted : AppColors.foreground,
                      )),
                      activeColor: color,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    )),
                  ),
                ),

                if (notes.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  SectionHeader(title: 'Notes liées'),
                  const SizedBox(height: 12),
                  ...notes.map((n) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MvCard(
                      onTap: () => widget.onOpenNote(n.id),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          NoteTypeIcon(type: n.type),
                          const SizedBox(width: 10),
                          Expanded(child: Text(n.title, style: AppTextStyles.label, maxLines: 1, overflow: TextOverflow.ellipsis)),
                          Icon(Icons.chevron_right, size: 18, color: AppColors.muted),
                        ],
                      ),
                    ),
                  )),
                ],

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
