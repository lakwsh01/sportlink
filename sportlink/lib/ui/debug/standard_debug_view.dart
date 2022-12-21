import 'package:flutter/material.dart';
import 'package:sportlink/demo/field_rule.dart';
import 'package:sportlink/demo/game.dart';
import 'package:sportlink/demo/profile_snap.dart';
import 'package:sportlink/model/models/game.dart';
import 'package:sportlink/model/models/base/profile_snap.dart';
import 'package:sportlink/service/division/get_all_division.dart';
import 'package:sportlink/service/venue/get_all_venue.dart';
import 'package:sportlink/state/property.dart';
import 'package:sportlink/ui/view/game_create/game_create_view.dart';
import 'package:sportlink/ui/view/game_detail/game_detail_view.dart';
import 'package:sportlink/ui/view/game_explore/game_explore_mapview.dart';
import 'package:sportlink/ui/view/game_explore/game_explore_view.dart';
import 'package:sportlink/ui/view/index/index_view.dart';
import 'package:sportlink/ui/widget/editor/inline_text_editor.dart';

import 'package:sportlink/ui/widget/editor/option_selector.dart';
import 'package:sportlink/ui/widget/editor/tree_selector.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class StandardDebugView extends StatefulWidget {
  const StandardDebugView({super.key});

  @override
  State<StandardDebugView> createState() => _StandardDebugViewState();
}

class _StandardDebugViewState extends State<StandardDebugView> {
  @override
  Widget build(BuildContext context) {
    return GameCreatorView();
    // return InlineTextSpanEditor(
    //     title: "InlineTextSpanEditor", initialValues: fieldRulesDemo);

    // return Center(
    //     child: CustomPaint(
    //   size: Size(300, 300),
    //   painter: MyPainter(),
    // ));
  }
}
