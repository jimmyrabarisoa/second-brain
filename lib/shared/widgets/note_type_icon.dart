import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../mock/mock_data.dart';

class NoteTypeIcon extends StatelessWidget {
  final NoteType type;
  final double size;

  const NoteTypeIcon({super.key, required this.type, this.size = 16});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (type) {
      NoteType.idea  => (Icons.lightbulb_outline,    AppColors.warning),
      NoteType.link  => (Icons.link,                 AppColors.primary),
      NoteType.quote => (Icons.format_quote,         AppColors.accent),
      NoteType.task  => (Icons.check_circle_outline, AppColors.success),
      NoteType.image => (Icons.image_outlined,       AppColors.muted),
      NoteType.audio => (Icons.mic_none,             AppColors.muted),
      NoteType.note  => (Icons.description_outlined, AppColors.muted),
    };
    return Icon(icon, size: size, color: color);
  }
}
