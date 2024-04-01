import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trading_news/Clours.dart';
import 'package:trading_news/functions/function.dart';
import 'package:trading_news/pages/home/details_news.dart';
import 'package:trading_news/view-model.dart/news_viewmodel.dart';

class ItemSmall extends StatelessWidget {
  final int index;
  final NewsViewModel newsViewModel;
  final String category;

  ItemSmall({
    Key? key,
    required this.index,
    required this.newsViewModel,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, String> publishedTimes = {};
    return FutureBuilder(
      future: newsViewModel.fetchNewsLatest(category, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitCircle(
              size: 50,
              color: Colors.blue,
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
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

          String domain = FunctionGol.getDomainFromUrl(newsItem.url ?? '');

          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailsNews(url: newsItem.url.toString())));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          image: DecorationImage(
                            image: NetworkImage(newsItem.imageurl ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newsItem.title.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              newsItem.source.toString(),
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                color: Clours.primary,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        domain,
                                        style: GoogleFonts.openSans(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      Icon(
                                        Icons.circle,
                                        color: Colors.grey,
                                        size: 5,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        timeAgo,
                                        style: GoogleFonts.openSans(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Handle share button
                                    Share.share(newsItem.url.toString());
                                  },
                                  icon: Icon(Icons.share, size: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
