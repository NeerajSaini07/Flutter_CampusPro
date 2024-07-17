class MenuItemList {
  static List<DrawerMenu> menuItemDetails = [];
}

class SubMenuItemList {
  static List<DrawerSubMenu> subMenuItemDetails = [];
}

class DrawerMenu {
  String? id = '';
  String? menuId = '';
  String? menuName = '';
  String? subManuID = '';
  String? subMenuName = '';
  String? userType = '';
  String? isActive = '';
  String? menuIcon = '';
  String? subMenuIcon = '';
  String? nevigateUrl = '';
  String? menuUrl1 = '';
  String? menuUrl = '';
  String? displayOrder = '';
  String? menuOrder = '';
  String? userType1 = '';
  String? dashboardShortCut = '';
  String? androidIcon = '';
  String? menuFlag = '';
  List? subMenu = [];

  DrawerMenu({
    this.androidIcon,
    this.dashboardShortCut,
    this.displayOrder,
    this.id,
    this.isActive,
    this.menuFlag,
    this.menuIcon,
    this.menuId,
    this.menuName,
    this.menuOrder,
    this.menuUrl,
    this.menuUrl1,
    this.nevigateUrl,
    this.subManuID,
    this.subMenu,
    this.subMenuIcon,
    this.subMenuName,
    this.userType,
    this.userType1,
  });

  DrawerMenu.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    menuId = json['MenuID'];
    menuName = json['MenuName'];
    subManuID = json['SubMenuID'];
    subMenuName = json['SubMenuName'];
    userType = json['UserType'];
    isActive = json['IsActive'];
    menuIcon = json['MenuIcon'];
    nevigateUrl = json['NavigateURL'];
    menuUrl1 = json['MenuURL1'];
    menuUrl = json['MenuURL'];
    displayOrder = json['DisplayOrder'];
    menuOrder = json['MenuOrder'];
    userType1 = json['UserType1'];
    userType = json['UserType'];
    dashboardShortCut = json['DashBoardShortCut'];
    androidIcon = json['AndroidIcon'];
    menuFlag = json['MenuFlag'];

    if (json['SubMenu'] != null) {
      subMenu = (json['SubMenu'] as List)
          .map((v) => DrawerSubMenu.fromJson(v))
          .toList();
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['MenuID'] = menuId;
    data['MenuName'] = menuName;
    data['SubMenuID'] = subManuID;
    data['SubMenuName'] = subMenuName;
    data['UserType'] = userType;
    data['IsActive'] = isActive;
    data['MenuIcon'] = menuIcon;
    data['SubMenuIcon'] = subMenuIcon;
    data['NavigateURL'] = nevigateUrl;
    data['MenuURL1'] = menuUrl1;
    data['MenuURL'] = menuUrl;
    data['DisplayOrder'] = displayOrder;
    data['MenuOrder'] = menuOrder;
    data['UserType1'] = userType;
    data['DashBoardShortCut'] = dashboardShortCut;
    data['AndroidIcon'] = androidIcon;
    data['MenuFlag'] = menuFlag;
    if (subMenu != null) {
      data['SubMenu'] = subMenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DrawerSubMenu {
  String? id = '';
  String? menuId = '';
  String? menuName = '';
  String? subManuID = '';
  String? subMenuName = '';
  String? userType = '';
  String? isActive = '';
  String? menuIcon = '';
  String? subMenuIcon = '';
  String? nevigateUrl = '';
  String? menuUrl1 = '';
  String? menuUrl = '';
  String? displayOrder = '';
  String? menuOrder = '';
  String? userType1 = '';
  String? dashboardShortCut = '';
  String? androidIcon = '';
  String? menuFlag = '';
  List? subMenu = [];
  String? subMenuFlag = '';

  DrawerSubMenu.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    menuId = json['MenuID'];
    menuName = json['MenuName'];
    subManuID = json['SubMenuID'];
    subMenuName = json['SubMenuName'];
    userType = json['UserType'];
    isActive = json['IsActive'];
    menuIcon = json['MenuIcon'];
    nevigateUrl = json['NavigateURL'];
    menuUrl1 = json['MenuURL1'];
    menuUrl = json['MenuURL'];
    displayOrder = json['DisplayOrder'];
    menuOrder = json['MenuOrder'];
    userType1 = json['UserType1'];
    userType = json['UserType'];
    dashboardShortCut = json['DashBoardShortCut'];
    androidIcon = json['AndroidIcon'];
    menuFlag = json['MenuFlag'];
    subMenuFlag = json['SubMenuFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['MenuID'] = menuId;
    data['MenuName'] = menuName;
    data['SubMenuID'] = subManuID;
    data['SubMenuName'] = subMenuName;
    data['UserType'] = userType;
    data['IsActive'] = isActive;
    data['MenuIcon'] = menuIcon;
    data['SubMenuIcon'] = subMenuIcon;
    data['NavigateURL'] = nevigateUrl;
    data['MenuURL1'] = menuUrl1;
    data['MenuURL'] = menuUrl;
    data['DisplayOrder'] = displayOrder;
    data['MenuOrder'] = menuOrder;
    data['UserType1'] = userType;
    data['DashBoardShortCut'] = dashboardShortCut;
    data['AndroidIcon'] = androidIcon;
    data['MenuFlag'] = menuFlag;
    data['SubMenuFlag'] = subMenuFlag;
    return data;
  }
}
