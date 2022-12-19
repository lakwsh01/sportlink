import 'package:flutter/material.dart';
import 'package:sportlink/demo/game.dart';
import 'package:sportlink/demo/profile_snap.dart';
import 'package:sportlink/model/models/game.dart';
import 'package:sportlink/model/models/base/profile_snap.dart';
import 'package:sportlink/service/venue/get_all_venue.dart';
import 'package:sportlink/state/property.dart';
import 'package:sportlink/ui/view/game_create/game_create_view.dart';
import 'package:sportlink/ui/view/game_detail/game_detail_view.dart';
import 'package:sportlink/ui/view/game_explore/game_explore_mapview.dart';
import 'package:sportlink/ui/view/game_explore/game_explore_view.dart';
import 'package:sportlink/ui/view/index/index_view.dart';
import 'package:sportlink/ui/widget/editor/option_selector.dart';
import 'package:sportlink/ui/widget/editor/venue_selector.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class StandardDebugView extends StatefulWidget {
  const StandardDebugView({super.key});

  @override
  State<StandardDebugView> createState() => _StandardDebugViewState();
}

class _StandardDebugViewState extends State<StandardDebugView> {
  @override
  Widget build(BuildContext context) {
    final state = RM.get<Property>().state;
    // return GameCreatorView();
    return TreeSelector(
        levels: const ["zones", "districts", "venues"],
        onNextLevelSetter: (nextLevel, currentLevel, updateCallback) {
          if (currentLevel == "zones") {
            final newOptions = state.districts(nextLevel);
            if (newOptions.length == 1) {
              final venues = state.venuesAt(newOptions.keys.first);
              updateCallback.call(venues, true);
            } else {
              updateCallback.call(state.districts(nextLevel), false);
            }
          } else if (currentLevel == "districts") {
            final venues = state.venuesAt(nextLevel);
            updateCallback.call(venues, true);
          }
        },
        onConfirm: (String option) {},
        initOptions: RM.get<Property>().state.zones(),
        title: "title");
    // return Scaffold(
    //   body: Center(
    //       child: ElevatedButton(
    //           onPressed: () {
    //             final state = RM.get<Property>().state;
    //             debugPrint("countries::: ${state.countries.toString()}");
    //             debugPrint("zone::: ${state.zone().toString()}");
    //             debugPrint("province::: ${state.provinces().toString()}");
    //             debugPrint("province::: ${state.districts("nt").toString()}");
    //           },
    //           child: Text("GET VENUES"))),
  }
}
