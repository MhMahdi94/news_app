import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

Widget buildNewsItem(Map model, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(url: model['url']));
      },
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: model['urlToImage'] == null
                      ? NetworkImage(
                          'https://guwahatiplus.com/public/web/images/default-news.png')
                      : NetworkImage(model['urlToImage']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              // ignore: sized_box_for_whitespace

              child: Container(
                height: 120.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      model['title'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      model['publishedAt'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  @required String? Function(String?)? validate,
  @required String? label,
  @required IconData? prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp,
        ),
        labelText: label,
        prefixIcon: Icon(
          prefix,
          size: 22.sp,
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget articleItem(list) {
  return list.isEmpty
      ? Center(child: CircularProgressIndicator())
      : ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return buildNewsItem(list[index], context);
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(16.r),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black26,
              ),
            );
          },
          itemCount: 10,
        );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
