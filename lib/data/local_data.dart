import '../models/category.dart';
import '../models/product.dart';

class LocalData {
  LocalData._();

  static const List<Category> categories = [
    Category(id: 'all', name: 'Semua', icon: '🏷️'),
    Category(id: 'elektronik', name: 'Elektronik', icon: '📱'),
    Category(id: 'fashion', name: 'Fashion', icon: '👗'),
    Category(id: 'makanan', name: 'Makanan', icon: '🍕'),
    Category(id: 'olahraga', name: 'Olahraga', icon: '⚽'),
    Category(id: 'buku', name: 'Buku', icon: '📚'),
  ];

  static const List<Product> products = [
    Product(
      id: '1',
      name: 'Wireless Earbuds Pro',
      categoryId: 'elektronik',
      price: 459000,
      description:
          'Nikmati kualitas suara premium dengan Wireless Earbuds Pro. Dilengkapi teknologi Active Noise Cancelling (ANC) terbaru, baterai tahan hingga 30 jam, dan desain ergonomis yang nyaman digunakan sepanjang hari. Cocok untuk aktivitas harian, olahraga, maupun bekerja dari rumah.',
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500&auto=format&fit=crop&q=80',
      rating: 4.8,
      reviewCount: 1243,
      isNew: true,
    ),
    Product(
      id: '2',
      name: 'Smartwatch Seri X',
      categoryId: 'elektronik',
      price: 1299000,
      description:
          'Smartwatch Seri X hadir dengan layar AMOLED 1.8 inci yang jernih dan terang. Pantau kesehatan Anda dengan sensor detak jantung, SpO2, dan pelacak tidur canggih. Tahan air hingga 50 meter dan baterai bertahan 7 hari dalam sekali pengisian.',
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=80',
      rating: 4.6,
      reviewCount: 876,
    ),
    Product(
      id: '3',
      name: 'Kaos Polos Premium',
      categoryId: 'fashion',
      price: 129000,
      description:
          'Kaos polos berbahan cotton combed 30s berkualitas tinggi. Tersedia dalam berbagai pilihan warna yang elegan dan tahan lama. Jahitan rapi dengan teknik overlok untuk kenyamanan maksimal. Cocok dipadukan dengan berbagai jenis pakaian.',
      imageUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=500&auto=format&fit=crop&q=80',
      rating: 4.5,
      reviewCount: 3421,
      isNew: false,
    ),
    Product(
      id: '4',
      name: 'Sneakers Urban Lite',
      categoryId: 'fashion',
      price: 389000,
      description:
          'Sepatu sneakers kasual dengan sol ringan berbahan EVA foam yang memberikan bantalan sempurna. Upper berbahan mesh bernapas membuat kaki tetap sejuk sepanjang hari. Desain minimalis yang cocok untuk berbagai aktivitas urban.',
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&auto=format&fit=crop&q=80',
      rating: 4.7,
      reviewCount: 654,
      isNew: true,
    ),
    Product(
      id: '5',
      name: 'Paket Camilan Nusantara',
      categoryId: 'makanan',
      price: 89000,
      description:
          'Paket camilan pilihan terbaik dari seluruh Nusantara. Berisi 10 jenis camilan autentik seperti keripik singkong, kacang bawang, dan masih banyak lagi. Dikemas higienis dan tahan lama untuk oleh-oleh atau camilan keluarga.',
      imageUrl: 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=500&auto=format&fit=crop&q=80',
      rating: 4.9,
      reviewCount: 2156,
    ),
    Product(
      id: '6',
      name: 'Kopi Arabika Specialty',
      categoryId: 'makanan',
      price: 145000,
      description:
          'Kopi arabika single origin dari perkebunan terbaik di Aceh Gayo. Dipanggang dengan metode medium roast untuk menghasilkan rasa yang seimbang antara keasaman dan kemanisan. Dikemas dalam kantong resealable kedap udara 250 gram.',
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=500&auto=format&fit=crop&q=80',
      rating: 4.8,
      reviewCount: 987,
      isNew: true,
    ),
    Product(
      id: '7',
      name: 'Dumbbell Set 20kg',
      categoryId: 'olahraga',
      price: 675000,
      description:
          'Set dumbbell adjustable dengan total beban 20 kg. Pelat berbahan besi cor berkualitas dengan coating anti-karat. Handle ergonomis dengan grip anti-slip untuk keamanan latihan. Cocok untuk latihan di rumah maupun gym.',
      imageUrl: 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=500&auto=format&fit=crop&q=80',
      rating: 4.6,
      reviewCount: 432,
    ),
    Product(
      id: '8',
      name: 'Yoga Mat Anti-Slip',
      categoryId: 'olahraga',
      price: 219000,
      description:
          'Matras yoga premium tebal 6mm dengan permukaan anti-slip ganda (atas dan bawah). Terbuat dari bahan TPE ramah lingkungan yang bebas BPA. Dilengkapi tali pengikat untuk kemudahan penyimpanan dan transportasi.',
      imageUrl: 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=500&auto=format&fit=crop&q=80',
      rating: 4.7,
      reviewCount: 1678,
      isNew: false,
    ),
    Product(
      id: '9',
      name: 'Flutter & Dart Complete',
      categoryId: 'buku',
      price: 185000,
      description:
          'Panduan lengkap belajar Flutter dan Dart dari nol hingga mahir. Mencakup dasar-dasar Dart, widget Flutter, state management, navigasi, dan integrasi API. Dilengkapi 15 proyek nyata yang bisa langsung dipraktikkan.',
      imageUrl: 'https://images.unsplash.com/photo-1532012164546-f432f2e3777a?w=500&auto=format&fit=crop&q=80',
      rating: 4.9,
      reviewCount: 543,
      isNew: true,
    ),
    Product(
      id: '10',
      name: 'Clean Code Indonesia',
      categoryId: 'buku',
      price: 155000,
      description:
          'Terjemahan dan adaptasi buku legendaris Clean Code karya Robert C. Martin untuk developer Indonesia. Pelajari prinsip-prinsip menulis kode yang bersih, mudah dibaca, dan mudah dimaintain.',
      imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=500&auto=format&fit=crop&q=80',
      rating: 4.8,
      reviewCount: 321,
    ),
  ];

  static List<Product> getByCategory(String categoryId) {
    if (categoryId == 'all') return products;
    return products.where((p) => p.categoryId == categoryId).toList();
  }

  static List<Product> search(String query) {
    final q = query.toLowerCase();
    return products
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.description.toLowerCase().contains(q))
        .toList();
  }
}