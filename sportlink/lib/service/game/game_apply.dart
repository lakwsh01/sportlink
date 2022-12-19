import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportlink/model/model.dart';
import 'package:sportlink/model/models/application.dart';
import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/game.dart';
import 'package:sportlink/model/models/receipt.dart';
import 'package:uuid/uuid.dart';

Future<String> applyGame(Game game) async {
  String applicationId;
  final ref =
      FirebaseFirestore.instance.collection("game/${game.id}/application");
  do {
    final uuid = const Uuid().v4().split("-")[3];
    applicationId = "${game.id}#app-$uuid";
  } while ((await ref.doc(applicationId).get()).exists);

  final Map<String, dynamic> newApplication = {
    dbKeyId: applicationId,
    ApplicationDBKey.autoExpiry.key:
        DateTime.now().add(const Duration(days: 1)),
    ApplicationDBKey.game.key: game.id,
    ApplicationDBKey.localeContent.key:
        game.localeContent.json({LocaleContentDBKey.userName.key: "user_001"}),
    dbKeyMetaData: MetaData.newJson()
  };

  ref.doc(applicationId).set(newApplication);
  return applicationId;
}
