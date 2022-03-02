import 'dart:convert';

import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AprovarReprovarAPI {
  Future<Map<String, dynamic>> buscaDetalhes(
      String applicationID, String operationID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //print('ApID ' + applicationID);
    //print('OpID ' + operationID);
    var url = Uri.parse(
        'http://83.240.225.239:130/api/OperationData?ApplicationID=$applicationID&OperationID=$operationID');
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    
    var response = await http.get(url, headers: header);
    Map<String, dynamic> userMap = jsonDecode(response.body);
  
    return userMap;
  }
  //Fim da função pegar os detalhes da operação

  Future<String> buscaPdf(String operationID, String contentID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://83.240.225.239:130/api/File?OperationID=$operationID&ContentID=$contentID');
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    var response = await http.get(url, headers: header);
    return jsonDecode(response.body).toString();
  }
}
