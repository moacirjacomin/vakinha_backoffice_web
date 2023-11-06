import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../_shared/constants/app_styles.dart';
import '../../../../_shared/data/environment/env.dart';
import '../../../../_shared/presentation/extensions/formatter_extension.dart';
import '../../../data/models/product_model.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;
  final Function(ProductModel) onPressEdit;

  const ProductItemWidget({
    Key? key,
    required this.product,
    required this.onPressEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: LayoutBuilder(builder: (_, constrains) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: constrains.maxHeight * .60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      product.image.contains('http') ? product.image : '${Env.instance.get('base_url')}${product.image}',
                      // imageRenderMethodForWeb: imageRenderMethodForWeb,
                      errorListener: (_) {
                        print("CachedNetworkImageProvider: Image failed to load!");
                      },
                    ),
                    fit: BoxFit.cover),
                // image: CachedNetworkImageProvider('${Env.instance.get('base_url')}/storage/mclumygt_jrs_1682022574279.jpg'), fit: BoxFit.cover),
              ),
            ),
            //
            //
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 15, left: 15),
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: context.textStyles.regular,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.price.currencyPTBR,
                      style: context.textStyles.regular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  FittedBox(
                    child: TextButton(
                        onPressed: () {
                          onPressEdit(product);
                        },
                        child: Text(
                          'edit',
                          style: context.textStyles.regular,
                        )),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
