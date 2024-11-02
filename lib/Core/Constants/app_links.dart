class AppLinks {
  static const String adminLink = 'http://192.168.100.33:3030/V1/market/admin';

  //////////////////////// Login ////////////////////////////////////////////////////////
  static const String loginLink = '$adminLink/login';

  ///////////////////////// Workers //////////////////////////////////
  static const String addWorker = '$adminLink/users/worker';
  static const String editWorker = '$adminLink/users/worker';
  static const String deleteWorker = '$adminLink/users/worker';
  static const String searchWorker = '$adminLink/users/worker/search';
  static const String getWorkers = '$adminLink/users/worker';

  ///////////////////////// Clients //////////////////////////////////
  static const String addClient = '$adminLink/users/client';
  static const String editClient = '$adminLink/ussers/client';
  static const String deleteClient = '$adminLink/users/client';
  static const String searchClient = '$adminLink/users/client/search';
  static const String getClients = '$adminLink/users/client';

  ////////////////////// Categories ////////////////////////////////////
  static const String addCategorie = '$adminLink/categorie';
  static const String editCategorie = '$adminLink/categorie';
  static const String deleteCategorie = '$adminLink/categorie';
  static const String searchCategorie = '$adminLink/categorie/search';
  static const String getCategorie = '$adminLink/categorie';

  ///////////////////// Products ////////////////////////////////////////
  static const String addProduct = '$adminLink/categorie';
  static const String editProduct = '$adminLink/product';
  static const String deleteProduct = '$adminLink/product';
  static const String searchProduct = '$adminLink/product/search';
  static const String getProduct = '$adminLink/product';

  //////////////////////// Orders ////////////////////////////////////////
  static const String editOrderStatus = '$adminLink/order/status';
  static const String editOrderItems = '$adminLink/order/items';
  static const String deleteOrder = '$adminLink/order';
  static const String searchOrder = '$adminLink/categorie/search';
  static const String getOrders = '$adminLink/order';
  static const String getOrderItems = '$adminLink/order/items';
}
