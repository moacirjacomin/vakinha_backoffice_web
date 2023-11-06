import 'package:brasil_fields/brasil_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../_shared/constants/app_styles.dart';
import '../../../_shared/constants/status.dart';
import '../../../_shared/data/environment/env.dart';
import '../../../_shared/presentation/extensions/size_extension.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../../_shared/utils/upload_util.dart';
import '../../data/models/product_model.dart';
import '../../product_module.dart';
import '../cubit/product_detail_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  final int? productId;
  static const routeName = '/product-detail';
  static const routePath = '${ProductModule.moduleName}$routeName';
  const ProductDetailPage({
    Key? key,
    this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with Loader, Messages {
  var cubit = Modular.get<ProductDetailCubit>();
  late var productId;

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final priceEC = TextEditingController();
  final descriptionEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    productId = widget.productId; // data received by page parameter

    var data = Modular.args.data; // data from argument on navigation
    // eg: await Modular.to.pushNamed('/product/detail', arguments: product );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (data != null) {
        productId = data.id;
        nameEC.text = data.name;
        descriptionEC.text = data.description;
        priceEC.text = data.price.toString();
        cubit.updateImagePath(data.image);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    priceEC.dispose();
    descriptionEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailCubit, ProductDetailState>(
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
            Navigator.of(context).pop();
            break;
          case Status.loaded:
          case Status.initial:
            hideLoader();
            // cubit.loadSomenthing()
            break;
        }
      },
      builder: (context, state) {
        final widthButtonAction = context.percentWidth(.40);
        return Container(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${productId != null ? 'Edtir' : 'New'} Product',
                          style: context.textStyles.textTitle,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  //
                  //
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              image: state.imagePath == ''
                                  ? null
                                  : DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        // product.image.contains('http') ? product.image : '${Env.instance.get('base_url')}${product.image}',
                                        // '${Env.instance.get('base_url')}/storage/mclumygt_jrs_1682022574279.jpg',
                                        '${Env.instance.get('base_url')}${state.imagePath}',
                                        errorListener: (_) {
                                          print("CachedNetworkImageProvider: Image failed to load!");
                                        },
                                      ),
                                      fit: BoxFit.cover),
                              // image: CachedNetworkImageProvider('${Env.instance.get('base_url')}/storage/mclumygt_jrs_1682022574279.jpg'), fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            width: 120,
                            margin: EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: () {
                                UploadHtmlUtil().startUpload(cubit.uploadImageProduct);
                              },
                              style: TextButton.styleFrom(backgroundColor: Colors.white.withOpacity(.9)),
                              child: Text('${state.imagePath == '' ? 'Add' : 'Edit'} Picture'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameEC,
                              decoration: InputDecoration(
                                label: Text('Name'),
                              ),
                              validator: Validatorless.required('Name is mandatory'),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: priceEC,
                              decoration: InputDecoration(
                                label: Text('Price'),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CentavosInputFormatter(moeda: true),
                              ],
                              validator: Validatorless.required('Price is mandatory'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //
                  //
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: descriptionEC,
                    keyboardType: TextInputType.multiline,
                    minLines: 10,
                    maxLines: null,
                    decoration: InputDecoration(
                      label: Text('Description'),
                      alignLabelWithHint: true,
                    ),
                  ),
                  //
                  //
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: widthButtonAction,
                      // height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (productId != null)
                            Container(
                              width: widthButtonAction / 2,
                              padding: EdgeInsets.only(right: 10),
                              height: 40,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Confirm'),
                                          content: Text('Do you really want to delete this product?'),
                                          actions: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: context.textStyles.bold,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                cubit.deleteProduct(productId);
                                              },
                                              child: Text(
                                                'Delete',
                                                style: context.textStyles.bold,
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  'Deletar',
                                  style: context.textStyles.bold.copyWith(color: Colors.red),
                                ),
                              ),
                            ),
                          Container(
                            width: widthButtonAction / 2,
                            padding: EdgeInsets.only(left: 10),
                            height: 40,
                            child: ElevatedButton(
                              // style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.red)),
                              onPressed: () async {
                                var isValid = formKey.currentState?.validate() ?? false;

                                if (state.imagePath == '') {
                                  showWarning('Picture is required');
                                  return;
                                }

                                if (isValid) {
                                  var productFinal = ProductModel(
                                    id: productId,
                                    name: nameEC.text.trim(),
                                    description: descriptionEC.text.trim(),
                                    price: UtilBrasilFields.converterMoedaParaDouble(priceEC.text),
                                    image: state.imagePath,
                                    enable: true,
                                  );

                                  cubit.save(productFinal);
                                }
                              },
                              child: Text(
                                'Save',
                                // style: context.textStyles.bold.copyWith(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
