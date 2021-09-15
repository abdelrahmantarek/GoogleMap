

class ScaleMarkerAnimation {
  final double duration;
  final double fromValue;
  final double toValue;
  final bool autoReverses;
  ScaleMarkerAnimation(
      {this.duration = 1.0,
        this.fromValue = 0.5,
        this.toValue = 2.0,
        this.autoReverses = true});
  Map<String, dynamic> toJson() {
    return {
      "scale.duration": duration,
      "scale.fromValue": fromValue,
      "scale.toValue": toValue,
      "scale.autoReverses": autoReverses,
    };
  }
}
