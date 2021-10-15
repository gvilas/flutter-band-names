import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bands_name/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late List<Band> bands = [];

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      bands.add(Band(id: i.toString(), name: "Band $i", votes: 0));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names'),
      ),
      body: Center(
          child: ListView.separated(
              itemCount: bands.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) =>
                  _bandListItem(context, bands[index]))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandListItem(BuildContext contex, Band band) {
    return Dismissible(
        key: Key(band.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          this.bands.remove(band);
        },
        background: Container(
            padding: EdgeInsets.only(left: 8.0),
            color: Colors.red,
            child: Align(
                alignment: Alignment.centerLeft, 
                child: Text('Delete Band'))),
        child: ListTile(
          leading: CircleAvatar(child: Text(band.name.substring(0, 2))),
          title: Text(band.name),
          trailing: Text(band.votes.toString()),
        ));
  }

  addNewBand() {
    final textController = TextEditingController();

    /*if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('New Band Name'),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text('Add'),
                  onPressed: () => addBandToList(textController.text),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }*/

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Band Name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                  child: Text('Add'),
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text))
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.isNotEmpty) {
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
      Navigator.pop(context);
    } else {}
  }
}
