enum Menu {
  paymentType(
    '/payment/',
    'payment_type_ico.png',
    'payment_type_ico_selected.png',
    'Payment Types',
  ),

  products(
    '/product/',
    'product_ico.png',
    'product_ico_selected.png',
    'Products',
  ),
  orders(
    '/order/',
    'order_ico.png',
    'order_ico_selected.png',
    'Orders',
  );

  final String route;
  final String assetIcon;
  final String assetIconSelected;
  final String label;

  const Menu(this.route, this.assetIcon, this.assetIconSelected, this.label);

  static Menu? findByPath(String path){
    final menu = Menu.values.where((element) => path.contains(element.route));

    if(menu.isNotEmpty){
      return menu.first;
    }
  }
}
