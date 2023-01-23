import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/shop_layout/cubit/shop_cubit.dart';
import '../styles/colors.dart';

// Widget buildArticleItems(article, context) => InkWell(
//       onTap: () {
//         navigateTo(context, WebViewScreen(article['url']));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Row(
//           children: [
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                     article['urlToImage'] ??
//                         "https://ichef.bbci.co.uk/news/1024/branded_arabic/9F2B/production/_125674704_285f1150-b927-4cf3-8411-12d4bf11e147.jpg",
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: 100,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         '${article['title']}',
//                         style: ShopCubit.get(context).isDark
//                             ? const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               )
//                             : const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 3,
//                       ),
//                     ),
//                     Text(
//                       '${article['publishedAt']}',
//                       style: const TextStyle(fontSize: 18, color: Colors.grey),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );

Widget listDivider() => const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Divider(
        thickness: 1,
      ),
    );

// Widget articleBuilder({required list, context, isSearch = false}) =>
//     ConditionalBuilder(
//       condition: list.isNotEmpty,
//       builder: (context) {
//         return
//         ListView.separated(
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: ((context, index) => buildArticleItems(
//                   list[index],
//                   context,
//                 )),
//             separatorBuilder: ((context, index) => listDivider()),
//             itemCount: 10);
//       },
//       fallback: (context) => isSearch
//           ? Container()
//           : SizedBox(
//               height: MediaQuery.of(context).size.height * .7,
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//     );
Widget defaultTextButton({
  required void Function()? function,
  required String text,
  TextStyle? style,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: style,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function()? function,
  required String text,
  TextStyle? style,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: style,
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  bool readable = false,
  IconData? suffix,
  TextStyle? labelStyle,
  void Function()? suffixPressed,
  bool isClickable = true,
  bool isEditable = true,
  TextAlign isTextAlign = TextAlign.start,
}) =>
    TextFormField(
      controller: controller,
      textAlign: isTextAlign,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable && isEditable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      readOnly: readable,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        enabledBorder:
            isEditable ? const OutlineInputBorder() : InputBorder.none,
        focusedBorder: isEditable
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              )
            : InputBorder.none,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndReplacement(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    ((route) => false));

void showToaster({required String message, required ToasterState state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToasterColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToasterState { success, warring, error }

Color? chooseToasterColor(ToasterState state) {
  Color color;
  switch (state) {
    case ToasterState.success:
      color = Colors.green;
      break;
    case ToasterState.warring:
      color = Colors.amber;
      break;
    case ToasterState.error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget listProductsBuilder(model, context, {bool isOldPrice = true}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: SizedBox(
      height: 120,
      child: Row(
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image(
                image: NetworkImage(model!.image),
                height: 120,
                width: 120,
              ),
            ),
            if (model!.discount != null && model!.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'Discount',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
          ]),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  child: Text(
                    model!.name ?? model.description,
                    style: const TextStyle(fontSize: 14, height: 1.9),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model!.price} \$',
                      style: const TextStyle(
                          fontSize: 17, height: 1.2, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (model!.discount != null &&
                        model!.discount != 0 &&
                        isOldPrice)
                      Text(
                        '${model!.oldPrice} \$',
                        style: const TextStyle(
                            fontSize: 15,
                            height: 1.2,
                            color: Color.fromARGB(255, 121, 120, 120),
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .addDeleteFavoriteData(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubit.get(context).favorite[model.id] ?? false
                                  ? defaultColor
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
