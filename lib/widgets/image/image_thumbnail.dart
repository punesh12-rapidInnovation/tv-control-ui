import 'package:flutter/material.dart';
import 'package:tv_control_ui/utils/app_theme.dart';
import 'package:tv_control_ui/utils/size_utils.dart';


class ImageThumbnail extends StatefulWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final bool isNetwork;
  final Color? borderColor;
  final double borderWidth;

  const ImageThumbnail({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius = 0,
    this.isNetwork = true,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  State<ImageThumbnail> createState() => _ImageThumbnailState();
}

class _ImageThumbnailState extends State<ImageThumbnail> {
  late ImageProvider _imageProvider;
  bool _isPrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.isNetwork && widget.imageUrl != null && !_isPrecached) {
      _imageProvider = NetworkImage(widget.imageUrl!);
      precacheImage(_imageProvider, context).then((_) {
        if (mounted) {
          setState(() {
            _isPrecached = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double resolvedWidth = SizeUtils.pxToDp(context, widget.width ?? 100);
    final double resolvedHeight =
        SizeUtils.pxToDp(context, widget.height ?? 100);
    final double resolvedRadius =
        SizeUtils.pxToDp(context, widget.borderRadius);

    final Widget imageWidget = widget.isNetwork
        ? Image.network(
            widget.imageUrl ?? '',
            width: resolvedWidth,
            height: resolvedHeight,
            fit: widget.fit ?? BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: resolvedWidth,
                height: resolvedHeight,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Image load error: $error - ${widget.imageUrl}');
              return _errorPlaceholder(
                  context, resolvedWidth, resolvedHeight, resolvedRadius);
            },
          )
        : Image.asset(
            widget.imageUrl ?? '',
            width: resolvedWidth,
            height: resolvedHeight,
            fit: widget.fit ?? BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _errorPlaceholder(
                  context, resolvedWidth, resolvedHeight, resolvedRadius);
            },
          );

    Widget imageContainer = ClipRRect(
      borderRadius: BorderRadius.circular(resolvedRadius),
      child: imageWidget,
    );

    if (widget.borderColor != null) {
      imageContainer = Container(
        width: resolvedWidth,
        height: resolvedHeight,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: widget.borderColor!,
            width: SizeUtils.pxToDp(context, widget.borderWidth),
          ),
          borderRadius: BorderRadius.circular(resolvedRadius),
        ),
        child: imageContainer,
      );
    }

    return imageContainer;
  }

  Widget _errorPlaceholder(
      BuildContext context, double width, double height, double radius) {
    final themeColor =
        Theme.of(context).extension<AppTheme>()?.get('primary') ?? Colors.grey;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.broken_image,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
