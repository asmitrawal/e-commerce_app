// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/features/auth/repo/user_repository.dart';
import 'package:ecommerce_app/features/homepage/model/product.dart';

class ProductRepository {
  final UserRepository userRepository;
  final Dio dio;
  ProductRepository({
    required this.userRepository,
    required this.dio,
  });

  List<Product> _products = [];

  List<Product> get products => _products;

  Product? _product;
  Product? get product => _product;

  Future<Either<String, List<Product>>> fetchAllProducts() async {
    try {
      // dio.interceptors.add(
      //   InterceptorsWrapper(
      //     onRequest: (options, handler) {
      //       options.headers["Authorization"] = "Bearer ${userRepository.token}";
      //       handler.next(options);
      //     },
      //   ),
      // );
      final res = await dio.get(
        "${Constants.baseUrl}/api/products",
        // options: Options(
        //   headers: {"Authorization": "Bearer ${userRepository.token}"},
        // ),
      );
      final tempProductList = List.from(res.data["results"])
          .map((e) => Product.fromJson(e))
          .toList();
      _products.clear();
      _products.addAll(tempProductList);
      return Right(_products);
    } on DioException catch (e) {
      print(e.response?.data["message"].toString() ?? "unable to login");
      return Left(e.response?.data["message"].toString() ?? "unable to login");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Product>> fetchProductDetails(
      {required String productId}) async {
    try {
      final res = await dio.get(
        "${Constants.baseUrl}/api/products/${productId}",
      );
      print(res.data);
      final tempProduct = Product.fromJson(res.data["results"]);
      _product = tempProduct;
      return Right(tempProduct);
    } on DioException catch (e) {
      print(e.response?.data["message"].toString() ?? "unable to fetch");
      return Left(e.response?.data["message"].toString() ?? "unable to fetch");
    } catch (e) {
      return Left(e.toString());
    }
  }
  
  Future<Either<String, void>> addToCart({required String productId}) async {
    try {
      final _ = await dio.post(
        "${Constants.baseUrl}/api/cart",
        data: {
          // "quantity": 1,
          "product": productId,
        },
      );
      return Right(null);
    } on DioException catch (e) {
      print(e.response?.data["message"].toString() ?? "unable to add to cart");
      return Left(e.response?.data["message"].toString() ?? "unable to add to cart");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
