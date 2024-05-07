import 'package:flutter/material.dart';
import 'package:twitter_demo/home/presentation/widgets/media_from_network.dart';

class TweetMedia extends StatefulWidget {
  TweetMedia(this.tweet, {super.key});
  final tweet;

  @override
  State<TweetMedia> createState() => _TweetMediaState();
}

class _TweetMediaState extends State<TweetMedia> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: showTweetFiles(widget.tweet)
    );
  }

  Widget showTweetFiles(tweet) {
    if (tweet.media.length < 1) {
      return Container();
    }
   
    switch(tweet.media.length) {
      case 1:
        return OnePhoto(tweet);
      case 2:
        return TwoPhotos(tweet);
      case 3:
        return ThreePhotos(tweet);
      case 4:
        return FourPhotos(tweet);
    }
    
    return Container();
  }
}

class OnePhoto extends StatelessWidget {
  const OnePhoto(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.25,
          maxHeight: MediaQuery.of(context).size.height * 0.60,
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":0}),
          child: Hero(tag: tweet.media[0]["file"], child: MediaFromNetwork(tweet.media[0]))
        ),
    );
  }
}


class TwoPhotos extends StatelessWidget {
  const TwoPhotos(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.15,
        maxHeight: MediaQuery.of(context).size.height * 0.25,
      ),
      child:  Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":0}),
          child: Hero(tag: tweet.media[0]["file"], child: MediaFromNetwork(tweet.media[0]))
        ),
            ),
            const SizedBox(width: 3,),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":1}),
                child: Hero(tag: tweet.media[1]["file"], child: MediaFromNetwork(tweet.media[1]))
              ),
            ),
          ],
        ),
      
    );
  }
}


class ThreePhotos extends StatelessWidget {
  const ThreePhotos(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.10,
        maxHeight: MediaQuery.of(context).size.height * 0.25,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":0}),
                    child: Hero(tag: tweet.media[0]["file"], child: MediaFromNetwork(tweet.media[0]))
                  ),
                ),
                const SizedBox(height: 4,),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":1}),
                    child: Hero(tag: tweet.media[1]["file"], child: MediaFromNetwork(tweet.media[1]))
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4,),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":2}),
              child: Hero(tag: tweet.media[2]["file"], child: MediaFromNetwork(tweet.media[2]))
            ),
          )
        ],
      ),
    );
  }
}

/*
class FourPhotos extends StatelessWidget {
  const FourPhotos(this.media, {super.key});
  final List<Map> media;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.10,
        maxHeight: MediaQuery.of(context).size.height * 0.35,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        childAspectRatio: 1.5,
        children: media.map((photo) => Image.network(photo['file'], fit: BoxFit.cover,), ).toList(),
        ),
    );
  }
}
*/
class FourPhotos extends StatelessWidget {
  const FourPhotos(this.tweet, {super.key});
  final tweet;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.10,
        maxHeight: MediaQuery.of(context).size.height * 0.30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":0}),
                    child: Hero(tag: tweet.media[0]["file"], child: MediaFromNetwork(tweet.media[0]))
                  ),
                ),
                const SizedBox(height: 4,),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":1}),
                    child: Hero(tag: tweet.media[1]["file"], child: MediaFromNetwork(tweet.media[1]))
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":2}),
                    child: Hero(tag: tweet.media[2]["file"], child: MediaFromNetwork(tweet.media[2]))
                  ),
                ),
                const SizedBox(height: 4,),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/tweetMedia", arguments: {"tweet":tweet, "index":3}),
                    child: Hero(tag: tweet.media[3]["file"], child: MediaFromNetwork(tweet.media[3]))
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}