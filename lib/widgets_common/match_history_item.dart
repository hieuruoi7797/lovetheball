import 'package:flutter/material.dart';
import 'package:splat_mobile/widgets_common/rounded_image.dart';

class MatchHistoryTypeItem extends StatelessWidget {
  MatchHistoryTypeItem({
    super.key,
    this.title,
    this.assetSvg,
    this.date,
    this.tagColor,
    this.tagValue,
  });

  String? assetSvg;
  String? title;
  String? date;
  String? tagValue;
  Color? tagColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedImage(
          width: 43.33,
          height: 43.33,
          usingSvg: true,
          assetImage: assetSvg ?? "assets/svg_pictures/quick_match.svg",),
        const SizedBox(width: 12.33,),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE4EBF2)))
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title??"Buổi đấu tự do",style:
                    const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color(0xFF313A3E),
                    ),),
                    Text(date??"11/01/2024",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0xFFB3BBC4),
                      ),),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                  decoration: BoxDecoration(
                      color: tagColor?.withOpacity(0.2) ?? const Color(0xFFE5601A).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text(
                    tagValue ?? "12 TRẬN",
                    style: TextStyle(
                        color: tagColor ?? const Color(0xFFE5601A),
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

}