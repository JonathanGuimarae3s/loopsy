import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loopsy/api/tenor_impl.dart';
import 'package:loopsy/pages/gif_page.dart';
import 'package:loopsy/widgets/circulo_progresso.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/gif.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String? search = null;
  late bool? next = false;
  final tenorImpl = TenorImpl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loopsy',
              style: GoogleFonts.fredoka(
                fontSize: 50,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            Image.network(
              'https://i.pinimg.com/originals/57/61/5b/57615b8c0092a66c1d4058b1692955cc.gif',
              height: 150,
            ),
          ],
        ),

        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Pesquise Aqui!',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
                onSubmitted: (text) {
                  setState(() {
                    search = text;
                    next = false;
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: search != null && search!.isNotEmpty
                    ? tenorImpl.pesquisarGifs(search!, next!)
                    : tenorImpl.retornarTodosGifs(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return CirculoProgresso();
                    default:
                      if (snapshot.hasError) {
                        return Container();
                      } else {
                        return _retornaTabelaDeGifs(context, snapshot);
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int retornaTamanhoDaLista(List gifList) {
    if (search == null || search == '') {
      return gifList.length;
    }

    return gifList.length + 1;
  }

  Widget _retornaTabelaDeGifs(BuildContext context, AsyncSnapshot snapshot) {
    List<Gif> gifList = snapshot.data;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: retornaTamanhoDaLista(gifList),
      itemBuilder: (context, index) {
        if (search == null || search == '' || index < gifList.length) {
          return GestureDetector(
            onLongPress: () {
              gifList[index].compartilhamento();
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GifPage(gifList[index]),
                ),
              );
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: gifList[index].url,
              height: 300,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              setState(() {
                next = true;
              });
            },
            onLongPress: () {
              gifList[index].compartilhamento();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 70.0),
                Text(
                  'Carregar mais...',
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
