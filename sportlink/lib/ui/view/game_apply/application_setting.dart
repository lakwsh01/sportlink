import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/model/model.dart';
import 'package:sportlink/static/style/standard_button_theme.dart';
import 'package:sportlink/ui/widget/time_range_picker/time_range_24h_picker.dart';
import 'package:sportlink/service/converter/converter.dart';
import 'package:permission_handler/permission_handler.dart';

const _sectionTitle = "game-apply";

class ApplicationSettingView extends StatefulWidget {
  const ApplicationSettingView({super.key});

  @override
  State<ApplicationSettingView> createState() => _ApplicationSettingViewState();
}

class _ApplicationSettingViewState extends State<ApplicationSettingView> {
  final Map<String, dynamic> applicationSetting = {
    ApplicationDBKey.autoExpiry.key: true,
    ApplicationDBKey.notification.key: true
  };

  final GlobalKey<LinerTimeRange24HourPickerState>
      linerTimeRange24HourPickerState = GlobalKey();

  void setContent<T>(ApplicationDBKey dbKey, T content) {
    applicationSetting[dbKey.key] = content;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(Icons.access_time_filled_rounded,
                    color: Colors.green)),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  RichText(
                      text: TextSpan(
                          text:
                              "${"$_sectionTitle.application-retrieve-time-title".tr()}\n",
                          style: Theme.of(context).textTheme.titleLarge,
                          children: [
                        ..."$_sectionTitle.application-retrieve-time-description"
                            .tr()
                            .split(textSpliter)
                            .map((e) => TextSpan(
                                text: e == "" ? " 11/22 18:30 " : e,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: e == ""
                                            ? FontWeight.w700
                                            : FontWeight.normal,
                                        color: e == "" ? Colors.orange : null)))
                            .toList()
                      ])),
                  GestureDetector(
                      onTap: () {
                        debugPrint("set cancel time called");
                      },
                      child: Container(
                          padding: EdgeInsets.only(bottom: 1),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.orange))),
                          child: Text(
                              "$_sectionTitle.application-retrieve-time-button"
                                  .tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.orange))))
                ]))
          ]),
      SizedBox(height: 24),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(Icons.notifications, color: Colors.green)),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  RichText(
                      text: TextSpan(
                          text:
                              "${"$_sectionTitle.game-accept-notification-title".tr()}\n",
                          style: Theme.of(context).textTheme.titleLarge,
                          children: [
                        TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            text:
                                "$_sectionTitle.game-accept-notification-description"
                                    .tr())
                      ])),
                  GestureDetector(
                      onTap: () async {
                        final status = await Permission.notification.status;
                        if (status.isDenied) {
                          // We didn't ask for permission yet or the permission has been denied before but not permanently.
                          debugPrint(
                              "notification permission handler isDenied");
                          final request =
                              await Permission.notification.request();
                          debugPrint("after request: $request");
                        } else {
                          debugPrint("notification permission handler passed");
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.only(bottom: 1),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.orange))),
                          child: Text(
                              "$_sectionTitle.game-accept-notification-button"
                                  .tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.orange))))
                ]))
          ]),
      SizedBox(height: 24),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(Icons.person, color: Colors.green)),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Text("$_sectionTitle.share-content-policy-title".tr(),
                      style: Theme.of(context).textTheme.titleLarge),
                  Text("$_sectionTitle.share-content-policy-description".tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.justify),
                  SizedBox(height: 6),
                  Row(children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(children: [
                          Icon(Icons.whatsapp, size: 18, color: Colors.white),
                          Text("special-label.whatsapp".tr(),
                              style: TextStyle(color: Colors.white))
                        ])),
                    SizedBox(width: 12),
                    Expanded(child: Text("+852 68510182")),
                  ]),
                  SizedBox(height: 6),
                  GestureDetector(
                      onTap: () {
                        debugPrint("set cancel time called");
                      },
                      child: Container(
                          padding: EdgeInsets.only(bottom: 1),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.orange))),
                          child: Text(
                              "$_sectionTitle.share-content-policy-button".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.orange))))
                ]))
          ])
    ]);
  }
}
