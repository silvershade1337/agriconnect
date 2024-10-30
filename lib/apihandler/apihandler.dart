import 'package:agriconnect/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

const APIBaseURL = "http://10.100.55.216:3000/api";


Future login(String emailorphone, String password) async {
  var body = {
    "password": password
  };
  if (emailorphone.contains("@")) {
    body['email'] = emailorphone;
  }
  else {
    body['phoneNo'] = emailorphone;
  }
  var response = await dio.post(APIBaseURL+"/users/login", data: body);
  return response;
}

Future register(String username, String emailorphone, String password) async {
  var body = {
    "username": username,
    "password": password,

  };
  if (emailorphone.contains("@")) {
    body['email'] = emailorphone;
  }
  else {
    body['phoneNo'] = emailorphone;
  }
  var response = await dio.post(APIBaseURL+"/users/register", data: body);
  return response;
}


Future<List> getCrops() async {
  print("get crops");
  final response = await dio.get("$APIBaseURL/crops");
  return response.data["data"];
}


Future<List> getTransports() async {
  print("get transport");
  final response = await dio.get("$APIBaseURL/transporters");
  return response.data["data"];
}

Future<List> getStorages() async {
  print("get storages");
  final response = await dio.get("$APIBaseURL/storages");
  return response.data["data"];
}

Future<List> getLands() async {
  print("get lands");
  final response = await dio.get("$APIBaseURL/lands");
  return response.data["data"];
}


Future<List<ProdServViewDetails>> getCropsViewDetails() async {
  print("get crops");
  final response = await dio.get("$APIBaseURL/crops");
  var d = response.data["data"];
  List<ProdServViewDetails> psvds = [];
  for (var data in d) {
    ProdServViewDetails psv = ProdServViewDetails(headline: data['cropType'].toString() + " for Sale", description: "Quanitity Available: ${data['availableQuantity'].toString()}, Price: ${data['price'].toString()}", city: data['place'].toString(), postedby: data['seller'].toString());
    psvds.add(psv);
    print(psv);
  }
  return psvds;
}


Future<List<ProdServViewDetails>> getTransportsViewDetails() async {
  print("get transport");
  final response = await dio.get("$APIBaseURL/transporters");
  var d = response.data["data"];
  List<ProdServViewDetails> psvds = [];
  for (var data in d) {
    ProdServViewDetails psv = ProdServViewDetails(headline: data['vechicleType'].toString() + " for hire", description: "Charge per km: ${data['chargePerKm'].toString()}, Contact: ${data['phoneNo'].toString()}", city: data['addr'].toString(), postedby: data['driverName'].toString());
    psvds.add(psv);
    print(psv);
  }
  return psvds;
}

Future<List<ProdServViewDetails>> getStoragesViewDetails() async {
  print("get storages");
  final response = await dio.get("$APIBaseURL/storages");
  var d = response.data["data"];
  List<ProdServViewDetails> psvds = [];
  for (var data in d) {
    ProdServViewDetails psv = ProdServViewDetails(headline: data['name'].toString(), description: "Daily Rent: ${data['rentPerDay'].toString()}", city: data['city'].toString(), postedby: data['owner'].toString());
    psvds.add(psv);
    print(psv);
  }
  return psvds;
}

Future<List<ProdServViewDetails>> getLandsViewDetails() async {
  print("get lands");
  final response = await dio.get("$APIBaseURL/lands");
  var d = response.data["data"];
  List<ProdServViewDetails> psvds = [];
  for (var data in d) {
    ProdServViewDetails psv = ProdServViewDetails(headline: "${data['acres'].toString()} Acres Land", description: "Price per acre: ${data['pricePerAcre'].toString()}", city: data['city'].toString(), postedby: data['ownedBy'].toString());
    psvds.add(psv);
    print(psv);
  }
  return psvds;
}

