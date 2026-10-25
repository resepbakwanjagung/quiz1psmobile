import 'package:flutter/material.dart';
import '../data/local_data.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/category_chip.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/product_card.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _selectedCategoryId = 'all';
  List<Product> _displayedProducts = LocalData.products;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      _updateDisplayedProducts();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _updateDisplayedProducts();
    });
  }

  void _updateDisplayedProducts() {
    List<Product> base = LocalData.getByCategory(_selectedCategoryId);
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      base = base
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q))
          .toList();
    }
    _displayedProducts = base;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverToBoxAdapter(child: _buildSectionTitle()),
            _buildProductGrid(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppTheme.spacingM, AppTheme.spacingL, AppTheme.spacingM, AppTheme.spacingS),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Halo, Pengguna! 👋', style: AppTextStyles.caption),
                const SizedBox(height: 2),
                Text('Temukan produk favoritmu', style: AppTextStyles.heading2),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: const Icon(Icons.person_rounded, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM, vertical: AppTheme.spacingS),
      child: CustomTextField(
        controller: _searchController,
        hintText: 'Cari produk...',
        prefixIcon: const Icon(Icons.search_rounded,
            color: AppColors.textHint, size: 20),
        onChanged: _onSearchChanged,
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded,
                    size: 18, color: AppColors.textHint),
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged('');
                },
              )
            : null,
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
        separatorBuilder: (_, _) => const SizedBox(width: AppTheme.spacingS),
        itemCount: LocalData.categories.length,
        itemBuilder: (_, i) {
          final cat = LocalData.categories[i];
          return CategoryChip(
            label: cat.name,
            emoji: cat.icon,
            isSelected: _selectedCategoryId == cat.id,
            onTap: () => _onCategorySelected(cat.id),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppTheme.spacingM, AppTheme.spacingL, AppTheme.spacingM, AppTheme.spacingM),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _searchQuery.isNotEmpty
                  ? 'Hasil pencarian (${_displayedProducts.length})'
                  : 'Produk Pilihan',
              style: AppTextStyles.heading3,
            ),
          ),
          Text('${_displayedProducts.length} produk',
              style: AppTextStyles.caption),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    if (_displayedProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingXL),
            child: Column(
              children: [
                const Icon(Icons.search_off_rounded,
                    size: 64, color: AppColors.textHint),
                const SizedBox(height: 16),
                Text('Produk tidak ditemukan',
                    style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Text('Coba kata kunci yang berbeda',
                    style: AppTextStyles.caption),
              ],
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (_, i) => ProductCard(product: _displayedProducts[i]),
          childCount: _displayedProducts.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.72,
        ),
      ),
    );
  }
}