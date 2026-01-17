import 'package:flutter/foundation.dart';

class Product {
  final String id;
  String title;
  String category;
  int priceRsd;
  String imageUrl;
  String description;

  List<String> sizes;
  bool showOnHome;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.priceRsd,
    required this.imageUrl,
    required this.description,
    List<String>? sizes,
    this.showOnHome = false,
  }) : sizes = sizes ?? const [];
}

class ProductsState extends ChangeNotifier {
  static List<String> defaultSizesForCategory(String cat) {
    final c = cat.trim().toLowerCase();
    if (c == 'bags' || c == 'accessories') return [];
    if (c == 'jeans' || c == 'pants' || c == 'shorts') {
      return ['34', '36', '38', '40', '42', '44'];
    }
    if (c == 'shoes') {
      return ['36', '37', '38', '39', '40', '41'];
    }
    return ['XS', 'S', 'M', 'L', 'XL'];
  }

  final List<Product> _items = [
    // jeans
    Product(
      id: 'p1',
      title: 'Light Oversized Jeans',
      category: 'jeans',
      priceRsd: 3990,
      imageUrl:
          'https://wrogn.com/cdn/shop/files/1_4eb49f58-8131-4749-b63b-2a3573424b64.jpg?v=1749124959',
      description:
          'Relaxed-fit oversized jeans made from soft denim, perfect for everyday casual outfits.',
      sizes: defaultSizesForCategory('jeans'),
      showOnHome: true,
    ),
    Product(
      id: 'p2',
      title: 'Dark Straight Jeans',
      category: 'jeans',
      priceRsd: 4399,
      imageUrl:
          'https://uspoloassn.in/cdn/shop/files/1_b53772c0-f28b-44c6-9faf-bbea1879d148.jpg',
      description:
          'Classic straight-leg jeans in dark denim, easy to style for both casual and smart looks.',
      sizes: defaultSizesForCategory('jeans'),
      showOnHome: true,
    ),

    // pants
    Product(
      id: 'p3',
      title: 'Wide Leg Pants',
      category: 'pants',
      priceRsd: 3590,
      imageUrl:
          'https://i.pinimg.com/736x/00/c3/42/00c342bbe436bd8c41ea37fd28548807.jpg',
      description:
          'Wide-leg pants with a modern silhouette, offering comfort and effortless elegance.',
      sizes: defaultSizesForCategory('pants'),
    ),
    Product(
      id: 'p4',
      title: 'Classic Black Pants',
      category: 'pants',
      priceRsd: 3290,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/61-tmSOVLxL._AC_UL600_SR600,600_.jpg',
      description:
          'Timeless black pants with a clean cut, ideal for office wear and formal occasions.',
      sizes: defaultSizesForCategory('pants'),
    ),

    // t-shirts
    Product(
      id: 'p5',
      title: 'White Basic T-shirt',
      category: 't-shirts',
      priceRsd: 1299,
      imageUrl:
          'https://notbasics.co.uk/cdn/shop/files/26_4c8dc6a5-a545-4010-8a84-f737ba609bd4.png?v=1753189939&width=1660',
      description:
          'A classic white t-shirt made from soft cotton, a must-have essential for any wardrobe.',
      sizes: defaultSizesForCategory('t-shirts'),
    ),
    Product(
      id: 'p6',
      title: 'Graphic T-shirt',
      category: 't-shirts',
      priceRsd: 1599,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/1367/5211/files/LiftingGraphicOversizedT-Shirt-GSDarkGrey-B6A3X-GB7H-1681_2bafce22-caed-4e80-92c5-0b0f5818138d.jpg?v=1695117251',
      description:
          'Oversized graphic t-shirt with a bold print, perfect for a street-style look.',
      sizes: defaultSizesForCategory('t-shirts'),
    ),

    // tops
    Product(
      id: 'p7',
      title: 'Ribbed Crop Top',
      category: 'tops',
      priceRsd: 1490,
      imageUrl: 'https://gypsysoulshop.com/cdn/shop/files/7375eca22a2848c38e679eac5f07a431-Max_800x.jpg?v=1715353584',
      description:
          'Ribbed crop top with a flattering fit, ideal for summer outfits and layering.',
      sizes: defaultSizesForCategory('tops'),
    ),
    Product(
      id: 'p8',
      title: 'Satin Cami Top',
      category: 'tops',
      priceRsd: 1890,
      imageUrl:
          'https://outfitbook.fr/cdn/shop/products/Top_20beige_20en_20satin_20col_20b_C3_A9nitier_2afa5afe-aa71-49b1-9a92-9604767c2ad5.jpg?v=1701783576',
      description:
          'Elegant satin cami top with thin straps, perfect for evening and chic looks.',
      sizes: defaultSizesForCategory('tops'),
    ),

    // jackets
    Product(
      id: 'p9',
      title: 'Denim Jacket',
      category: 'jackets',
      priceRsd: 5999,
      imageUrl:
          'https://www.cottontraders.com/on/demandware.static/-/Sites-cotton-master-catalog/default/dwf3457617/images/original/AD12222W_original_neutral_stonewash_574653.jpg',
      description:
          'Classic denim jacket with a relaxed fit, perfect for transitional seasons.',
      sizes: defaultSizesForCategory('jackets'),
      showOnHome: true,
    ),
    Product(
      id: 'p10',
      title: 'Leather Jacket',
      category: 'jackets',
      priceRsd: 7499,
      imageUrl:
          'https://cdn-img.prettylittlething.com/d/0/5/c/d05ce0575efebd32600b944c37a62f77cb183f6f_cnj4215_1.jpg?imwidth=600',
      description: 'Stylish leather jacket that adds an edgy touch to any outfit.',
      sizes: defaultSizesForCategory('jackets'),
    ),

    // dresses
    Product(
      id: 'p11',
      title: 'Summer Midi Dress',
      category: 'dresses',
      priceRsd: 4999,
      imageUrl:
          'https://www.lulus.com/images/product/xlarge/11626201_2382031.jpg?w=375&hdpi=1',
      description:
          'Lightweight midi dress designed for warm days, feminine and comfortable.',
      sizes: defaultSizesForCategory('dresses'),
      showOnHome: true,
    ),
    Product(
      id: 'p12',
      title: 'Black Evening Dress',
      category: 'dresses',
      priceRsd: 6999,
      imageUrl:
          'https://itsmilla.com/cdn/shop/products/24_1_9e0e5e41-d567-449d-a7d5-aea28cfc97af-746336.jpg?v=1740052504',
      description:
          'Elegant black evening dress with a refined silhouette, perfect for special occasions.',
      sizes: defaultSizesForCategory('dresses'),
    ),

    // skirts
    Product(
      id: 'p13',
      title: 'Mini Skirt',
      category: 'skirts',
      priceRsd: 2799,
      imageUrl:
          'https://static.e-stradivarius.net/assets/public/a5d4/96af/5353437086a6/373d4a8780ed/04799768400-c1/04799768400-c1.jpg?ts=1765978360125&w=1300&f=auto',
      description:
          'Trendy mini skirt that adds a playful and stylish touch to your outfit.',
      sizes: defaultSizesForCategory('skirts'),
    ),
    Product(
      id: 'p14',
      title: 'Pleated Skirt',
      category: 'skirts',
      priceRsd: 3199,
      imageUrl:
          'https://i0.wp.com/thewanderinggirl.com/wp-content/uploads/2024/08/edaowofashion_1711472828_3332398071562965274_332633503.jpg?resize=819%2C1024&ssl=1',
      description:
          'Flowing pleated skirt with a timeless design, suitable for both casual and formal looks.',
      sizes: defaultSizesForCategory('skirts'),
    ),

    // shoes
    Product(
      id: 'p15',
      title: 'White Sneakers',
      category: 'shoes',
      priceRsd: 5499,
      imageUrl:
          'https://static.reserved.com/media/catalog/product/cache/1200/a4e40ebdc3e371adff845072e1c73f37/4/9/498FF-00X-002-1-1062000_5.jpg',
      description:
          'Comfortable white sneakers designed for everyday wear and versatile styling.',
      sizes: defaultSizesForCategory('shoes'),
    ),
    Product(
      id: 'p16',
      title: 'Black Ankle Boots',
      category: 'shoes',
      priceRsd: 7999,
      imageUrl:
          'https://www.bocage.eu/media/catalog/product/8/3/832861_10.jpg?optimize=medium&bg-color=255,255,255&fit=bounds&height=1820&width=1560&canvas=1560:1820',
      description:
          'Classic black ankle boots with a sleek design, ideal for colder seasons.',
      sizes: defaultSizesForCategory('shoes'),
    ),

    // bags 
    Product(
      id: 'p17',
      title: 'Mini Shoulder Bag',
      category: 'bags',
      priceRsd: 3499,
      imageUrl:
          'https://www.mzwallace.com/cdn/shop/files/1786B1902_black_mini_chelsea_shoulder_A10_b6ebf8d4-a619-4575-bdb9-b53271ad64cb.jpg?v=1733854154&width=3840',
      description:
          'Compact shoulder bag with a modern design, perfect for carrying essentials.',
      sizes: defaultSizesForCategory('bags'),
    ),
    Product(
      id: 'p18',
      title: 'Tote Bag',
      category: 'bags',
      priceRsd: 2999,
      imageUrl: 'https://i.etsystatic.com/21162700/r/il/9f866a/5897671982/il_570xN.5897671982_oy76.jpg',
      description: 'Spacious tote bag ideal for daily use, combining practicality and style.',
      sizes: defaultSizesForCategory('bags'),
    ),

    // hoodies
    Product(
      id: 'p19',
      title: 'Oversized Hoodie',
      category: 'hoodies',
      priceRsd: 3999,
      imageUrl: 'https://m.media-amazon.com/images/I/61glUTGQnUL._AC_UY1000_.jpg',
      description: 'Cozy oversized hoodie made for comfort, perfect for relaxed and casual outfits.',
      sizes: defaultSizesForCategory('hoodies'),
    ),
    Product(
      id: 'p20',
      title: 'Zip Hoodie',
      category: 'hoodies',
      priceRsd: 4299,
      imageUrl: 'https://xcdn.next.co.uk/common/items/default/default/itemimages/3_4Ratio/product/lge/B65730s.jpg?im=Resize,width=750',
      description: 'Zip-up hoodie with a sporty look, easy to layer and wear year-round.',
      sizes: defaultSizesForCategory('hoodies'),
    ),

    // sweaters
    Product(
      id: 'p21',
      title: 'Knit Sweater',
      category: 'sweaters',
      priceRsd: 3899,
      imageUrl:
          'https://cdn11.bigcommerce.com/s-scgdirr/images/stencil/685x900/products/27711/151180/ML905_-_Natural_White_1__35035.1758101559.jpg?c=2',
      description: 'Soft knit sweater that provides warmth while maintaining a stylish appearance.',
      sizes: defaultSizesForCategory('sweaters'),
    ),
    Product(
      id: 'p22',
      title: 'Turtleneck Sweater',
      category: 'sweaters',
      priceRsd: 4199,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0739/8984/9407/files/arlette_0011451022_olive_green_2495.jpg?v=1722446375',
      description: 'Classic turtleneck sweater designed for cold days and elegant layering.',
      sizes: defaultSizesForCategory('sweaters'),
    ),

    // coats
    Product(
      id: 'p23',
      title: 'Long Wool Coat',
      category: 'coats',
      priceRsd: 8999,
      imageUrl:
          'https://cdn-img.prettylittlething.com/d/b/6/7/db67fcee753326989dd37d83d72707ffe0346a8d_CNN6567_1_light_grey_double_breasted_oversized_structured_coat.jpg?imwidth=600',
      description: 'Long wool coat with a sophisticated cut, perfect for winter and formal wear.',
      sizes: defaultSizesForCategory('coats'),
    ),
    Product(
      id: 'p24',
      title: 'Beige Trench Coat',
      category: 'coats',
      priceRsd: 10999,
      imageUrl: 'https://i.etsystatic.com/18546251/r/il/be7da6/4712909437/il_fullxfull.4712909437_tgfm.jpg',
      description: 'Timeless beige trench coat that adds elegance to any outfit.',
      sizes: defaultSizesForCategory('coats'),
    ),

    // blazers
    Product(
      id: 'p25',
      title: 'Classic Blazer',
      category: 'blazers',
      priceRsd: 6499,
      imageUrl:
          'https://allthingsgolden.com/cdn/shop/files/THE-LINEN-CLASSIC-BLAZER-BLACK-2.jpg?v=1739225325',
      description: 'Tailored classic blazer suitable for professional and smart-casual looks.',
      sizes: defaultSizesForCategory('blazers'),
    ),
    Product(
      id: 'p26',
      title: 'Oversized Blazer',
      category: 'blazers',
      priceRsd: 6999,
      imageUrl:
          'https://www.beginningboutique.co.nz/cdn/shop/files/LoganTanOversizedBlazer-1.jpg?v=1738597456',
      description: 'Oversized blazer with a modern fit, perfect for trendy and relaxed styling.',
      sizes: defaultSizesForCategory('blazers'),
    ),

    // shorts
    Product(
      id: 'p27',
      title: 'Denim Shorts',
      category: 'shorts',
      priceRsd: 2599,
      imageUrl:
          'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1652978481-.jpg?crop=0.891xw:1.00xh;0.109xw,0&resize=980:*',
      description: 'Casual denim shorts ideal for summer days and relaxed outfits.',
      sizes: defaultSizesForCategory('shorts'),
    ),
    Product(
      id: 'p28',
      title: 'Linen Shorts',
      category: 'shorts',
      priceRsd: 2899,
      imageUrl:
          'https://fanfarelabel.com/cdn/shop/files/Beau_Linen_Bermuda_Shorts_in_Beige_No5_900x.jpg?v=1732723886',
      description: 'Lightweight linen shorts designed for comfort during warm weather.',
      sizes: defaultSizesForCategory('shorts'),
    ),

    // accessories 
    Product(
      id: 'p29',
      title: 'Gold Hoop Earrings',
      category: 'accessories',
      priceRsd: 999,
      imageUrl:
          'https://cdn.sanity.io/images/cj884rht/production/94bac59c6ddee64f7834f151a1491a45ecd69681-1600x2000.jpg',
      description: 'Minimalist gold hoop earrings that add a subtle elegant touch to any look.',
      sizes: defaultSizesForCategory('accessories'),
    ),
    Product(
      id: 'p30',
      title: 'Black Belt',
      category: 'accessories',
      priceRsd: 1199,
      imageUrl:
          'https://thursdayboots.com/cdn/shop/products/Straight_Classic_Black_Womens_1_1_1024x1024.jpg?v=1573053543',
      description: 'Classic black belt with a clean design, perfect for everyday styling.',
      sizes: defaultSizesForCategory('accessories'),
    ),
  ];

  List<Product> get items => List.unmodifiable(_items);
  List<Product> get homeItems => List.unmodifiable(_items.where((p) => p.showOnHome));
  void add(Product p) {
    _items.insert(0, p);
    notifyListeners();
  }

  void update(Product updated) {
    final i = _items.indexWhere((x) => x.id == updated.id);
    if (i == -1) return;
    _items[i] = updated;
    notifyListeners();
  }

  void delete(String id) {
    _items.removeWhere((x) => x.id == id);
    notifyListeners();
  }
}
