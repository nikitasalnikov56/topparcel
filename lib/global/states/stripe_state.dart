class StripeState {
  Map<String, dynamic>? paymentIntent;
  StripeState({this.paymentIntent});

  StripeState copyWith({Map<String, dynamic>? paymentIntent}) {
    return StripeState(
      paymentIntent: paymentIntent ?? this.paymentIntent,
    );
  }
}
