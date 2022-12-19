import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/main.dart';
import 'package:sportlink/ui/view/user/detail_view/single_line_profile_detail.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_title.dart';
import 'package:sportlink/ui/widget/editor/option_selector.dart';
import 'package:sportlink/ui/widget/editor/single_line_text_editor.dart';

const List<String> genders = ["male", "female", "ntdc"];

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const contentPrefix = "profile";

    return Scaffold(
        appBar: AppbarWithTitle(title: "$contentPrefix.title".tr()),
        body: ListView(padding: const EdgeInsets.all(8), children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text("$contentPrefix.description".tr(),
                  style: Theme.of(context).textTheme.bodySmall)),
          const SizedBox(height: 12),
          SingleLineProfileDetail.text(
              contentPrefix.tr(gender: "display_name_label"), "Lam Kwong Shun",
              (String value) {
            debugPrint("New 顯示名稱: $value");
          }),
          SingleLineProfileDetail.text(
              contentPrefix.tr(gender: "display_id_label"), "lakwsh01"),
          SingleLineProfileDetail.phone(
              contentPrefix.tr(gender: "display_phone_label"), "+852 68510182"),
          SingleLineProfileDetail.phone(
              contentPrefix.tr(gender: "display_whatsapp_label"),
              "+852 68510182"),
          SingleLineProfileDetail.option(
              contentPrefix.tr(gender: "display_gender_label"),
              "male",
              "genders",
              genders, (String id) {
            debugPrint("New Sex Id::: $id");
          })
        ]));
  }
}
