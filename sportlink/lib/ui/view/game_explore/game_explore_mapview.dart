import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sportlink/demo/game.dart';
import 'package:sportlink/model/model.dart';
import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/base/profile_snap.dart';
import 'package:sportlink/model/models/game.dart';
import 'package:sportlink/ui/view/game_detail/game_detail_view.dart';
import 'package:sportlink/ui/widget/map_button.dart';
import 'package:sportlink/service/converter/converter.dart';

class GameExploreMapView extends StatefulWidget {
  const GameExploreMapView({super.key});

  @override
  State<GameExploreMapView> createState() => _GameExploreMapViewState();
}

class _GameExploreMapViewState extends State<GameExploreMapView> {
  int bottomSheetStatus = 0;
  @override
  Widget build(BuildContext context) {
    final List<Game> games = [
      gameDemo,
      gameDemo,
      gameDemo,
      gameDemo,
      gameDemo,
      gameDemo
    ].map((e) => Game(game: e, id: e[dbKeyId] as String)).toList();
    return Scaffold(
        body: Stack(children: [
      Container(
          alignment: Alignment.center,
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  zoom: 15, target: LatLng(22.3226228, 114.1888593)))),
      Positioned(
          top: 24,
          left: 0,
          child:
              Container(padding: EdgeInsets.all(8), child: Icon(Icons.clear))),
      Positioned(
          bottom: 120,
          right: 12,
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            MapViewIconButton(
                icon: Icons.list,
                onTap: () {
                  bottomSheetStatus = 1;
                  setState(() {});
                }),
            const SizedBox(height: 12),
            MapViewIconButton(icon: Icons.filter_alt, onTap: () {}),
            const SizedBox(height: 12),
            MapViewIconButton(
              icon: Icons.my_location,
              onTap: () {},
              backgroundColor: Colors.amberAccent.shade700,
            )
          ])),
      AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          width: MediaQuery.of(context).size.width,
          height: 80,
          top: bottomSheetStatus == 0 ? -100 : 0,
          left: 0,
          child: AppBar(leading: BackButton(onPressed: () {
            bottomSheetStatus = 0;
            setState(() {});
          }))),
      AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          bottom: bottomSheetStatus == 0
              ? -MediaQuery.of(context).size.height + 160
              : 0,
          height: MediaQuery.of(context).size.height - 80,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
              onVerticalDragStart: (s) {
                if (bottomSheetStatus == 0) {
                  bottomSheetStatus = 1;
                  setState(() {});
                }
              },
              onTap: () {
                if (bottomSheetStatus == 0) {
                  bottomSheetStatus = 1;
                  setState(() {});
                }
              },
              child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: bottomSheetStatus == 0
                      ? const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        )
                      : const RoundedRectangleBorder(),
                  margin: bottomSheetStatus == 0
                      ? const EdgeInsets.symmetric(horizontal: 12)
                      : EdgeInsets.zero,
                  child: GameMapViewList(
                      games: games, scrollActive: bottomSheetStatus != 0))))
    ]));
  }
}

class GameMapViewList extends StatelessWidget {
  final List<Game> games;
  final bool scrollActive;
  const GameMapViewList(
      {required this.scrollActive, required this.games, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleMedium;
    return ListView.builder(
        physics: scrollActive
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        itemCount: games.length + 1,
        itemBuilder: ((context, index) {
          if (index == 0) {
            return RichText(
                text: TextSpan(
                    style: textTheme?.copyWith(color: Colors.grey[800]),
                    children: [
                  const TextSpan(text: "有 "),
                  TextSpan(
                    text: "${games.length}",
                    style: textTheme?.copyWith(color: Colors.deepOrange),
                  ),
                  const TextSpan(text: " 個活動等緊你報名")
                ]));
          } else {
            final g = games.elementAt(index - 1);
            return GameMapViewCard(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => GameDetailView(
                          profileSnap: ProfileSnap(profileSnapDemo), game: g)));
                },
                game: g);
          }
        }));
  }
}

class GameMapViewCard extends StatelessWidget {
  final VoidCallback onTap;
  final Game game;
  const GameMapViewCard({required this.onTap, required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
            margin: EdgeInsets.all(12),
            child: Container(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Wrap(spacing: 5, children: [
                          Chip(label: Text("即時確認")),
                          Chip(label: Text("-${game.vacancy}"))
                        ]),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelLarge,
                                children: [
                              TextSpan(
                                  text:
                                      "${game.period.start.format("dd - mm")} (星期四)"),
                              TextSpan(text: "\n"),
                              TextSpan(
                                  text:
                                      "${game.period.start.format("hh : mn")} - ${game.period.end.format("hh : mn")}")
                            ])),
                        Text(game.localeContent.title)
                      ])),
                  Text("\$${game.price.ceil()}",
                      style: Theme.of(context).textTheme.headlineMedium)
                ]))));
  }
}
