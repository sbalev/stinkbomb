class Timer {
  int elapsed;
  int start;
  
  Timer() {
    reset();
  }
  
  
  void start() {
    if (start == -1) start = millis();
  }
  
  void pause() {
    if (start != -1) {
      elapsed += millis() - start;
      start = -1;
    }
  }
  
  void reset() {
    elapsed = 0;
    start = -1;
  }
  
  int getMillis() {
    return elapsed + (start == -1 ? 0 : millis() - start);
  }
  
  String getMinutesSeconds() {
    int seconds = getMillis() / 1000;
    int minutes = seconds / 60;
    seconds %= 60;
    String r = minutes > 0 ? minutes + " min " : "";
    r += seconds + " s";
    return r;
  }
}
