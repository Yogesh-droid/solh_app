enum JournalFeelings {
  Happy,
  Sad,
  Blessed,
  Loved,
  Thankful,
  Relaxed,
  Positive,
  Alone,
  Annoyed,
  Lucky,
  Pained,
  Peaceful,
}

extension ParseToString on JournalFeelings {
  String toShortString() {
    return this.toString().substring(this.toString().indexOf('.') + 1);
  }
}
