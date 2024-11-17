import 'dart:io';
import 'package:project/auth/auth.dart';
import 'package:project/screens/telaSplash.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }

  runApp(const MaterialApp(
    home: SplashPage(),
    debugShowCheckedModeBanner: false,
  ));

  await fetchSpotifyToken();

  if (accessToken != null) {
    await fetchArtist(accessToken!);
  } else {
    debugPrint('Não foi possível obter o token de acesso.');
  }
}
