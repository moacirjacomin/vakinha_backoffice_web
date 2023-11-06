import 'package:flutter/material.dart';

import '../../../../_shared/constants/app_styles.dart';
import '../../../data/models/order_model.dart';

class OrderItemWidget extends StatelessWidget {

  final OrderModel order;
  final Function(OrderModel) onTap;
  
  const OrderItemWidget({
    Key? key,
    required this.order,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap(order);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Order: #',  style: context.textStyles.regular),
                    Text('${order.id}', style: context.textStyles.extraBold),
                    Spacer(),
                    Text(
                      order.status.name,
                      style: context.textStyles.bold.copyWith(color:  order.status.color ),
                    ),
                    const SizedBox(
                      width: 5,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
          VerticalDivider(
            thickness: 1,
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }
}
