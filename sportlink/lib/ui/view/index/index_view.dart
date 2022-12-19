import 'package:flutter/material.dart';
import 'package:sportlink/ui/view/game_explore/game_explore_listview.dart';
import 'package:sportlink/ui/view/game_explore/game_explore_mapview.dart';
import 'package:sportlink/ui/view/user/profile_view.dart';
import 'package:sportlink/ui/view/user_game_record/user_game_record.dart';

class IndexViewBuilder extends StatefulWidget {
  const IndexViewBuilder({super.key});

  @override
  State<IndexViewBuilder> createState() => IndexViewBuilderState();
  static IndexViewBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<IndexViewBuilderState>();
  }
}

class IndexViewBuilderState extends State<IndexViewBuilder> {
  int index = 0;
  int gameListViewType = 0;

  void setIndex(int index) {
    this.index = index;
    setState(() {});
  }

  Widget get view {
    switch (index) {
      case 1:
        return UserGameRecordView(
            comingGames: [],
            myGames: [],
            pastGames: [],
            pendingApplication: [],
            rejectedApplication: []);
      case 2:
        return UserProfileView();
      case 0:
        if (gameListViewType == 0) {
          return GameExploreListView();
        } else {
          return GameExploreMapView();
        }

      default:
        return Scaffold(body: Center(child: Text("Center View")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          color: Colors.blueGrey,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                onPressed: () {
                  index = 0;
                  setState(() {});
                },
                icon: Icon(Icons.explore)),
            IconButton(
                onPressed: () {
                  index = 1;
                  setState(() {});
                },
                icon: Icon(Icons.access_time_filled_rounded)),
            IconButton(
                onPressed: () {
                  index = 2;
                  setState(() {});
                },
                icon: Icon(Icons.person))
          ]),
        ),
        body: view);
  }
}
