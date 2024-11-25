import 'package:path/path.dart';
import 'package:project/database/dao/db_query.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  String caminhoBanco =
      join(await getDatabasesPath(), 'bancodedadosfinalizado.db');

  return openDatabase(
    caminhoBanco,
    version: 1,
    onCreate: (db, version) {
      db.execute('CREATE TABLE usuarios('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'email TEXT, '
          'foto MEDIUMBLOB, '
          'nome TEXT, '
          'senha TEXT)');
      db.execute('CREATE TABLE music('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'nome TEXT, '
          'autor TEXT, '
          'capa TEXT, '
          'nomearquivo TEXT, '
          'tamanho INTEGER)');
      db.execute('CREATE TABLE playlist('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'nome TEXT, '
          'capa TEXT)');
      db.execute('CREATE TABLE playlist_music('
          'playlist_id INTEGER, '
          'music_id INTEGER, '
          'FOREIGN KEY(playlist_id) REFERENCES playlist(id), '
          'FOREIGN KEY(music_id) REFERENCES music(id), '
          'PRIMARY KEY (playlist_id, music_id))');

      insertDados();
    },
  );
}
