import 'package:flutter/material.dart';

import '../../../../_shared/constants/app_styles.dart';
import '../../../../_shared/presentation/extensions/formatter_extension.dart';
import '../../../data/models/order_produt_dto.dart';

class OrderProductItemWidget extends StatelessWidget {
  final OrderProductDto orderProduct;

  const OrderProductItemWidget({
    Key? key,
    required this.orderProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              orderProduct.product.name,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.regular,
            ),
          ),
          Text(
            orderProduct.amount.toString(),
            style: context.textStyles.regular,
          ),
          Expanded(
              child: Text(
            orderProduct.totalPrice.currencyPTBR,
            textAlign: TextAlign.right,
            style: context.textStyles.regular,
          )),
        ],
      ),
    );
  }
}
