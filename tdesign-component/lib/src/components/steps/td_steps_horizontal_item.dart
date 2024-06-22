import 'package:flutter/material.dart';
import '../../../tdesign_flutter.dart';

/// Steps步骤条，水平步骤item
class TDStepsHorizontalItem extends StatelessWidget {
  final StepsItemData data;
  final int index;
  final int stepsCount;
  final int activeIndex;
  final StepsStatus status;
  final bool simple;
  const TDStepsHorizontalItem({
    super.key,
    required this.data,
    required this.index,
    required this.stepsCount,
    required this.activeIndex,
    required this.status,
    required this.simple,
  });

  @override
  Widget build(BuildContext context) {
    /// 步骤条数字背景色
    var stepsNumberBgColor = TDTheme.of(context).brandNormalColor;
    /// 步骤条数字颜色
    var stepsNumberTextColor = TDTheme.of(context).whiteColor1;
    /// 步骤条标题颜色
    var stepsTitleColor = TDTheme.of(context).brandColor7;
    /// 步骤条icon颜色
    var stepsIconColor = TDTheme.of(context).brandColor7;
    /// 简略步骤条icon颜色
    var simpleStepsIconColor = TDTheme.of(context).brandColor7;

    Widget? completeIconWidget;

    /// 激活索引大于当前索引
    if (activeIndex > index) {
      stepsNumberBgColor = TDTheme.of(context).brandColor1;
      stepsNumberTextColor = TDTheme.of(context).brandColor7;
      stepsTitleColor = TDTheme.of(context).fontGyColor1;
      /// 已完成的用icon图标显示
      completeIconWidget = Icon(TDIcons.check, color: TDTheme.of(context).brandColor7, size: 16,);
    }else if (activeIndex < index) {
      /// 激活索引小于当前索引
      stepsNumberBgColor = TDTheme.of(context).grayColor1;
      stepsNumberTextColor = TDTheme.of(context).fontGyColor3;
      stepsTitleColor = TDTheme.of(context).fontGyColor3;
      stepsIconColor = TDTheme.of(context).fontGyColor3;
      simpleStepsIconColor = TDTheme.of(context).grayColor4;
    }

    /// 步骤条icon图标组件，默认为索引文字
    Widget? stepsIconWidget = Text(
      (index + 1).toString(),
      style: TextStyle(
        color: stepsNumberTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );

    /// 已完成的用icon图标显示
    if (completeIconWidget != null) {
      stepsIconWidget = completeIconWidget;
    }

    /// 步骤条icon图标背景和形状
    BoxDecoration? iconWidgetDecoration = BoxDecoration(
      color: stepsNumberBgColor,
      shape: BoxShape.circle,
    );

    /// 传递了成功的icon图标
    if (data.successIcon != null) {
      stepsIconWidget = Icon(data.successIcon, color: stepsIconColor, size: 22,);
      /// 传了图标则不用设置背景色
      iconWidgetDecoration = null;
    }
    // icon组件容器大小
    double iconContainerSize = 22;

    /// 简略步骤条
    if (simple) {
      iconContainerSize = 8;
      stepsIconWidget = null;
      /// 简略步骤条BoxDecoration
      var simpleDecoration = BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: simpleStepsIconColor,
          width: 1,
        ),
      );
      if (activeIndex == index) {
        simpleDecoration = BoxDecoration(
          color: TDTheme.of(context).brandColor7,
          shape: BoxShape.circle,
        );
      }
      iconWidgetDecoration = simpleDecoration;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Opacity(
                opacity: index == 0 ? 0 : 1,
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: activeIndex >= index ? TDTheme.of(context).brandColor7 : TDTheme.of(context).grayColor4
                ),
              ),
            ),
            Container(
              width: iconContainerSize,
              height: iconContainerSize,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 8, right: 8),
              decoration: iconWidgetDecoration,
              child: stepsIconWidget,
            ),
            Expanded(
              flex: 1,
              child: Opacity(
                opacity: index == stepsCount - 1 ? 0 : 1,
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: activeIndex > index ? TDTheme.of(context).brandColor7 : TDTheme.of(context).grayColor4,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          alignment: Alignment.center,
          child: TDText(
            data.title,
            style: TextStyle(
              fontWeight: activeIndex == index ? FontWeight.w600 : FontWeight.w400,
              color: stepsTitleColor,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          child: TDText(
            data.content,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: TDTheme.of(context).fontGyColor3,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

}
