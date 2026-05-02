import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';
import '../../../../shared/widgets/note_type_icon.dart';

class SearchScreen extends StatefulWidget {
  final ValueChanged<String> onOpenNote;

  const SearchScreen({super.key, required this.onOpenNote});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  List<NoteModel> get _results => _query.length < 2
      ? []
      : mockNotes.where((n) =>
          n.title.toLowerCase().contains(_query.toLowerCase()) ||
          n.excerpt.toLowerCase().contains(_query.toLowerCase()) ||
          n.tags.any((t) => t.toLowerCase().contains(_query.toLowerCase()))).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Recherche')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: TextField(
              autofocus: true,
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: AppColors.muted),
                hintText: 'Notes, projets, sujets…',
              ),
            ),
          ),
          if (_query.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Text('Tags populaires', style: AppTextStyles.h3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: popularTags.map((t) => GestureDetector(
                  onTap: () => setState(() => _query = t),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
                    ),
                    child: Text('#$t', style: AppTextStyles.label.copyWith(color: AppColors.primary)),
                  ),
                )).toList(),
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text('${_results.length} résultat${_results.length > 1 ? 's' : ''}', style: AppTextStyles.caption),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _results.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final n = _results[i];
                  return MvCard(
                    onTap: () => widget.onOpenNote(n.id),
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        NoteTypeIcon(type: n.type),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n.title, style: AppTextStyles.label),
                              Text(n.excerpt, style: AppTextStyles.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
