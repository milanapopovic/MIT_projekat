import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart/cart_state.dart';
import '../orders/orders_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _postalCodeCtrl = TextEditingController(); 

  final _cardNameCtrl = TextEditingController();
  final _cardNumberCtrl = TextEditingController();
  final _cardExpCtrl = TextEditingController();
  final _cardCvvCtrl = TextEditingController();

  DeliveryMethod _delivery = DeliveryMethod.standard;
  PaymentMethod _payment = PaymentMethod.cashOnDelivery;

  bool _placing = false;

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _postalCodeCtrl.dispose();

    _cardNameCtrl.dispose();
    _cardNumberCtrl.dispose();
    _cardExpCtrl.dispose();
    _cardCvvCtrl.dispose();
    super.dispose();
  }

  int _deliveryFeeRsd(int subtotal) {
    if (_delivery == DeliveryMethod.pickup) return 0;
    if (_delivery == DeliveryMethod.express) return 450;
    return subtotal >= 8000 ? 0 : 300;
  }

  String _deliveryMethodString() {
    switch (_delivery) {
      case DeliveryMethod.standard:
        return "standard";
      case DeliveryMethod.express:
        return "express";
      case DeliveryMethod.pickup:
        return "pickup";
    }
  }

  String _paymentMethodString() {
    switch (_payment) {
      case PaymentMethod.cashOnDelivery:
        return "cash";
      case PaymentMethod.card:
        return "card";
    }
  }

  String _formatPrice(int price) {
    final s = price.toString();
    if (s.length <= 3) return s;
    final head = s.substring(0, s.length - 3);
    final tail = s.substring(s.length - 3);
    return "$head $tail";
  }

  Future<void> _placeOrder() async {
    final cart = context.read<CartState>();
    if (cart.isEmpty) return;

    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    setState(() => _placing = true);
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    final subtotal = cart.totalRsd;
    final deliveryFee = _deliveryFeeRsd(subtotal);
    final total = subtotal + deliveryFee;

    final lines = cart.items
        .map(
          (it) => OrderLine(
            title: it.title,
            category: it.category,
            priceRsd: it.priceRsd,
            imageUrl: it.imageUrl,
            qty: it.qty,
            size: it.size,
          ),
        )
        .toList();

    context.read<OrdersState>().addOrder(
          subtotalRsd: subtotal,
          deliveryFeeRsd: deliveryFee,
          totalRsd: total,
          deliveryMethod: _deliveryMethodString(),
          paymentMethod: _paymentMethodString(),
          lines: lines,
        );

    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Order placed"),
        content: Text(
          _payment == PaymentMethod.card
              ? "Payment successful (simulated).\n\nTotal: ${_formatPrice(total)} RSD"
              : "You chose cash on delivery.\n\nTotal: ${_formatPrice(total)} RSD",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    cart.clear();

    if (!mounted) return;

    Navigator.pop(context);

    setState(() => _placing = false);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartState>();

    if (cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: const Center(child: Text("Cart is empty.")),
      );
    }

    final subtotal = cart.totalRsd;
    final deliveryFee = _deliveryFeeRsd(subtotal);
    final total = subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _SectionCard(
                    title: "Contact & shipping",
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _fullNameCtrl,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: "Full name",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              final s = (v ?? "").trim();
                              if (s.isEmpty) return "Required";
                              if (s.length < 3) return "Too short";
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: "Phone",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              final s = (v ?? "").trim();
                              if (s.isEmpty) return "Required";
                              if (s.length < 6) return "Invalid phone";
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              final s = (v ?? "").trim();
                              if (s.isEmpty) return "Required";
                              final okEmail =
                                  RegExp(r"^\S+@\S+\.\S+$").hasMatch(s);
                              if (!okEmail) return "Invalid email";
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _addressCtrl,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: "Address",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              final s = (v ?? "").trim();
                              if (s.isEmpty) return "Required";
                              if (s.length < 5) return "Too short";
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _cityCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: "City",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) {
                                    final s = (v ?? "").trim();
                                    if (s.isEmpty) return "Required";
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _postalCodeCtrl,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    labelText: "Postal code",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) {
                                    final s = (v ?? "").trim();
                                    if (s.isEmpty) return "Required";
                                    if (s.length < 4) return "Invalid";
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  _SectionCard(
                    title: "Delivery",
                    child: Column(
                      children: [
                        RadioListTile<DeliveryMethod>(
                          value: DeliveryMethod.standard,
                          groupValue: _delivery,
                          onChanged: (v) => setState(() => _delivery = v!),
                          title: const Text("Standard"),
                          subtitle: Text(
                            subtotal >= 8000
                                ? "Free (over 8000 RSD)"
                                : "300 RSD",
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<DeliveryMethod>(
                          value: DeliveryMethod.express,
                          groupValue: _delivery,
                          onChanged: (v) => setState(() => _delivery = v!),
                          title: const Text("Express"),
                          subtitle: const Text("450 RSD"),
                          contentPadding: EdgeInsets.zero,
                        ),
                        
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _SectionCard(
                    title: "Payment",
                    child: Column(
                      children: [
                        RadioListTile<PaymentMethod>(
                          value: PaymentMethod.cashOnDelivery,
                          groupValue: _payment,
                          onChanged: (v) => setState(() => _payment = v!),
                          title: const Text("Cash on delivery"),
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<PaymentMethod>(
                          value: PaymentMethod.card,
                          groupValue: _payment,
                          onChanged: (v) => setState(() => _payment = v!),
                          title: const Text("Pay with card"),
                          subtitle: const Text("Frontend demo (simulated)"),
                          contentPadding: EdgeInsets.zero,
                        ),

                        if (_payment == PaymentMethod.card) ...[
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _cardNameCtrl,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: "Name on card",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              final s = (v ?? "").trim();
                              if (s.isEmpty) return "Required";
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _cardNumberCtrl,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: "Card number",
                              hintText: "1234 5678 9012 3456",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              final s =
                                  (v ?? "").replaceAll(" ", "").trim();
                              if (s.isEmpty) return "Required";
                              if (s.length < 12) return "Too short";
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _cardExpCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: "MM/YY",
                                    hintText: "08/27",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) {
                                    final s = (v ?? "").trim();
                                    if (s.isEmpty) return "Required";
                                    if (!RegExp(r"^\d{2}\/\d{2}$")
                                        .hasMatch(s)) {
                                      return "Use MM/YY";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _cardCvvCtrl,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    labelText: "CVV",
                                    hintText: "123",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) {
                                    final s = (v ?? "").trim();
                                    if (s.isEmpty) return "Required";
                                    if (s.length < 3) return "Invalid";
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _SectionCard(
                    title: "Order summary",
                    child: Column(
                      children: [
                        ...cart.items.map(
                          (it) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${it.title}\nQty: ${it.qty}${it.size != null ? " | Size: ${it.size}" : ""}",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "${_formatPrice(it.subtotal)} RSD",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        _SummaryRow(
                          label: "Subtotal",
                          value: "${_formatPrice(subtotal)} RSD",
                        ),
                        const SizedBox(height: 6),
                        _SummaryRow(
                          label: "Delivery",
                          value: "${_formatPrice(deliveryFee)} RSD",
                        ),
                        const SizedBox(height: 10),
                        _SummaryRow(
                          label: "Total",
                          value: "${_formatPrice(total)} RSD",
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black12)),
              ),
              child: SizedBox(
                height: 46,
                width: double.infinity,
                child: FilledButton(
                  onPressed: _placing ? null : _placeOrder,
                  child: _placing
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Place order"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DeliveryMethod { standard, express, pickup }
enum PaymentMethod { cashOnDelivery, card }

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500)),
        const Spacer(),
        Text(value,
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.w900 : FontWeight.w700)),
      ],
    );
  }
}
