import 'package:smartfarmer/src/models/product.dart';
import 'package:smartfarmer/src/services/firestore_service.dart';
import 'package:smartfarmer/src/models/market.dart';

class CustomerBloc{
    final db=FirestoreService();

   //Getters
    Stream<List<Market>> get fetchUpcomingMarkets=>db.fetchUpcomingMarkets();
    Stream<List<Product>> get fetchAvailableProducts =>db.fetchAvailableProducts();

    dispose(){


    }


}