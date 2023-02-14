import 'package:eleverdev/controllers/home_page.dart';
import 'package:eleverdev/data/models/card_config.dart';
import 'package:get/route_manager.dart';

class CardModel {
  final int position;
  final CardConfig cardConfig;

  CardModel._(
      {required this.position,required this.cardConfig});

  factory CardModel({required Map<String, dynamic> elementData}) {
    // final String? text = elementData['text'];
    // final Color? bgColor = HexColor.fromHex(elementData['bgColor']);
    // final Color? textColor = elementData['textStyle'] != null
    //     ? HexColor.fromHex(elementData['textStyle']['color'])
    //     : null;
    // final double? fontSize = elementData['textStyle'] != null
    //     ? double.tryParse(elementData['textStyle']['fontSize'].toString())
    //     : null;
    // final FontWeight? fontWeight = elementData['textStyle'] != null
    //     ? FontWeightHelper.getFontWeight(
    //         int.tryParse(elementData['textStyle']['fontWeight'].toString()))
    //     : null;
    // final bool visibility = elementData['visibility'];
    // final String? imageUrl = elementData['imageUrl'];
    // final double? imageCons =
    //     double.tryParse(elementData['imageCons'].toString());

    // final cardConfig = CardConfig.fromJson(elementData);
    // log(cardConfig.textStyle!.color.toString());

    // final Widget widget = Visibility(
    //     visible: visibility,
    //     child: Card(
    //       shape: const OutlineInputBorder(
    //           borderRadius: BorderRadius.only(
    //               bottomLeft: Radius.circular(20),
    //               bottomRight: Radius.circular(20)),
    //           borderSide: BorderSide.none),
    //       color: bgColor,
    //       child: InkWell(
    //         onTap: () {
    //           onpressAction(onPressData: elementData['onTap']);
    //         },
    //         child: Column(
    //           children: [
    //             text != null
    //                 ? ListTile(
    //                     title: Text(
    //                     text,
    //                     style: TextStyle(
    //                       color: textColor,
    //                       fontSize: fontSize,
    //                       fontWeight: fontWeight,
    //                     ),
    //                   ))
    //                 : const SizedBox(),
    //             imageUrl != null
    //                 ? Container(
    //                     width: double.infinity,
    //                     height: 200,
    //                     decoration: const BoxDecoration(
    //                       borderRadius: BorderRadius.only(
    //                           bottomLeft: Radius.circular(20),
    //                           bottomRight: Radius.circular(20)),
    //                     ),
    //                     margin: EdgeInsets.only(top: imageCons ?? 0.0),
    //                     child: ClipRRect(
    //                       borderRadius: const BorderRadius.only(
    //                           bottomLeft: Radius.circular(20),
    //                           bottomRight: Radius.circular(20)),
    //                       child: CachedNetworkImage(
    //                         imageUrl: imageUrl,
    //                         width: double.infinity,
    //                         fit: BoxFit.cover,
    //                         placeholder: (context, url) => const Center(
    //                             child: CircularProgressIndicator()),
    //                         errorWidget: (context, url, error) =>
    //                             const Icon(Icons.error),
    //                       ),
    //                     ))
    //                 : const SizedBox(),
    //           ],
    //         ),
    //       ),
    //     ));

    return CardModel._(
        position: elementData['pos'] ?? -1,
        cardConfig: CardConfig.fromJson(elementData));
  }

  static onpressAction({required Map<String, dynamic>? onPressData}) {
    /*
    This function is used to filter different onpress types and perform specific tasks according to that type
    */
    if (onPressData == null || onPressData['type'] == null) {
      return;
    }
    switch (onPressData['type']) {
      case 'route':
        Get.toNamed(onPressData['onPress']);
        return;
      case 'function':
        onPressFunction(onPressData['onPress']);
        return;
      default:
        return;
    }
  }

  static onPressFunction(String functionName) {
    /*

     This function is used call different functions based on function name

    */
    switch (functionName) {
      case "showSnackBar":
        HomePageController().showGetSnackBar();
        return;
      default:
        return;
    }
  }
}
