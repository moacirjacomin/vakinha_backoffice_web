import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../../_shared/presentation/widgets/base_header_widget.dart';
import '../../data/models/order_dto.dart';
import '../../domain/entities/order_status.dart';
import '../../order_module.dart';
import '../cubit/order_list_cubit.dart';
import 'widgets/order_detail_modal.dart';
import 'widgets/order_item_widget.dart';

class OrderListPage extends StatefulWidget {
  static const routeName = '/order-list';
  static const routePath = '${OrderModule.moduleName}$routeName';
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> with Loader, Messages {
  var cubit = Modular.get<OrderListCubit>();

  OrderStatus? statusSelected;

  @override
  void initState() {
    super.initState();

    cubit.onInit();
  }

  void showAddOrUpdatePayment(OrderDto? selected) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.black.withOpacity(0.5),
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              elevation: 10,
              child: OrderDetailModalWidget(
                  onPressCancel: (status) {
                    Navigator.pop(context);
                    cubit.updateOrderStatus(status);
                  },
                  onPressConfirm: (status) {
                    Navigator.pop(context);
                    cubit.updateOrderStatus(status);
                  },
                  onPressFinalize: (status) {
                    Navigator.pop(context);
                    cubit.updateOrderStatus(status);
                  },
                  order: selected,
                  onPressSave: (order) async {
                    //  await cubit.addOrUpdatePaymentType(paymentType, bool);
                    Navigator.of(context).pop();
                  }),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderListCubit, OrderState>(
      bloc: cubit,
      listener: (context, state) {
        switch (state.status) {
          case StatusOrderList.loading:
            showLoader();
            break;
          case StatusOrderList.failure:
            hideLoader();
            showError(state.errorMessage ?? 'Some error');
            break;
          case StatusOrderList.success:
            hideLoader();
            Navigator.pop(context);
            break;
          case StatusOrderList.initial:
            hideLoader();
            break;
          case StatusOrderList.loaded:
            hideLoader();
            showAddOrUpdatePayment(state.orderSelected);
            break;
       
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(top: 30),
          color: Colors.grey[50],
          child: Column(
            children: [
              BaseHeaderWidget(
                title: 'Order Manager',
                buttonLabel: '+ Add',
                addButton: false,
                filterWidget: DropdownButton<OrderStatus?>(
                  value: statusSelected,
                  items: [
                    DropdownMenuItem(child: Text('All'), value: null),
                    ...OrderStatus.values.map((status) => DropdownMenuItem(child: Text(status.name), value: status)).toList(),
                  ],
                  onChanged: (value) {
                    if (statusSelected == value) return;

                    setState(() {
                      statusSelected = value;
                      print(value);
                      cubit.onChangeFilter(value);
                    });
                  },
                ),
              ),
              //
              //
              const SizedBox(height: 50),
              Expanded(
                child: state.orderList.length == 0
                    ? Center(
                        child: Text('Nenhum pedido para hoje'),
                      )
                    : GridView.builder(
                        itemCount: state.orderList.length,
                        // itemCount: 10,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 91,
                          maxCrossAxisExtent: 400,
                          // mainAxisSpacing: 20,
                          // crossAxisSpacing: 600,
                        ),
                        itemBuilder: (context, index) {
                          return OrderItemWidget(
                            order: state.orderList[index],
                            onTap: (order) {
                              print('order=${order}');
                              cubit.getOrderDetail(order.id);
                            },
                          );
                        },
                      ),
              ),
              //
              //
            ],
          ),
        );
      },
    );
  }
}
