import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink/model/models/veneu.dart';
import 'dart:convert';

const _api =
    "https://us-central1-sportlink-45001.cloudfunctions.net/venues/all";
const _header = {'content-type': 'application/json; charset=utf-8'};

Future<List<Venue>> get allVenues async {
  final res = await http.get(Uri.parse(_api), headers: _header);
  if (res.statusCode == 200) {
    final venues = (json.decode(res.body) as List);
    return venues.map((e) => Venue(e)).toList();
  } else {
    debugPrint("allVenues ${res.statusCode} /// ${res.body}");
    return [];
  }
}
