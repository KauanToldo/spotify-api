import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String? accessToken;

Future<void> fetchSpotifyToken() async {
  try {
    String clientId = '2e67095dda894d169f443f229e05d052';
    String clientSecret = '3f39cbd9d5724a0595be54e99af738fd';

    String credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));

    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      accessToken = data['access_token'];
      debugPrint('Access Token: $accessToken');
    } else {
      debugPrint('Erro na autenticação: ${response.statusCode}');
      debugPrint('Resposta: ${response.body}');
    }
  } catch (e) {
    debugPrint('Erro: $e');
  }
}

Future<void> fetchArtist(String token) async {
  final response = await http.get(
    Uri.parse('https://api.spotify.com/v1/artists/1vCWHaC5f2uS3yhpwWbIA6'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    debugPrint('Artista: ${response.body}');
  } else {
    debugPrint('Erro: ${response.statusCode} - ${response.body}');
  }
}
