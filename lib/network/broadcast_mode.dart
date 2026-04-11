enum BroadcastMode { lan, nintendo, friends, java }

int broadcastModeToByte(BroadcastMode mode) {
  switch (mode) {
    case BroadcastMode.lan:
      return 0x00;
    case BroadcastMode.nintendo:
      return 0x01;
    case BroadcastMode.friends:
      return 0x02;
    case BroadcastMode.java:
      return 0x03;
  }
  
}