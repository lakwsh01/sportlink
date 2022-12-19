import 'package:flutter/material.dart';
import 'package:sportlink/demo/field_rule.dart';
import 'package:sportlink/model/model.dart';
import 'package:sportlink/static/style/standard_layout.dart';
import 'package:sportlink/ui/view/game_apply/field_rule_view.dart';
import 'package:sportlink/ui/widget/condition_label.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GameDetailViewFront extends StatelessWidget {
  final Game game;
  const GameDetailViewFront({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
            padding: const EdgeInsets.only(top: 0, bottom: 140),
            children: [
              Container(
                  height: 200,
                  child: Image.network(
                      "https://c.pxhere.com/photos/86/37/badminton_virtual_crafts-1209913.jpg!d",
                      fit: BoxFit.cover)),
              Stack(children: [
                Container(
                    padding: standardAppbarPadding,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: ConditionLabel(label: "自動確認")),
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.headline5,
                                  children: [
                                TextSpan(text: "2022 - 11 - 24"),
                                TextSpan(text: "\n"),
                                TextSpan(text: "11:00 - 13:00"),
                                TextSpan(text: "\n"),
                                TextSpan(text: "鰂魚涌體育館 7號場"),
                                TextSpan(text: "\n"),
                                TextSpan(text: "將軍澳運隆路9號"),
                                TextSpan(text: "\n"),
                                TextSpan(text: "Ball: RSL Ultimate"),
                                TextSpan(text: "\n"),
                                TextSpan(text: "Total: 7人"),
                                TextSpan(text: "\n"),
                                TextSpan(text: "Vacancy: 4人"),
                                TextSpan(text: "\n"),
                                TextSpan(text: "Game Mode: 單打 雙打")
                              ]))
                        ])),
                Positioned(
                    right: 12,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12))),
                        margin: EdgeInsets.zero,
                        child: Container(
                            padding: EdgeInsets.all(12),
                            child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: "PRICE\n",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              decoration:
                                                  TextDecoration.underline)),
                                  TextSpan(
                                      text: "55",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium)
                                ]),
                                textAlign: TextAlign.center))))
              ]),
              Padding(
                  padding: standardAppbarPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("參與者要求"),
                        Row(children: [
                          Text("性別: "),
                          Wrap(spacing: 6, children: [
                            ConditionLabel(label: "男士"),
                            ConditionLabel(label: "女士")
                          ])
                        ]),
                        Row(children: [
                          Text("程度: "),
                          Wrap(spacing: 6, children: [
                            ConditionLabel(label: "初級"),
                            ConditionLabel(label: "中級")
                          ])
                        ]),
                        Row(children: [
                          Text("程度: "),
                          Wrap(spacing: 6, children: [
                            ConditionLabel(label: "初級"),
                            ConditionLabel(label: "中級")
                          ])
                        ])
                      ])),
              Padding(
                  padding: standardAppbarPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [Text("場主檔案")])),
              Padding(
                  padding: standardAppbarPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [Text("曾經同場既場次")])),
              Padding(
                  padding: standardAppbarPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [Text("隣近場次")]))
            ]));
  }
}
