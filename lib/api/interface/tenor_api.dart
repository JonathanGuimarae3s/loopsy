import 'dart:ffi';

import '../../model/gif.dart';

abstract class TenorApi {
  Future<List<Gif>> pesquisarGifs(String text,bool next);

  Future<List<Gif>> retornarTodosGifs();

  Future<List<Gif>> retornaDadosPosteriores(String text);
}
