import 'package:trading_news/model/news/category_model.dart';

List<CategoryModel> getCategory() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.title = "Latest news";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "BITCOIN";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "ALTCOIN";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "SHIBA INU";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "ETH";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "BLOCKCHAIN";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "ICO";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "MINING";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "MARKET";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "EXCHANGE";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "OTHER";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "REGULATION";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "TECHNOLOGY";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "TRADING";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  return categories;
}

List<CategoryModel> getCategoryMarketCap() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.title = "Price indexes";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.title = "Market Analytics";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  return categories;
}
