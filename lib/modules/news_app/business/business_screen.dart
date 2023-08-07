import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/news_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/news_app/cubit/states.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;

        return ScreenTypeLayout(
          mobile: Builder(
              builder: (context){
            NewsCubit.get(context).setDesktop(false);
            return articleBuilder(list, context);
          }),
          desktop: Builder(builder: (context){
            NewsCubit.get(context).setDesktop(true);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: articleBuilder(list, context)),
                if(list.isNotEmpty)
                  Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            '${list[NewsCubit.get(context).currentIndexBusiness]['description']}',
                            style: TextStyle(
                              fontSize: 25.0,
                            ),

                          ),
                        ),
                      ))
              ],
            );
          }),
          breakpoints: const ScreenBreakpoints(
              desktop: 850.0, tablet: 500.0, watch: 300.0),
        );
      },
    );
  }
}
