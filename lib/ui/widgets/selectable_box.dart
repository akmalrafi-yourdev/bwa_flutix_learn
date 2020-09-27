part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double height;
  final double width;
  final String text;
  final Function onTap;
  final TextStyle textStyle;

  SelectableBox(
    this.text, {
    this.isSelected = false,
    this.isEnabled = true,
    this.height = 56,
    this.width = 60,
    this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: (!isEnabled)
              ? Colors.grey[300]
              : isSelected ? accentColor2 : Colors.transparent,
          border: Border.all(
            color: (!isEnabled)
                ? Colors.grey[300]
                : isSelected ? Colors.transparent : Colors.grey[300],
          ),
        ),
        child: Center(
          child: Text(
            text ?? "None",
            style: (textStyle ?? blackTextFont).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
