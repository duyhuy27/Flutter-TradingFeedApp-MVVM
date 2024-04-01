import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trading_news/Clours.dart';
import 'package:trading_news/functions/function.dart';
import 'package:trading_news/pages/home/details_news.dart';
import 'package:trading_news/view-model.dart/search_viewmodel.dart';

class ItemSmall extends StatelessWidget {
  final int index;
  final SearchViewModel searchViewModel;
  final String q;

  ItemSmall({
    Key? key,
    required this.index,
    required this.searchViewModel,
    required this.q,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchViewModel.fetchResultSearch(q, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
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
          return Center(
            child: Text('No data available'),
          );
        } else {
          final newsItem = snapshot.data!.articles[index];
          DateTime timestamp = newsItem.publishedAt;
          String timeAgo = '';

          if (timestamp != null) {
            var now = DateTime.now();
            var difference = now.difference(timestamp);

            if (difference.inMinutes < 60) {
              timeAgo = '${difference.inMinutes}m';
            } else if (difference.inHours < 24) {
              timeAgo = '${difference.inHours}h';
            } else {
              timeAgo = DateFormat('dd/MM').format(timestamp);
            }
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
                            image: NetworkImage(newsItem.urlToImage ?? ''),
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
                              newsItem.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              newsItem.source.name,
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
                                    Share.share(newsItem.url);
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
