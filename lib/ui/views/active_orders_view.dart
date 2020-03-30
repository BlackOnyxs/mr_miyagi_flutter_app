import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/active_orders_view_model.dart';
import 'package:mr_miyagi_app/ui/views/base_view.dart';

class ActiveOrdesView extends StatelessWidget {
  const ActiveOrdesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ActiveOrderViewModel>(
      onModelReady: ( model )async{
         model.getOrders();
      },
      builder: ( context, model, child ){
        return Scaffold(
          appBar: AppBar(
            title: Text('Active Orders'),
          ),
          body:  SingleChildScrollView(
            child: StreamBuilder(
              stream: model.orderStream,
              builder:(BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if( snapshot.hasData && snapshot.data != null ){
                  return ListView.builder(
                    padding: EdgeInsets.all(15.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: ( context, index ) => _createOrderItem( snapshot.data[index], model ),
                  );
                }else{
                  return Center(
                    child: Center(
                      child: Text(
                        "You haven't active orders"
                      ),
                    )
                  );
                }
              }
            ),
          )
        );
      }
    );
  }
  Widget _createOrderItem( String orderId, ActiveOrderViewModel model  ){
    return ListTile(
      title: Text(
        orderId,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.indigoAccent),
      onTap: (){
        model.navigateTo(ORDER_VIEW_ROUTE, id: orderId);
      },
    );
  }
}