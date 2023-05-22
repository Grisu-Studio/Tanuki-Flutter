import 'package:flutter/material.dart';
import 'models.dart';

class PillList extends StatelessWidget {
  final List<Pill> pills;

  const PillList({Key? key, required this.pills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: pills.length,
      itemBuilder: (BuildContext context, int index) {
        final pill = pills[index];

        return Card(
          child: ListTile(
            title: Text(pill.name),
            subtitle: Text(
                '${pill.time.hour}:${pill.time.minute} - Every ${pill.frequency} hours'),
          ),
        );
      },
    );
  }
}
