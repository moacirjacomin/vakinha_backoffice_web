import 'package:flutter/material.dart';

import '../_shared/constants/app_styles.dart';
import '../_shared/data/environment/env.dart';
import '../_shared/presentation/mixins/loader_mixin.dart';
import '../_shared/presentation/mixins/message_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Text(
              'Welcome Fulano',
              style: context.textStyles.extraBold,
            ),
          
          ],
        ),
      );
  }
}
