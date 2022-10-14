import 'package:t_chain_payment_example/src/products/product.dart';

class ProductsService {
  getProducts() {
    return const [
      Product(
        id: 'p001',
        name: 'GoGo Bus',
        image: 'assets/images/p001.jpg',
        price: 6400,
      ),
      Product(
        id: 'p002',
        name: 'GoGo Firy',
        image: 'assets/images/p002.jpg',
        price: 7680,
      ),
      Product(
        id: 'p003',
        name: 'GoGo Justin',
        image: 'assets/images/p003.jpg',
        price: 6400,
      ),
      Product(
        id: 'p004',
        name: 'GoGo Amby',
        image: 'assets/images/p004.jpg',
        price: 7040,
      ),
    ];
  }
}
