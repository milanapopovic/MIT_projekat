import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:fashion_app1/widgets/product_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {
  final ValueListenable<String> queryListenable;
  const SearchScreen({super.key, required this.queryListenable});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  static const String _zws = '\u200B'; // nevidljiv znak

 
  final List<String> _suggestions = const [
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
    //zamena za bazu
  final List<Map<String, dynamic>> _products = const [  
    // jeans
  {
    'title': 'Light Oversized Jeans',
    'category': 'jeans',
    'price': 3990,
    'image': 'https://wrogn.com/cdn/shop/files/1_4eb49f58-8131-4749-b63b-2a3573424b64.jpg?v=1749124959',
  },
  {
    'title': 'Dark Straight Jeans',
    'category': 'jeans',
    'price': 4399,
    'image': 'https://uspoloassn.in/cdn/shop/files/1_b53772c0-f28b-44c6-9faf-bbea1879d148.jpg',
  },

  // pants
  {
    'title': 'Wide Leg Pants',
    'category': 'pants',
    'price': 3590,
    'image': 'https://i.pinimg.com/736x/00/c3/42/00c342bbe436bd8c41ea37fd28548807.jpg',
  },
  {
    'title': 'Classic Black Pants',
    'category': 'pants',
    'price': 3290,
    'image': 'https://images-na.ssl-images-amazon.com/images/I/61-tmSOVLxL._AC_UL600_SR600,600_.jpg',
  },
  // t-shirts
  {
    'title': 'White Basic T-shirt',
    'category': 't-shirts',
    'price': 1299,
    'image': 'https://notbasics.co.uk/cdn/shop/files/26_4c8dc6a5-a545-4010-8a84-f737ba609bd4.png?v=1753189939&width=1660',
  },
  {
    'title': 'Graphic T-shirt',
    'category': 't-shirts',
    'price': 1599,
    'image': 'https://cdn.shopify.com/s/files/1/1367/5211/files/LiftingGraphicOversizedT-Shirt-GSDarkGrey-B6A3X-GB7H-1681_2bafce22-caed-4e80-92c5-0b0f5818138d.jpg?v=1695117251',
  },

  // tops
  {
    'title': 'Ribbed Crop Top',
    'category': 'tops',
    'price': 1490,
    'image': 'https://ivyreina.com/cdn/shop/products/e5d779d9549e49e8b0f95c877f2341f8-Max.jpg?v=1660243486&width=1340',
  },
  {
    'title': 'Satin Cami Top',
    'category': 'tops',
    'price': 1890,
    'image': 'https://outfitbook.fr/cdn/shop/products/Top_20beige_20en_20satin_20col_20b_C3_A9nitier_2afa5afe-aa71-49b1-9a92-9604767c2ad5.jpg?v=1701783576',
  },

  // jackets
  {
    'title': 'Denim Jacket',
    'category': 'jackets',
    'price': 5999,
    'image': 'https://www.cottontraders.com/on/demandware.static/-/Sites-cotton-master-catalog/default/dwf3457617/images/original/AD12222W_original_neutral_stonewash_574653.jpg',
  },
  {
    'title': 'Leather Jacket',
    'category': 'jackets',
    'price': 7499,
    'image': 'https://cdn-img.prettylittlething.com/d/0/5/c/d05ce0575efebd32600b944c37a62f77cb183f6f_cnj4215_1.jpg?imwidth=600',
  },

  // dresses
  {
    'title': 'Summer Midi Dress',
    'category': 'dresses',
    'price': 4999,
    'image': 'https://www.lulus.com/images/product/xlarge/11626201_2382031.jpg?w=375&hdpi=1',
  },
  {
    'title': 'Black Evening Dress',
    'category': 'dresses',
    'price': 6999,
    'image': 'https://itsmilla.com/cdn/shop/products/24_1_9e0e5e41-d567-449d-a7d5-aea28cfc97af-746336.jpg?v=1740052504',
  },

  // skirts
  {
    'title': 'Mini Skirt',
    'category': 'skirts',
    'price': 2799,
    'image': 'https://static.e-stradivarius.net/assets/public/a5d4/96af/5353437086a6/373d4a8780ed/04799768400-c1/04799768400-c1.jpg?ts=1765978360125&w=1300&f=auto',
  },
  {
    'title': 'Pleated Skirt',
    'category': 'skirts',
    'price': 3199,
    'image': 'https://i0.wp.com/thewanderinggirl.com/wp-content/uploads/2024/08/edaowofashion_1711472828_3332398071562965274_332633503.jpg?resize=819%2C1024&ssl=1',
  },

  // shoes
  {
    'title': 'White Sneakers',
    'category': 'shoes',
    'price': 5499,
    'image': 'https://static.reserved.com/media/catalog/product/cache/1200/a4e40ebdc3e371adff845072e1c73f37/4/9/498FF-00X-002-1-1062000_5.jpg',
  },
  {
    'title': 'Black Ankle Boots',
    'category': 'shoes',
    'price': 7999,
    'image': 'https://www.bocage.eu/media/catalog/product/8/3/832861_10.jpg?optimize=medium&bg-color=255,255,255&fit=bounds&height=1820&width=1560&canvas=1560:1820',
  },

  // bags
  {
    'title': 'Mini Shoulder Bag',
    'category': 'bags',
    'price': 3499,
    'image': 'https://www.mzwallace.com/cdn/shop/files/1786B1902_black_mini_chelsea_shoulder_A10_b6ebf8d4-a619-4575-bdb9-b53271ad64cb.jpg?v=1733854154&width=3840',
  },
  {
    'title': 'Tote Bag',
    'category': 'bags',
    'price': 2999,
    'image': 'https://i.etsystatic.com/21162700/r/il/9f866a/5897671982/il_570xN.5897671982_oy76.jpg',
  },

  // hoodies
  {
    'title': 'Oversized Hoodie',
    'category': 'hoodies',
    'price': 3999,
    'image': 'https://m.media-amazon.com/images/I/61glUTGQnUL._AC_UY1000_.jpg',
  },
  {
    'title': 'Zip Hoodie',
    'category': 'hoodies',
    'price': 4299,
    'image': 'https://xcdn.next.co.uk/common/items/default/default/itemimages/3_4Ratio/product/lge/B65730s.jpg?im=Resize,width=750',
  },

  // sweaters
  {
    'title': 'Knit Sweater',
    'category': 'sweaters',
    'price': 3899,
    'image': 'https://cdn11.bigcommerce.com/s-scgdirr/images/stencil/685x900/products/27711/151180/ML905_-_Natural_White_1__35035.1758101559.jpg?c=2',
  },
  {
    'title': 'Turtleneck Sweater',
    'category': 'sweaters',
    'price': 4199,
    'image': 'https://cdn.shopify.com/s/files/1/0739/8984/9407/files/arlette_0011451022_olive_green_2495.jpg?v=1722446375',
  },

  // coats
  {
    'title': 'Long Wool Coat',
    'category': 'coats',
    'price': 8999,
    'image': 'https://cdn-img.prettylittlething.com/d/b/6/7/db67fcee753326989dd37d83d72707ffe0346a8d_CNN6567_1_light_grey_double_breasted_oversized_structured_coat.jpg?imwidth=600',
  },
  {
    'title': 'Beige Trench Coat',
    'category': 'coats',
    'price': 10999,
    'image': 'https://i.etsystatic.com/18546251/r/il/be7da6/4712909437/il_fullxfull.4712909437_tgfm.jpg',
  },

  // blazers
  {
    'title': 'Classic Blazer',
    'category': 'blazers',
    'price': 6499,
    'image': 'https://allthingsgolden.com/cdn/shop/files/THE-LINEN-CLASSIC-BLAZER-BLACK-2.jpg?v=1739225325',
  },
  {
    'title': 'Oversized Blazer',
    'category': 'blazers',
    'price': 6999,
    'image': 'https://www.beginningboutique.co.nz/cdn/shop/files/LoganTanOversizedBlazer-1.jpg?v=1738597456',
  },

  // shorts
  {
    'title': 'Denim Shorts',
    'category': 'shorts',
    'price': 2599,
    'image': 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1652978481-.jpg?crop=0.891xw:1.00xh;0.109xw,0&resize=980:*',
  },
  {
    'title': 'Linen Shorts',
    'category': 'shorts',
    'price': 2899,
    'image': 'https://fanfarelabel.com/cdn/shop/files/Beau_Linen_Bermuda_Shorts_in_Beige_No5_900x.jpg?v=1732723886',
  },

  // accessories
  {
    'title': 'Gold Hoop Earrings',
    'category': 'accessories',
    'price': 999,
    'image': 'https://cdn.sanity.io/images/cj884rht/production/94bac59c6ddee64f7834f151a1491a45ecd69681-1600x2000.jpg',
  },
  {
    'title': 'Black Belt',
    'category': 'accessories',
    'price': 1199,
    'image': 'https://thursdayboots.com/cdn/shop/products/Straight_Classic_Black_Womens_1_1_1024x1024.jpg?v=1573053543',
  },
];


  
  List<String> get _productNames =>
      _products.map((p) => p['title'] as String).toList();

  String _query = '';

  void _applyExternalQuery() {
    final q = widget.queryListenable.value.trim();
    _controller.text = q;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: q.length),
    );
    setState(() => _query = q);
}


  @override
