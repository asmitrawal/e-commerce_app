import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/features/cart/model/cart.dart';

class CartRepository {
  final Dio dio;

  CartRepository({required this.dio});

  List<Cart> _cart = [];

  List<Cart> get cart => _cart;

  Future<Either<String, List<Cart>>> fetchCart() async {
    try {
      final res = await dio.get("${Constants.baseUrl}/api/cart");
      final List<Cart> tempCart =
          List.from(res.data["results"]).map((e) => Cart.fromJson(e)).toList();
      print(tempCart);
      _cart.clear();
      _cart.addAll(tempCart);
      return Right(tempCart);
    } on DioException catch (e) {
      print(e.response?.data["message"].toString() ?? "unable to add to cart");
      return Left(
          e.response?.data["message"].toString() ?? "unable to add to cart");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Cart>> updateProductCount(
      {required String cartId, required int quantity}) async {
    try {
      final res =
          await dio.put("${Constants.baseUrl}/api/cart/${cartId}", data: {
        "quantity": quantity,
      });
      final Cart tempCart = Cart.fromJson(res.data["results"]);
      final index = _cart.indexWhere((e) => e.id == tempCart.id);
      if (index != -1) {
        _cart[index] = tempCart;
      }
      print(tempCart);
      return Right(tempCart);
    } on DioException catch (e) {
      print(e.response?.data["message"].toString() ?? "unable to add to cart");
      return Left(
          e.response?.data["message"].toString() ?? "unable to add to cart");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
