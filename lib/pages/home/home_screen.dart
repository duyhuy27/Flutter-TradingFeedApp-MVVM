import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trading_news/data.dart';
import 'package:trading_news/model/news/category_model.dart';
import 'package:trading_news/pages/home/components/category_tab.dart';
import 'package:trading_news/pages/home/components/item_big.dart';
import 'package:trading_news/pages/home/components/item_small.dart';
import 'package:trading_news/pages/home/components/title_app_bar.dart';
import 'package:trading_news/view-model.dart/news_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  String selectedCategory = "Latest news"; // Biến lưu trữ danh mục được chọn
  NewsViewModel newsViewModel = NewsViewModel();
  Map<int, String> publishedTimes =
      {}; // Sử dụng Map để lưu trữ thời gian đã đăng
  bool isNewsLatest = true;

  Future<void> _refresh() async {
    try {
      await newsViewModel.fetchNewsLatest(selectedCategory, context);
      // Cập nhật dữ liệu khi làm mới thành công
    } catch (e) {
      // Xử lý lỗi khi làm mới không thành công
      print('Error refreshing data: $e');
    }
  }

  @override
  void initState() {
    categories = getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBar(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                    height: height * 0.05,
                    child: CategoryTab(
                      categories: categories,
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    )),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if ((index + 1) % 3 == 0 && index != 0) {
                      return ItemBig(
                          index: index,
                          newsViewModel: newsViewModel,
                          selectedCategory: selectedCategory);
                    } else {
                      return ItemSmall(
                          index: index,
                          newsViewModel: newsViewModel,
                          category: selectedCategory);
                    }
                  },
                  childCount: categories.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Hàm để lấy thời gian đã đăng

const spinKit2 = SpinKitFadingCircle(
  color: Colors.blue,
  size: 50,
);
