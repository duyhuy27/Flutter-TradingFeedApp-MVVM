import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trading_news/pages/search/components/item_search.dart';
import 'package:trading_news/view-model.dart/search_viewmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchViewModel searchViewModel = SearchViewModel();
  String query = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.08, // Set a specific height for the search bar
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (query.isNotEmpty) {
                            // Chỉ gọi API khi query không phải là null
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: query.isNotEmpty
                  ? FutureBuilder(
                      future: searchViewModel.fetchResultSearch(query, context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          final newsList = snapshot.data!.articles;

                          return ListView.builder(
                            itemCount: newsList.length,
                            itemBuilder: (context, index) {
                              return ItemSmall(
                                index: index,
                                searchViewModel: searchViewModel,
                                q: query,
                              );
                            },
                          );
                        }
                      },
                    )
                  : Container(), // Không có query, không cần gọi API
            ),
          ],
        ),
      ),
    );
  }
}
