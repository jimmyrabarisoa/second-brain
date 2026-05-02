import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';
import '../../../../shared/widgets/note_type_icon.dart';

class NotesScreen extends StatefulWidget {
  final ValueChanged<String> onOpenNote;

  const NotesScreen({super.key, required this.onOpenNote});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String _search = '';

  List<NoteModel> get _filtered => mockNotes
      .where((n) => !n.unsorted)
      .where((n) => _search.isEmpty || n.title.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Notes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: AppColors.muted),
                hintText: 'Rechercher…',
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filtered.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final n = _filtered[i];
                return MvCard(
                  onTap: () => widget.onOpenNote(n.id),
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: NoteTypeIcon(type: n.type, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n.title, style: AppTextStyles.label),
                            const SizedBox(height: 2),
                            Text(n.excerpt, style: AppTextStyles.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              children: n.tags.map((t) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(8)),
                                child: Text(t, style: AppTextStyles.caption),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          if (n.important)
                            const Text('⭐', style: TextStyle(fontSize: 12)),
                          if (n.toReview)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(6)),
                                child: Text('Revoir', style: AppTextStyles.caption.copyWith(color: AppColors.accent, fontSize: 10)),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
