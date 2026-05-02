import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';

class CaptureScreen extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback? onSortNow;

  const CaptureScreen({super.key, required this.onClose, this.onSortNow});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  final _titleController   = TextEditingController();
  final _contentController = TextEditingController();
  NoteType _selectedType   = NoteType.idea;
  bool _saved              = false;

  static const _types = [
    (NoteType.idea,  '💡', 'Idée'),
    (NoteType.note,  '📝', 'Note'),
    (NoteType.link,  '🔗', 'Lien'),
    (NoteType.quote, '💬', 'Citation'),
    (NoteType.task,  '✅', 'Tâche'),
  ];

  void _save() {
    if (_titleController.text.trim().isEmpty) return;
    setState(() => _saved = true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: _saved ? _SuccessView(onLater: widget.onClose, onSort: widget.onSortNow ?? widget.onClose)
                      : _FormView(
                          titleController:   _titleController,
                          contentController: _contentController,
                          selectedType:      _selectedType,
                          types:             _types,
                          onTypeChanged:     (t) => setState(() => _selectedType = t),
                          onSave:            _save,
                          onClose:           widget.onClose,
                        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final NoteType selectedType;
  final List<(NoteType, String, String)> types;
  final ValueChanged<NoteType> onTypeChanged;
  final VoidCallback onSave;
  final VoidCallback onClose;

  const _FormView({
    required this.titleController,
    required this.contentController,
    required this.selectedType,
    required this.types,
    required this.onTypeChanged,
    required this.onSave,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Capture rapide', style: AppTextStyles.h3),
              const Spacer(),
              IconButton(onPressed: onClose, icon: const Icon(Icons.close), color: AppColors.muted),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: types.map((t) {
                final selected = t.$1 == selectedType;
                return GestureDetector(
                  onTap: () => onTypeChanged(t.$1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primarySoft : AppColors.secondary,
                      borderRadius: BorderRadius.circular(20),
                      border: selected ? Border.all(color: AppColors.primary, width: 1.5) : null,
                    ),
                    child: Text('${t.$2} ${t.$3}', style: AppTextStyles.caption.copyWith(
                      color: selected ? AppColors.primary : AppColors.foreground,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    )),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            autofocus: true,
            style: AppTextStyles.h3,
            decoration: const InputDecoration(hintText: 'Titre…', border: InputBorder.none, filled: false),
          ),
          const Divider(color: AppColors.secondary),
          TextField(
            controller: contentController,
            maxLines: 4,
            style: AppTextStyles.body,
            decoration: const InputDecoration(hintText: 'Ajoute des détails…', border: InputBorder.none, filled: false),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onSave,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text('Capturer', style: AppTextStyles.label.copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final VoidCallback onLater;
  final VoidCallback onSort;

  const _SuccessView({required this.onLater, required this.onSort});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('✅', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text('Capturé !', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text('Ta note est dans la boîte à ranger.', style: AppTextStyles.bodyMuted, textAlign: TextAlign.center),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onSort,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text('Ranger maintenant', style: AppTextStyles.label.copyWith(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onLater,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: AppColors.secondary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text('Plus tard', style: AppTextStyles.label),
            ),
          ),
        ],
      ),
    );
  }
}