void initState() {
  super.initState();
  _controller = TextEditingController();
  _focusNode = FocusNode();

  widget.queryListenable.addListener(_applyExternalQuery);
  _applyExternalQuery(); // odmah učitaj ako je Home poslao query
}


  @override
  void dispose() {
   widget.queryListenable.removeListener(_applyExternalQuery);
  _controller.dispose();
  _focusNode.dispose();
  super.dispose();
  }

  
  Iterable<String> _optionsFor(String text) {
    final q = text.trim().toLowerCase();
    if (q.isEmpty) return _suggestions;
    return _suggestions.where((s) => s.toLowerCase().startsWith(q));
  }

  List<Map<String, dynamic>> get _filteredProducts {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _products;

    return _products.where((p) {
      final title = (p['title'] as String).toLowerCase();
      final cat = (p['category'] as String).toLowerCase();

      return title.contains(q) || cat.startsWith(q);
    }).toList();
  }

  void _clear() {
    FocusScope.of(context).unfocus();
    _controller.clear();
    setState(() => _query = '');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const BrandAppBarTitle(title: 'Fashion Store'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RawAutocomplete<String>(
                textEditingController: _controller,
                focusNode: _focusNode,
            optionsBuilder: (value) {
              final q = value.text.trim().toLowerCase();

              if (q.isEmpty) return _suggestions;

              return _suggestions.where((c) => c.toLowerCase().startsWith(q));
            },


                onSelected: (selection) {
                  setState(() {
                    _query = selection;
                    _controller.text = selection;
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: selection.length),
                    );
                  });
                  FocusScope.of(context).unfocus();
                },
                fieldViewBuilder: (context, controller, focusNode, _) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: _clear,
                        icon: const Icon(Icons.clear),
                        color: AppColors.brand,
                      ),
                      filled: true,
                      fillColor: AppColors.brandSoft,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.brandLine),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.brandBorder),
                      ),
                    ),
                    onChanged: (value) => setState(() => _query = value),
                    onTap: () {
                      setState(() {});
                    },
                  );
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 220),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: options.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final opt = options.elementAt(index);
                            return ListTile(
                              dense: true,
                              title: Text(opt),
                              onTap: () => onSelected(opt),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              Text(
                'Results',
                style: TextStyle(
                  color: AppColors.brand,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: GridView.builder(
                  itemCount: _filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75, 
                  ),
                  itemBuilder: (context, index) {
                    final p = _filteredProducts[index];

                    return ProductWidget(
                      title: p['title'] as String,
                      category: p['category'] as String,
                      priceRsd: p['price'] as int,
                      imageUrl: p['image'] as String,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
 
 
 
  