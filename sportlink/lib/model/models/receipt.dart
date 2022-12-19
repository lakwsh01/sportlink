import './base/db_key.dart';
import './base/locale_content.dart';
import './base/base_model.dart';

class Receipt extends BaseModel {
  final String sender;
  final String receiver;
  final String game;
  final LocaleContent localeContent;

  const Receipt._(
      {required this.game,
      required this.receiver,
      required this.sender,
      required super.id,
      required super.metadata,
      required this.localeContent});

  factory Receipt(Map receipt) {
    final LocaleContent content =
        LocaleContent(receipt[ReceiptDBKey.localeContent.key]);
    return Receipt._(
        game: receipt[ReceiptDBKey.game.key],
        receiver: receipt[ReceiptDBKey.receiver.key],
        sender: receipt[ReceiptDBKey.sender.key],
        localeContent: content,
        id: receipt[dbKeyId],
        metadata: receipt[dbKeyMetaData]);
  }

  @override
  Map get json => throw UnimplementedError();

  @override
  Function(Map) get update => throw UnimplementedError();
}
