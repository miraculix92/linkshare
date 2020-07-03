import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:getshareintent/getshareintent.dart';
import 'package:http/http.dart';
import '../resources/LinkProvider.dart';
import 'package:rxdart/rxdart.dart';
import '../models/SharedLink.dart';

class LinkBloc {
  final _provider = LinkProvider();
  final _linkFetcher = PublishSubject<String>();

  Stream<String> get links => _linkFetcher.stream;

  LinkBloc() {
    getLink();
    ShareIntent().onShareIntent.listen(
        (String value) {
          if (value != null) {
            _linkFetcher.sink.add(value);
          }
        });

    // TODO: binding the stream directly into the new stream yields in correctly
    //  TODO: updated links through the stream but starting the app via a share
    //   TODO: does not deliver the initial link
  }

  getLink() async {
    String sharedLink = await ShareIntent().getShareIntent();
    if (sharedLink != null) {
      _linkFetcher.sink.add(sharedLink);
      sharedLink = null;
    }
    return;
  }

  dispose() {
    _linkFetcher.close();
  }
}

final bloc = LinkBloc();