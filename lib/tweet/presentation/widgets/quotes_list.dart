import 'package:flutter/material.dart';
import 'package:twitter_demo/home/data/models/quote_tweet_model.dart';
import 'package:twitter_demo/home/presentation/widgets/quote_tweet_widget.dart';
import 'package:twitter_demo/tweet/presentation/widgets/quotes_list_empty.dart';


class QuotesListWidget extends StatelessWidget {
  const QuotesListWidget(this.quotes, {super.key});
  final List<QuoteTweetModel> quotes;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: const Text(
            "Quotes",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
        ),
        quotes.isEmpty ?
        const QuotesListEmpty()
        :
        SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index.isOdd) {
                  // Odd indices are the separators
                  return const Divider();
                } else {
                  // Even indices are the tweet widgets
                  final tweetIndex = (index / 2).floor();
                  return QuoteTweetWidget(quotes[tweetIndex]);
                }
              },
              childCount: quotes.length * 2 - 1,
            ),
        )
      ],
    );
  }
}