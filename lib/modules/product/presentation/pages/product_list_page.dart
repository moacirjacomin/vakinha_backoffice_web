import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../../_shared/presentation/widgets/base_header_widget.dart';
import '../../../_shared/utils/debounce_util.dart';
import '../../product_module.dart';
import '../cubit/product_list_cubit.dart';
import 'widgets/product_item_widget.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = '/product-list';
  static const routePath = '${ProductModule.moduleName}$routeName';
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> with Loader, Messages {
  var cubit = Modular.get<ProductListCubit>();

  var debounce = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit.onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductListCubit, ProductListState>(
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
          return Container(
            padding: EdgeInsets.only(top: 30),
            color: Colors.grey[50],
            child: Column(
              children: [
                BaseHeaderWidget(
                  title: 'Product Manager',
                  buttonLabel: 'Add',
                  addButton: true,
                  buttonPressed: () async {
                    await Modular.to.pushNamed('/product/detail');
                    cubit.loadProducts(null);
                  },
                  searchChange: (value) {
                    debounce.call(() {
                      cubit.onChangeFilter(value);
                    });
                  },
                ),
                //
                //
                const SizedBox(height: 40),
                Expanded(
                    child: GridView.builder(
                  itemCount: state.productList.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    mainAxisSpacing: 20,
                    maxCrossAxisExtent: 280,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItemWidget(
                      product: state.productList[index],
                      onPressEdit: (product) async {
                        print('EDIT product=${product}');
                        await Modular.to.pushNamed('/product/detail', arguments: product);
                        cubit.loadProducts(null);
                      },
                    );
                  },
                )),
                //
                //
              ],
            ),
          );
        });
  }
}
