import 'package:smartfarmer/src/services/firestore_service.dart';
import 'package:smartfarmer/src/models/market.dart';

class CustomerBloc{
    final db=FirestoreService();

   //Getters
    Stream<List<Market>> get fetchUpcomingMarkets=>db.fetchUpcomingMarkets();

    dispose(){


    }


}