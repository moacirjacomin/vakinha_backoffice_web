import '../../data/models/payment_type_model.dart';
import '../widgets/payment_type_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../payment_module.dart';
import '../cubit/payment_type_cubit.dart';
import '../widgets/payment_type_header_widget.dart';
import '../widgets/payment_type_item_widget.dart';

class PaymentTypePage extends StatefulWidget {
  static const routeName = '/example';
  static const routePath = '${PaymentModule.moduleName}$routeName';
  const PaymentTypePage({super.key});

  @override
  State<PaymentTypePage> createState() => _PaymentTypePageState();
}

class _PaymentTypePageState extends State<PaymentTypePage> with Loader, Messages {
  var cubit = Modular.get<PaymentTypeCubit>();

  @override
  void initState() {
    super.initState();
    cubit.loadPaymentTypes(null);
  }

  void showAddOrUpdatePayment(PaymentTypeModel? selected) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.black.withOpacity(0.5),
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              elevation: 10,
              child: PaymentTypeModalWidget(
                paymentType: selected,
                onPressSave: (paymentType, bool) async {

                   await cubit.addOrUpdatePaymentType(paymentType, bool);
                   Navigator.of(context).pop();
                }
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocConsumer<PaymentTypeCubit, PaymentTypeState>(
          bloc: cubit,
          listener: (context, state) {
            switch (state.status) {
              case Status.loading:
                showLoader();
                break;
              case Status.failure:
                hideLoader();
                showError(state.errorMessage ?? 'Some error');
                break;
              case Status.success:
                hideLoader();
                // cubit.doSomething();
                break;
              case Status.initial:
              case Status.loaded:
                // cubit.loadSomenthing()
                break;
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PaymentTypeHeaderWidget(
                  onFilterChange: cubit.changeFilter,
                  buttonPressed: () {
                    showAddOrUpdatePayment(null);
                  },
                ),
                //
                const SizedBox(height: 50),
                //
                if (state.paymentTypeList != null)
                  Expanded(
                    child: GridView.builder(
                        itemCount: state.paymentTypeList?.length ?? 0,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 120,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          maxCrossAxisExtent: 500,
                        ),
                        itemBuilder: (context, index) {
                          return PaymentTypeItemWidget(
                            onPressEdit: (selected) {
                              print('... selected=${selected}');
                              showAddOrUpdatePayment(selected);
                            },
                            paymentType: state.paymentTypeList![index],
                          );
                        }),
                  ),
              ],
            );
          }),
    );
  }
}
