import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/screens/mainscree.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  List images = [];
  int page = 0;

  fetchapi() async {
    http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          'Authorization':
              "UV2toqr8P6Vogi8XzQLL09905MCL1jbs5ivtHZ86BwzzQV48VPjWqbOK"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });

    String url =
        "https://api.pexels.com/v1/curated?per_page=80&page=" + page.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          "UV2toqr8P6Vogi8XzQLL09905MCL1jbs5ivtHZ86BwzzQV48VPjWqbOK"
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpaper App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MainScreen(
                            imageurl: images[index]['src']['large2x']);
                      }));
                    },
                    child: Container(
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 25,
            width: double.infinity,
            child: TextButton(onPressed: loadMore, child: Text("Load More")),
          )
        ],
      ),
    );
  }
}
