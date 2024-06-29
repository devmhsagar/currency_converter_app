import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:currency_converter/service/api_service.dart';
import 'package:flutter/material.dart';
class Exchange extends StatefulWidget {
  const Exchange({super.key});

  @override
  State<Exchange> createState() => _ExchangeState();
}

class _ExchangeState extends State<Exchange> {
  ApiService apiService = ApiService();
  String _selectedBaseCurrency = "USD";
  String _selectedTargetCurrency = "USD";
  String _totalValue = "";
  final TextEditingController _textEditingController = TextEditingController();

  Widget _dropdownItem(Country country) => Row(
    children: [
      CountryPickerUtils.getDefaultFlagImage(country),
      const SizedBox(width: 2,),
      Text(
        "${country.currencyName}",
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Base Currency',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 3, top: 10, bottom: 10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CountryPickerDropdown(
            initialValue: 'us',
            itemBuilder: _dropdownItem,
            onValuePicked: (Country? country) {
              setState(() {
                _selectedBaseCurrency = country?.currencyCode ?? "";
              });
            },
          ),
        ),
        SizedBox( height: 15,),
        SizedBox(
          width: 300,
          child: TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            textAlign:  TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled:  true,
              hintText: 'Enter Amount',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 15,
        ),
        const Text(
          'Target Currency',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 3, top: 10, bottom: 10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CountryPickerDropdown(
            initialValue: 'us',
            itemBuilder: _dropdownItem,
            onValuePicked: (Country? country) {
              setState(() {
                _selectedTargetCurrency = country?.currencyCode ?? "";
              });
            },
          ),
        ),
        SizedBox(height: 15,),

      ElevatedButton(onPressed: ()async{
        if(_textEditingController.text.isNotEmpty){
           await apiService.getExchange( _selectedBaseCurrency, _selectedTargetCurrency).then((result){
             double value = double.parse(_textEditingController.text);
             double exchangeRate = double.parse(result[0].value.toString());
             double total = value * exchangeRate;
             _totalValue = total.toStringAsFixed(2).toString();
             setState(() {

             });
           });
        }

      }, child: Text('Exchange'),),
        SizedBox(height: 15,),
        Text(_totalValue+" "+_selectedTargetCurrency, style: TextStyle(fontSize: 60, color: Colors.tealAccent),),
      ],
    );
  }
}
