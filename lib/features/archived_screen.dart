import 'package:flutter/material.dart';


class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => const Placeholder(),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 10,
    );
  }
}
