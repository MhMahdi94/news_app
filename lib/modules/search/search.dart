import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange: (value) {
                      cubit.getSearchData(value);
                    },
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Search Item must not be Empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                ),
                Expanded(child: articleItem(cubit.search)),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
