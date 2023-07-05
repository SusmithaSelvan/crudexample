import 'package:shelf_router/shelf_router.dart';

import 'handlers/product_controller.dart';

Router createRouter() {
  final router = Router();
  final productHandler = ProductController();

  router.get('/products', productHandler.fetchProductDetails);
  router.post('/products/add', productHandler.saveProductDetails);
  router.put('/products/<id>/update', productHandler.updateProductDetails);
  router.delete('/products/<id>/delete', productHandler.deleteProductDetails);
  return router;
}
