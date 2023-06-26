import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class MainScreen extends StatefulWidget {
  final String imageurl;
  const MainScreen({super.key, required this.imageurl});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> setwallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var File = await DefaultCacheManager().getSingleFile(widget.imageurl);
    await WallpaperManager.setWallpaperFromFile(File.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Image.network(widget.imageurl),
            ),
          ),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  setwallpaper();
                },
                child: Text("set home Screen")),
          )
        ],
      ),
    );
  }
}
