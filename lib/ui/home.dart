import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_converter/model/currency_model.dart';
import 'package:currency_converter/service/api_service.dart';
import 'package:currency_converter/ui/components/all_currency_itemlist.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService apiService = ApiService();
  String _selectedCurrency = "USD";

  Widget _dropdownItem(Country country) => Container(
        child: Row(
          children: [
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(width: 2,),
            Text(
              "${country.currencyName}",
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children:  [
          const SizedBox(
            height: 8,
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
                  _selectedCurrency = country?.currencyCode ?? "";
                });
              },
            ),
          ),
          const SizedBox(height: 8,),
          const Text(
            "All Currencies",
          ),
          const SizedBox(height: 8,),
          FutureBuilder(builder: (context, snapshot) {
            if(snapshot.hasData){
              List<CurrencyModel> currencyModelList = snapshot.data ?? [];
              return Expanded(child: ListView.builder(
                itemCount: currencyModelList.length,
                itemBuilder: (context, index) {
                  return AllCurrencyListItem(currencyModel: currencyModelList[index]);
                },
              ));
            }
            if(snapshot.hasError){
              return const Text("error occurred", style: TextStyle(color: Colors.white,),);
            }
            return const Center(child: CircularProgressIndicator());
          }, future: apiService.getLatest(_selectedCurrency),),
        ],
      ),
    );
  }
}
