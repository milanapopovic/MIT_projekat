import 'dart:math';

import 'package:fashion_app1/products/products_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminProductFormScreen extends StatefulWidget {
  final Product? existing;
  const AdminProductFormScreen({super.key, this.existing});

  @override
  State<AdminProductFormScreen> createState() => _AdminProductFormScreenState();
}

class _AdminProductFormScreenState extends State<AdminProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _category;
  late final TextEditingController _price;
  late final TextEditingController _imageUrl;
  late final TextEditingController _description;

  final List<String> _sizes = [];
  final TextEditingController _sizeCtrl = TextEditingController();

  bool _showOnHome = false;

  @override
  void initState() {
    super.initState();
    final p = widget.existing;

    _title = TextEditingController(text: p?.title ?? '');
    _category = TextEditingController(text: p?.category ?? '');
    _price = TextEditingController(text: p?.priceRsd.toString() ?? '');
    _imageUrl = TextEditingController(text: p?.imageUrl ?? '');
    _description = TextEditingController(text: p?.description ?? '');

    _showOnHome = p?.showOnHome ?? false;

    _sizes.clear();
    if (p != null) {
      _sizes.addAll(
        p.sizes
            .whereType<String>()
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .map((e) => e.toUpperCase()),
      );
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _category.dispose();
    _price.dispose();
    _imageUrl.dispose();
    _description.dispose();
    _sizeCtrl.dispose();
    super.dispose();
  }

  String _genId() =>
      'p${DateTime.now().millisecondsSinceEpoch}${Random().nextInt(999)}';

  void _addSize() {
    final v = _sizeCtrl.text.trim().toUpperCase();
    if (v.isEmpty) return;
    if (_sizes.contains(v)) {
      _sizeCtrl.clear();
      return;
    }
    setState(() => _sizes.add(v));
    _sizeCtrl.clear();
  }

  void _resetSizesToDefault() {
    final cat = _category.text.trim();
    final defaults = ProductsState.defaultSizesForCategory(cat);

    setState(() {
      _sizes
        ..clear()
        ..addAll(
          defaults
              .whereType<String>()
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .map((e) => e.toUpperCase()),
        );
    });
  }

  void _save() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final price = int.tryParse(_price.text.trim()) ?? 0;
    final existing = widget.existing;

    final product = Product(
      id: existing?.id ?? _genId(),
      title: _title.text.trim(),
      category: _category.text.trim(),
      priceRsd: price,
      imageUrl: _imageUrl.text.trim(),
      description: _description.text.trim(),
      sizes: List<String>.from(_sizes),
      showOnHome: _showOnHome,
    );

    final state = context.read<ProductsState>();
    if (existing == null) {
      state.add(product);
    } else {
      state.update(product);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit product' : 'Add product'),
        actions: [
          TextButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _category,
                  decoration:
                      const InputDecoration(labelText: 'Category (e.g. jeans)'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show on Home'),
                  value: _showOnHome,
                  onChanged: (v) => setState(() => _showOnHome = v),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Sizes',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _resetSizesToDefault,
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Default'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                if (_sizes.isEmpty)
                  const Text(
                    'No sizes (e.g. bags/accessories)',
                    style: TextStyle(color: Colors.black54),
                  )
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _sizes
                        .where((s) => s.trim().isNotEmpty)
                        .map(
                          (s) => Chip(
                            label: Text(s),
                            onDeleted: () => setState(() => _sizes.remove(s)),
                          ),
                        )
                        .toList(),
                  ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _sizeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Add size (e.g. S, M, 38)',
                        ),
                        onSubmitted: (_) => _addSize(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 90,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _addSize,
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _price,
                  decoration: const InputDecoration(labelText: 'Price (RSD)'),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    final n = int.tryParse((v ?? '').trim());
                    if (n == null || n <= 0) return 'Enter a valid price';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _imageUrl,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _description,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 4,
                ),

                const SizedBox(height: 18),

                ElevatedButton(
                  onPressed: _save,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
