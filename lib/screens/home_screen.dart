import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:fashion_app1/widgets/product_widget.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;
  final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');


  void _goToSearch() {
    _searchQuery.value = ''; 
    setState(() => _currentIndex = 1);
  }
  void _goToSearchWith(String cat) {
  _searchQuery.value = cat; 
  setState(() => _currentIndex = 1);
}
  @override
  void initState() {
    super.initState();
      _screens = [
        _HomeTab(
        onGoToSearch: _goToSearch,
        onGoToSearchWith: _goToSearchWith,
      ),
      SearchScreen(queryListenable: _searchQuery),
      const CartScreen(),
      const ProfileScreen(),
      ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed, 
        onTap: (index) {
          if (index == 1) {
            _searchQuery.value = ''; 
          }
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

}

class _HomeTab extends StatelessWidget {
   final VoidCallback onGoToSearch;
  final void Function(String cat) onGoToSearchWith;

  const _HomeTab({
    required this.onGoToSearch,
    required this.onGoToSearchWith,
  });

  static const List<String> _categories = [
    'jeans',
    'pants',
    't-shirts',
    'tops',
    'jackets',
    'dresses',
    'skirts',
    'shoes',
    'bags',
    'hoodies',
    'sweaters',
    'coats',
    'blazers',
    'shorts',
    'accessories',
  ];

   static const List<Map<String, dynamic>> _featuredProducts = [
    {
      'title': 'Light Oversized Jeans',
      'category': 'jeans',
      'price': 3990,
      'image':
          'https://wrogn.com/cdn/shop/files/1_4eb49f58-8131-4749-b63b-2a3573424b64.jpg?v=1749124959',
    },
    {
      'title': 'Dark Straight Jeans',
      'category': 'jeans',
      'price': 4399,
      'image':
          'https://uspoloassn.in/cdn/shop/files/1_b53772c0-f28b-44c6-9faf-bbea1879d148.jpg',
    },
    {
      'title': 'Denim Jacket',
      'category': 'jackets',
      'price': 5999,
      'image':
          'https://www.cottontraders.com/on/demandware.static/-/Sites-cotton-master-catalog/default/dwf3457617/images/original/AD12222W_original_neutral_stonewash_574653.jpg',
    },
    {
      'title': 'Summer Midi Dress',
      'category': 'dresses',
      'price': 4999,
      'image':
          'https://www.lulus.com/images/product/xlarge/11626201_2382031.jpg?w=375&hdpi=1',
    },
  ];

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const BrandAppBarTitle(title: 'Fashion Store'),
          ),


          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.brandSoft,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.brandLine),
                ),
                child: Stack(
                  children: [
                    // Tekst na banneru
                    Positioned.fill(
                      child: Image.network(
                        'https://cdn.mos.cms.futurecdn.net/jm57XgyKTsA4htfmbpHqKS.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),  

                    const Positioned(
                      left: 16,
                      top: 16,
                      right: 16,
                      child: Text(
                        'New Collection',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 44,
                      right: 16,
                      child: Text(
                        'Explore our newest items\nfor this season.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: SizedBox(
                        width: 120,
                      
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brand,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: onGoToSearch,
                        child: const Text('Explore'),
                      ),
                    ),
                    ),
                  ],
                ),
              
              ),
            ),
          ),

          // categories
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Categories',
                style: TextStyle(
                  color: AppColors.brand,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  final cat = _categories[i];
                  return ActionChip(
                    backgroundColor: AppColors.brandSoft,
                    side: BorderSide(color: AppColors.brandLine),
                    label: Text(
                      cat,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    onPressed: () => onGoToSearchWith(cat),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemCount: _categories.length,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    'Featured',
                    style: TextStyle(
                      color: AppColors.brand,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.brand,
                    ),
                    onPressed: onGoToSearch,

                    child: const Text('See all'),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final p = _featuredProducts[index];
                  return ProductWidget(
                    title: p['title'] as String,
                    category: p['category'] as String,
                    priceRsd: p['price'] as int,
                    imageUrl: p['image'] as String,
                  );
                },
                childCount: _featuredProducts.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
