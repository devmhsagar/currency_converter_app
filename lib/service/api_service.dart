import 'dart:convert';

import 'package:currency_converter/constants/constants.dart';
import 'package:currency_converter/model/currency_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  Future<List<CurrencyModel>> getLatest(String baseCurrency)async{
    List<CurrencyModel> currencyModelList = [];

    String url = "${base_url}apikey=$apikey&base_currency=$baseCurrency";

    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final Map<String, dynamic> json = jsonDecode(response.body);
        final Map<String, dynamic> body = json['data'];
        body.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          currencyModelList.add(currencyModel);
        });
        return currencyModelList;
      }else{
        return [];
      }
    }catch(e){
      print(e.toString());
      throw e.toString();
    }
  }

  Future<List<CurrencyModel>> getExchange(String baseCurrency, String targetCurrency)async{
    List<CurrencyModel> currencyModelList = [];

    String url = "${base_url}apikey=$apikey&base_currency=$baseCurrency&currencies=$targetCurrency";

    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final Map<String, dynamic> json = jsonDecode(response.body);
        final Map<String, dynamic> body = json['data'];
        body.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          currencyModelList.add(currencyModel);
        });
        return currencyModelList;
      }else{
        return [];
      }
    }catch(e){
      print(e.toString());
      throw e.toString();
    }
  }

}