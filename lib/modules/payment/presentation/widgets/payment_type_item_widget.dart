import 'package:flutter/material.dart';

import '../../../_shared/constants/app_color.dart';
import '../../../_shared/constants/app_styles.dart';
import '../../data/models/payment_type_model.dart';

class PaymentTypeItemWidget extends StatelessWidget {
  final PaymentTypeModel paymentType;
  final Function(PaymentTypeModel) onPressEdit;
  const PaymentTypeItemWidget({
    Key? key,
    required this.paymentType,
    required this.onPressEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorAll = paymentType.enable ? Colors.black : Colors.grey;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/payment_${paymentType.acronym}_icon.png',
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/icons/payment_notfound_icon.png',
                  color: colorAll,
                );
              },
              color: colorAll,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forma de Pagamento',
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.regular.copyWith(color: colorAll),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    paymentType.name,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.textTitle.copyWith(fontSize: 17, color: colorAll),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  onPressEdit(paymentType);
                },
                child: Text(
                  'edit',
                  style: context.textStyles.medium.copyWith(color: paymentType.enable ? AppColors.primary : Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
