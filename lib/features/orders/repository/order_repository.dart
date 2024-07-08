import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/features/orders/model/custom_order.dart';
import 'package:ecommerce_app/features/orders/model/fetched_order_item.dart';
import 'package:ecommerce_app/features/orders/model/order_item.dart';
import 'package:ecommerce_app/features/orders/model/single_order.dart';

class OrderRepository {
  final Dio dio;
  final List<OrderItem> _orders = [];
  List<OrderItem> get orders => _orders;

  OrderRepository({required this.dio});

  Future<Either<String, CustomOrder>> createOrder({
    required String address,
    required String city,
    required String phone,
    required String fullName,
  }) async {
    try {
      final res = await dio.post("${Constants.baseUrl}/api/orders", data: {
        "address": address,
        "city": city,
        "phone": phone,
        "full_name": fullName
      });
      final tempCustomOrder = CustomOrder.fromJson(res.data["results"]);
      _orders.addAll(tempCustomOrder.orderItems as List<OrderItem>);
      return Right(tempCustomOrder);
    } on DioException catch (e) {
      return Left(e.response?.data["message"].toString() ?? "dio api error");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<FetchedOrderItem>>> fetchOrders() async {
    try {
      final res = await dio.get("${Constants.baseUrl}/api/orders");
      final List<FetchedOrderItem> fetchedOrderList =
          List.from(res.data["results"])
              .map((e) => FetchedOrderItem.fromJson(e))
              .toList();
      return Right(fetchedOrderList);
    } on DioException catch (e) {
      return Left(e.response?.data["message"].toString() ?? "dio api error");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<SingleOrder>>> fetchSingleOrders() async {
    try {
      final List<SingleOrder> singleOrderList = [];
      final fetchedOrderList = await fetchOrders();

      if (fetchedOrderList.isRight()) {
        final fetchedOrderListRight = fetchedOrderList.getOrElse(() => []);
        for (FetchedOrderItem item
            in fetchedOrderListRight) {
          final res =
              await dio.get("${Constants.baseUrl}/api/orders/${item.id}");
          final List<OrderItem> tempOrderItemsList =
              List.from(res.data["results"]["orderItems"])
                  .map((e) => OrderItem.fromJson(e))
                  .toList();
          for (OrderItem tempOrderItem in tempOrderItemsList) {
            final SingleOrder singleOrder = SingleOrder(
                status: res.data["results"]["status"],
                product: tempOrderItem.product!);
            singleOrderList.add(singleOrder);
          }
        }
      }

      return Right(singleOrderList);
    } on DioException catch (e) {
      return Left(e.response?.data["message"].toString() ?? "dio api error");
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Future<Either<String,List<SingleOrder>>> fetch
}
