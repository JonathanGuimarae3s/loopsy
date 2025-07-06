import 'package:share_plus/share_plus.dart';

class Gif {
  Gif({required this.url});

  Gif.fromJson(Map<dynamic, dynamic> json) : url = json['url'];

  String url;

  void compartilhamento (){
    SharePlus.instance.share(
      ShareParams(text: 'Veja esse gif maravilhoso!\n$url'),
    );
  }
}
