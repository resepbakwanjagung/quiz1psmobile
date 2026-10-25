import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/secondary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Profil Saya',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: AppTheme.spacingM),
            _buildStatsRow(),
            const SizedBox(height: AppTheme.spacingM),
            _buildMenuSection(context),
            const SizedBox(height: AppTheme.spacingM),
            _buildLogoutSection(context),
            const SizedBox(height: AppTheme.spacingXL),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: const BoxDecoration(
        color: AppColors.surface,
      ),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.person_rounded, size: 48, color: Colors.white),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text('Budi Santoso', style: AppTextStyles.heading2),
          const SizedBox(height: 4),
          Text('budi.santoso@mahasiswa.ac.id',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
            ),
            child: Text(
              '✨ Member Premium',
              style: AppTextStyles.captionMedium.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(label: 'Pesanan', value: '12'),
          _buildVerticalDivider(),
          _StatItem(label: 'Wishlist', value: '5'),
          _buildVerticalDivider(),
          _StatItem(label: 'Ulasan', value: '8'),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: AppColors.border,
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = [
      _MenuItem(
        icon: Icons.shopping_bag_outlined,
        title: 'Pesanan Saya',
        subtitle: 'Lihat riwayat pembelian',
        onTap: () => _showComingSoon(context),
      ),
      _MenuItem(
        icon: Icons.favorite_border_rounded,
        title: 'Wishlist',
        subtitle: 'Produk yang disukai',
        onTap: () => _showComingSoon(context),
      ),
      _MenuItem(
        icon: Icons.location_on_outlined,
        title: 'Alamat Pengiriman',
        subtitle: 'Kelola alamat pengiriman',
        onTap: () => _showComingSoon(context),
      ),
      _MenuItem(
        icon: Icons.payment_outlined,
        title: 'Metode Pembayaran',
        subtitle: 'Kartu & dompet digital',
        onTap: () => _showComingSoon(context),
      ),
      _MenuItem(
        icon: Icons.notifications_outlined,
        title: 'Notifikasi',
        subtitle: 'Pengaturan notifikasi',
        onTap: () => _showComingSoon(context),
      ),
      _MenuItem(
        icon: Icons.help_outline_rounded,
        title: 'Bantuan',
        subtitle: 'Pusat bantuan & FAQ',
        onTap: () => _showComingSoon(context),
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final isLast = entry.key == menuItems.length - 1;
          return Column(
            children: [
              _MenuItemTile(item: entry.value),
              if (!isLast)
                const Divider(
                  height: 1,
                  indent: 56,
                  color: AppColors.border,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      child: Column(
        children: [
          SecondaryButton(
            label: 'Keluar',
            prefixIcon: const Icon(Icons.logout_rounded,
                size: 18, color: AppColors.primary),
            onPressed: () => _showLogoutDialog(context),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'KatalogKita v1.0.0',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fitur ini akan segera hadir!',
            style: AppTextStyles.body.copyWith(color: Colors.white)),
        backgroundColor: AppColors.textSecondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        title: Text('Keluar', style: AppTextStyles.heading3),
        content: Text(
          'Apakah kamu yakin ingin keluar dari akun ini?',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Batal',
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Berhasil keluar',
                      style: AppTextStyles.body.copyWith(color: Colors.white)),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
            ),
            child: Text('Keluar',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: AppTextStyles.heading2.copyWith(color: AppColors.primary)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class _MenuItemTile extends StatelessWidget {
  final _MenuItem item;

  const _MenuItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(item.icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: AppTextStyles.bodyMedium),
                  Text(item.subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 20, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}