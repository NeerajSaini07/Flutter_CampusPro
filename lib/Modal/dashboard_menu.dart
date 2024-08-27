class DashboardMenulist {
  static List<Dashboardmenumodel> dashboardMenulistdetails = [];
}

class Dashboardmenumodel {
  int menuID;
  String menuName;
  String menuURL;
  int menuOrder;
  String imageUrl;
  String flag;
  String userType;

  Dashboardmenumodel({
    required this.menuID,
    required this.menuName,
    required this.menuURL,
    required this.menuOrder,
    required this.imageUrl,
    required this.flag,
    required this.userType,
  });

  factory Dashboardmenumodel.fromJson(Map<String, dynamic> json) {
    return Dashboardmenumodel(
      menuID: json['MenuID'],
      menuName: json['MenuName'],
      menuURL: json['MenuURL'],
      menuOrder: json['MenuOrder'],
      imageUrl: json['ImageUrl'],
      flag: json['Flag'],
      userType: json['UserType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MenuID': menuID,
      'MenuName': menuName,
      'MenuURL': menuURL,
      'MenuOrder': menuOrder,
      'ImageUrl': imageUrl,
      'Flag': flag,
      'UserType': userType,
    };
  }
}
