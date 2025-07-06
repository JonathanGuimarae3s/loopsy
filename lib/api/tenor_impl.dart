import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:loopsy/api/interface/tenor_api.dart';
import 'package:loopsy/model/gif.dart';

class TenorImpl implements TenorApi {
  final String key = 'AIzaSyAwX4tVAsekkjVkKiSBEfU65Pn-Em19D3s';
  final String country = 'BR';
  final String locale = 'pt_BR';
  final String client_key = 'loopsy';
  final String scheme = 'https';
  final String host = 'tenor.googleapis.com';
  late Uri uri;
  late String next;

  @override
  Future<List<Gif>> pesquisarGifs(String text, bool next) async {
    Map<String, dynamic> queryParameters = {
      'q': text,
      'key': key,
      'client_key': client_key,
      'country': country,
      'locale': locale,
      'limit': '9',
    };

    montaUrl('v2/search', queryParameters);
    List<Gif> gifList = [];

    if (next) {
      gifList = await retornaDadosPosteriores(text);
      return gifList;
    }

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      retornaGifLista(response, gifList);
    }

    return gifList;
  }

  @override
  Future<List<Gif>> retornarTodosGifs() async {
    Map<String, dynamic> queryParameters = {
      'key': key,
      'client_key': client_key,
      'country': country,
      'locale': locale,
      'limit': '50',
    };

    montaUrl('v2/featured', queryParameters);

    final response = await http.get(uri);
    List<Gif> gifList = [];

    if (response.statusCode == 200) {
      retornaGifLista(response, gifList);
    }

    return gifList;
  }

  @override
  Future<List<Gif>> retornaDadosPosteriores(String text) async {
    Map<String, dynamic> queryParameters = {
      'q': text,
      'key': key,
      'client_key': client_key,
      'country': country,
      'locale': locale,
      'limit': '9',
      'pos': next
    };

    montaUrl('v2/search', queryParameters);

    final response = await http.get(uri);
    List<Gif> gifList = [];

    if (response.statusCode == 200) {
      retornaGifLista(response, gifList);
    }

    return gifList;
  }

  void retornaGifLista(http.Response response, List<Gif> gifList) {
    final data = json.decode(response.body);

    next = data['next'];

    List results = (data['results'] as List);

    int tamanho = results.length;

    for (int i = 0; i < tamanho; i++) {
      Gif gif = Gif(url: results[i]['media_formats']['mediumgif']['url']);
      gifList.add(gif);
    }
  }

  void montaUrl(String path, Map<String, dynamic> queryParameters) {
    uri = Uri(
      scheme: scheme,
      host: host,
      path: path,
      queryParameters: queryParameters,
    );
  }
}
