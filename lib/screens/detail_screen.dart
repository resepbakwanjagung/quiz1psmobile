import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/local_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _quantity = 1;
  bool _isWishlisted = false;
  bool _addedToCart = false;

  void _incrementQty() => setState(() => _quantity++);
  void _decrementQty() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  void _toggleWishlist() => setState(() => _isWishlisted = !_isWishlisted);

  void _addToCart() {
    setState(() => _addedToCart = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${widget.product.name} ditambahkan ke keranjang!',
                style: AppTextStyles.body.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _addedToCart = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Detail Produk',
        showBackButton: true,
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _isWishlisted
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                key: ValueKey(_isWishlisted),
                color: _isWishlisted ? AppColors.secondary : AppColors.textSecondary,
              ),
            ),
            onPressed: _toggleWishlist,
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductInfo(),
            _buildDivider(),
            _buildDescription(),
            _buildDivider(),
            _buildQuantitySection(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildProductImage() {
    return Hero(
      tag: 'product_${widget.product.id}',
      child: Container(
        height: 300,
        width: double.infinity,
        color: AppColors.surfaceVariant,
        child: Image.network(
          widget.product.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(
            Icons.image_outlined,
            size: 80,
            color: AppColors.textHint,
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.product.isNew)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Text(
                'PRODUK BARU',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          Text(widget.product.name, style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFBBF24)),
              const SizedBox(width: 4),
              Text(widget.product.rating.toString(),
                  style: AppTextStyles.bodyMedium),
              const SizedBox(width: 4),
              Text('(${widget.product.reviewCount} ulasan)',
                  style: AppTextStyles.caption),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Text(
                  _getCategoryName(widget.product.categoryId),
                  style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(widget.product.formattedPrice,
              style: AppTextStyles.heading2.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Deskripsi Produk', style: AppTextStyles.heading3),
          const SizedBox(height: 8),
          Text(widget.product.description, style: AppTextStyles.body),
        ],
      ),
    );
  }

  Widget _buildQuantitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jumlah', style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          Row(
            children: [
              _QtyButton(
                icon: Icons.remove_rounded,
                onTap: _decrementQty,
                enabled: _quantity > 1,
              ),
              Container(
                width: 52,
                alignment: Alignment.center,
                child: Text('$_quantity', style: AppTextStyles.heading3),
              ),
              _QtyButton(
                icon: Icons.add_rounded,
                onTap: _incrementQty,
                enabled: true,
              ),
              const Spacer(),
              Text(
                'Subtotal: ${_getSubtotalFormatted()}',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getSubtotalFormatted() {
    final total = widget.product.price * _quantity;
    final formatted = total.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppTheme.spacingM, AppTheme.spacingS, AppTheme.spacingM, AppTheme.spacingL),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              label: 'Bagikan',
              isFullWidth: false,
              prefixIcon: const Icon(Icons.share_outlined, size: 18, color: AppColors.primary),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Fitur bagikan akan segera hadir!',
                        style: AppTextStyles.body.copyWith(color: Colors.white)),
                    backgroundColor: AppColors.textSecondary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: PrimaryButton(
              label: _addedToCart ? 'Ditambahkan!' : 'Tambah ke Keranjang',
              prefixIcon: Icon(
                _addedToCart ? Icons.check_rounded : Icons.shopping_cart_outlined,
                size: 18,
                color: Colors.white,
              ),
              onPressed: _addedToCart ? null : _addToCart,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 8,
      color: AppColors.background,
    );
  }

  String _getCategoryName(String categoryId) {
    try {
      return LocalData.categories
          .firstWhere((c) => c.id == categoryId)
          .name;
    } catch (_) {
      return categoryId;
    }
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}