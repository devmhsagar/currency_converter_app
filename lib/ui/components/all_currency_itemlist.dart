import 'package:currency_converter/model/currency_model.dart';
import 'package:flutter/material.dart';
class AllCurrencyListItem extends StatelessWidget {
  final CurrencyModel currencyModel;
  const AllCurrencyListItem({super.key, required this.currencyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(88),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            style: const TextStyle(fontSize: 17, color: Colors.white),
            "${currencyModel.code}",
          ),
          const SizedBox(width: 8,),
          Text(
            style: const TextStyle(fontSize: 17, color: Colors.white),
            "${currencyModel.value?.toStringAsFixed(2)}",
          ),
        ],
      ),
    );
  }
}
