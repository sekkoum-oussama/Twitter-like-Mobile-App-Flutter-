import 'package:flutter/material.dart';

class RetweetsListEmpty extends StatelessWidget {
  const RetweetsListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 80),
        child: const Text("No one reposted this tweet", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),),
      ),
    );
  }
}