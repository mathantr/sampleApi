import 'dart:convert';

import 'package:http/http.dart';
import 'package:testproject/model/model.dart';
import 'package:http/http.dart' as http;

class ApiService{

  Future<BankHoliday> getUserDetails() async{
    const url = 'https://www.gov.uk/bank-holidays.json';
    Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);
    BankHoliday bankHoliday = BankHoliday.fromJson(jsonResponse); // Parse JSON to Weather object
    return bankHoliday;
    }else{
      print('failed');
      throw Exception('Failed to load user details');
    }
  }}