import 'package:flutter/material.dart';

import '../../../../_shared/constants/app_styles.dart';
import '../../../../_shared/presentation/extensions/formatter_extension.dart';
import '../../../../_shared/presentation/extensions/size_extension.dart';
import '../../../data/models/order_dto.dart';
import '../../../data/models/order_model.dart';
import '../../../domain/entities/order_status.dart';
import 'order_product_item_widget.dart';

class OrderDetailModalWidget extends StatefulWidget {
  final OrderDto? order;
  final Function(OrderStatus) onPressFinalize;
  final Function(OrderStatus) onPressConfirm;
  final Function(OrderStatus) onPressCancel;
  final Function(OrderModel) onPressSave;

  const OrderDetailModalWidget({
    Key? key,
    this.order,
    required this.onPressFinalize,
    required this.onPressConfirm,
    required this.onPressCancel,
    required this.onPressSave,
  }) : super(key: key);

  @override
  State<OrderDetailModalWidget> createState() => _OrderDetailModalWidgetState();
}

class _OrderDetailModalWidgetState extends State<OrderDetailModalWidget> {
  void closeModal() => Navigator.of(context).pop();

  late OrderDto order;

  @override
  void initState() {
    super.initState();
    order = widget.order!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget orderInfoTile(String label, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textStyles.bold,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              info,
              style: context.textStyles.regular,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        OrderButtonBar(
            label: 'Finalize',
            image: 'assets/images/icons/finish_order_white_ico.png',
            color: Colors.blue,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            onPress: () {
              widget.onPressFinalize(OrderStatus.finalizado);
            }),
        OrderButtonBar(
            label: 'Confirm',
            image: 'assets/images/icons/confirm_order_white_icon.png',
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.zero),
            onPress: () {
              widget.onPressConfirm(OrderStatus.confirmado);
            }),
        OrderButtonBar(
            label: 'Cancel',
            image: 'assets/images/icons/cancel_order_white_icon.png',
            color: Colors.red,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            onPress: () {
              widget.onPressConfirm(OrderStatus.cancelado);
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.screenWidth;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        width: screenWidth * (screenWidth > 1000 ? .5 : .7),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Order Details',
                    textAlign: TextAlign.center,
                    style: context.textStyles.textTitle,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: closeModal,
                    child: Icon(Icons.close),
                  ),
                )
              ],
            ),
            //
            //

            //
            //
            const SizedBox(height: 20),
            Divider(),
            Row(
              children: [
                Text(
                  'Customer:',
                  style: context.textStyles.bold,
                ),
                Text(
                  order.user.name,
                  style: context.textStyles.regular,
                ),
              ],
            ),
            //
            //
            Divider(),
            ...order.orderProducts.map((op) => OrderProductItemWidget(orderProduct: op)).toList(),

            //
            //
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Total',
                  style: context.textStyles.extraBold.copyWith(fontSize: 16),
                ),
                Text(
                  order.orderProducts
                      .fold<double>(0.0, (previousValue, element) => previousValue + element.totalPrice)
                      .currencyPTBR, //12345.23.currencyPTBR,
                  style: context.textStyles.extraBold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Divider(),
            //
            //
            orderInfoTile('Payment Method:', order.paymentType.name),
            orderInfoTile('Address', order.address),
            //
            //
            SizedBox(height: 40),
            bottomBar(),
            //
            //
          ],
        ),
      ),
    );
  }
}

class OrderButtonBar extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color color;
  final String image;
  final String label;
  final VoidCallback onPress;

  const OrderButtonBar({
    Key? key,
    required this.borderRadius,
    required this.color,
    required this.image,
    required this.label,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.screenWidth;
    var isSmall = screenWidth < 750;
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide(
              color: color,
            ),
            backgroundColor: color,
          ),
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isSmall) ...[
                Image.asset(image),
                const SizedBox(width: 5),
              ],
              Expanded(
                child: Text(
                  label,
                  // screenWidth.toString(),
                  style: isSmall ? context.textStyles.regular.copyWith(fontSize: 13) : context.textStyles.bold,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
