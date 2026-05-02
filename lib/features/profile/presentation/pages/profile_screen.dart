import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../mock/mock_data.dart';
import '../../../../shared/widgets/mv_card.dart';
import '../../../../shared/widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MvCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primarySoft,
                  child: Text('SB', style: AppTextStyles.h3.copyWith(color: AppColors.primary)),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Second Brain', style: AppTextStyles.h3),
                    Text('Mon espace personnel', style: AppTextStyles.bodyMuted),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _StatCard(label: 'Notes',    value: '${mockStats['totalNotes']}',    color: AppColors.primary)),
              const SizedBox(width: 10),
              Expanded(child: _StatCard(label: 'Projets',  value: '${mockStats['totalProjects']}', color: AppColors.accent)),
              const SizedBox(width: 10),
              Expanded(child: _StatCard(label: 'À ranger', value: '${mockStats['unsortedCount']}', color: AppColors.warning)),
            ],
          ),

          const SizedBox(height: 24),
          SectionHeader(title: 'Paramètres'),
          const SizedBox(height: 12),
          MvCard(
            child: Column(
              children: [
                _SettingRow(
                  icon: Icons.wifi_off_outlined,
                  label: 'Mode hors-ligne',
                  trailing: Switch(value: true, onChanged: (_) {}, activeThumbColor: AppColors.primary),
                ),
                const Divider(height: 1, color: AppColors.secondary),
                _SettingRow(
                  icon: Icons.save_outlined,
                  label: 'Sauvegarde locale',
                  trailing: const Icon(Icons.chevron_right, color: AppColors.muted),
                ),
                const Divider(height: 1, color: AppColors.secondary),
                _SettingRow(
                  icon: Icons.download_outlined,
                  label: 'Exporter en Markdown',
                  trailing: const Icon(Icons.chevron_right, color: AppColors.muted),
                ),
                const Divider(height: 1, color: AppColors.secondary),
                _SettingRow(
                  icon: Icons.picture_as_pdf_outlined,
                  label: 'Exporter en PDF',
                  trailing: const Icon(Icons.chevron_right, color: AppColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.h2.copyWith(color: color)),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;

  const _SettingRow({required this.icon, required this.label, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.muted),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: AppTextStyles.body)),
          trailing,
        ],
      ),
    );
  }
}
