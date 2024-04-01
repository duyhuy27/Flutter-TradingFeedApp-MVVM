import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trading_news/Clours.dart';
import 'package:trading_news/functions/function.dart';
import 'package:trading_news/pages/home/details_news.dart';
import 'package:trading_news/view-model.dart/news_viewmodel.dart';

class ItemBig extends StatelessWidget {
  final int index;
  final NewsViewModel newsViewModel;
  final String selectedCategory;
  final Map<int, String> publishedTimes = {};

  ItemBig(
      {super.key,
      required this.index,
      required this.newsViewModel,
      required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: newsViewModel.fetchNewsLatest(selectedCategory, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitCircle(
              size: 50,
              color: Colors.blue,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('No data available'),
          );
        } else {
          final newsItem = snapshot.data!.data![index];
          int? timestamp = newsItem.publishedOn;
          String timeAgo = publishedTimes[timestamp] ?? '';

          if (timestamp != null && timeAgo.isEmpty) {
            var now = DateTime.now();
            var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
            var difference = now.difference(date);

            if (difference.inMinutes < 60) {
              timeAgo = '${difference.inMinutes} p';
            } else if (difference.inHours < 24) {
              timeAgo = '${difference.inHours} h';
            } else {
              timeAgo = DateFormat('dd/MM').format(date);
            }

            publishedTimes[timestamp] = timeAgo;
          } else if (timestamp != null && publishedTimes[timestamp] != null) {
            timeAgo = publishedTimes[timestamp]!;
          }

          String domain = FunctionGol.getDomainFromUrl(newsItem.guid ?? '');
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailsNews(url: newsItem.url.toString())));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 240,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: CachedNetworkImage(
                          imageUrl: newsItem.imageurl ?? '',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Card(
                        shadowColor: Colors.white,
                        surfaceTintColor: Clours.gray_dim,
                        color: Clours.primary,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "$timeAgo ago",
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  newsItem.title ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  newsItem.source.toString(),
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: Clours.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'by $domain',
                      style: GoogleFonts.openSans(
                        fontSize: 10,
                        color: Clours.gray_dim,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Share.share(newsItem.url.toString());
                          },
                          icon: const Icon(Icons.share, size: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
