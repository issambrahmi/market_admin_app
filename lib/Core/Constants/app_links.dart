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
  static const String addCategories = '$adminLink/categories';
  static const String editCategories = '$adminLink/categories';
  static const String deleteCategories = '$adminLink/categories';
  static const String searchCategories = '$adminLink/categories/search';
  static const String getCategories = '$adminLink/categories';

  ///////////////////// Products ////////////////////////////////////////
  static const String addProduct = '$adminLink/products';
  static const String editProduct = '$adminLink/products';
  static const String deleteProduct = '$adminLink/products';
  static const String searchProduct = '$adminLink/products/search';
  static const String getProduct = '$adminLink/products';

  //////////////////////// Orders ////////////////////////////////////////
  static const String editOrderStatus = '$adminLink/orders/status';
  static const String editOrderItems = '$adminLink/orders/items';
  static const String acceptOrder = '$adminLink/orders';
  static const String deleteOrder = '$adminLink/orders';
  static const String searchOrder = '$adminLink/orders/search';
  static const String getOrders = '$adminLink/orders';
  static const String getOrderItems = '$adminLink/orders/items';
}
