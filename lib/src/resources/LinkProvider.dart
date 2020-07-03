import 'dart:io';

import 'package:getshareintent/getshareintent.dart';
import 'package:linkshare/src/models/SharedLink.dart';
import 'dart:async';

class LinkProvider {

  Future<SharedLink> getCurrentLink() async {
    var sharedLink = SharedLink();

    ShareIntent().onShareIntent.listen(
            (String value) {
                sharedLink.link = value;
        }
    );
    sharedLink.link = await ShareIntent().getShareIntent();

    if (sharedLink.link == null) {
      sharedLink.link = "No new link shared.";
    }

    return sharedLink;
  }

  Future<SharedLink> BackupGetCurrentLink() async {
    var previousLink;
    var sharedLink = SharedLink();

    ShareIntent().onShareIntent.listen(
            (String value) {
              if (value == null || value == previousLink) {
                sharedLink.link = value;
                previousLink = value;
              }
        }
    );

    if (sharedLink.link == null || sharedLink.link == previousLink) {
      sharedLink.link = await ShareIntent().getShareIntent();
    }

    if (sharedLink.link == null || sharedLink.link == previousLink) {
      sharedLink.link = "No new link shared.";
    }

    return sharedLink;
  }
}