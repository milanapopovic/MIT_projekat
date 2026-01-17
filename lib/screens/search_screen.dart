import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/products/products_state.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:fashion_app1/widgets/product_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
  _applyExternalQuery(); 
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

  List<Product> get _filteredProducts {
    final all = context.watch<ProductsState>().items;

    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return all;

    return all.where((p) {
      final title = p.title.toLowerCase();
      final cat = p.category.toLowerCase();
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
                      title: p.title,
                      category: p.category,
                      priceRsd: p.priceRsd,
                      imageUrl: p.imageUrl,
                      description: p.description,
                      sizes: p.sizes,
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
 
 
 
 
  