
class CategoriesModel {
  bool? status;
  CtegoriesDataModel? data;
  CategoriesModel.fromjson(Map<String,dynamic>json){
    status = json['status'];
    data = CtegoriesDataModel.fromjson(json['data']);
  }
  }
class CtegoriesDataModel {
  int? CurrentPage ;
  List <CategoriesData>? categories = [];
  CtegoriesDataModel.fromjson(Map<String,dynamic>json){
    json['data'].forEach((elelment){
      categories?.add(CategoriesData.fromjson(elelment));
    });
    CurrentPage = json['current_page'];

  }
  }
class CategoriesData {
  int? id;
  String? name;
  String? image;
  CategoriesData.fromjson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}