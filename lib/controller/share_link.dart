import 'package:share_plus/share_plus.dart';

void shareLink(link) async {
    await Share.share(link);
  }