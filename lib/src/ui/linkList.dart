import 'package:flutter/material.dart';
import '../models/SharedLink.dart';
import '../bloc/links_bloc.dart';
import 'dart:developer';
import 'dart:async';

class LinkList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LinkListState();
  }
}

class LinkListState extends State<LinkList> {
  List<String> _allLinks;

  @override
  void initState() {
    super.initState();
    asyncInit();
    setState(() {
      _allLinks = [];
    });
  }

  void asyncInit() async {
    await bloc.getLink();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.getLink();
  }

  @override
  void didUpdateWidget(LinkList oldWidget) {
    super.didUpdateWidget(oldWidget);
    bloc.getLink();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Shared Links')
      ),
      body: StreamBuilder(
        stream: bloc.links,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
//              _allLinks.add(snapshot.data.link)
            return buildString(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildString(String link) {
    return Text(link);
  }

  Widget buildList(List<String> list) {
    return ListView.builder(
        itemCount: _allLinks.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(list[index]);
        }
    );
  }
}

// TODO:  3) Try dependency injection