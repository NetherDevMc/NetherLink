import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';

class RelayConfigSender {
  static final List<int> MAGIC = [0xFE, 0xED, 0xBE, 0xEF];
  static const int PACKET_ID = 0x01;
  static const int ACK_PACKET_ID = 0x02;
  static const int TIMEOUT_SECONDS = 5;

  static Future<bool> sendConfigSimple({
    required String relayIp,
    required int relayConfigPort,
    required String remoteServerIp,
    required int remoteServerPort,
    required String bedrockUsername,
  }) async {
    RawDatagramSocket? socket;
    bool receivedAck = false;

    try {
      socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      socket.broadcastEnabled = true;

      final packet = _encodePacket(
        remoteServerIp: remoteServerIp,
        remoteServerPort: remoteServerPort,
        bedrockUsername: bedrockUsername,
      );

      final address = InternetAddress(relayIp);

      final completer = Completer<bool>();
      late StreamSubscription subscription;

      subscription = socket.listen((event) {
        if (event == RawSocketEvent.read) {
          final datagram = socket?.receive();
          if (datagram != null) {
            final data = datagram.data;
            if (data.length >= 5 &&
                data[0] == MAGIC[0] &&
                data[1] == MAGIC[1] &&
                data[2] == MAGIC[2] &&
                data[3] == MAGIC[3] &&
                data[4] == ACK_PACKET_ID) {
              receivedAck = true;
              if (!completer.isCompleted) {
                completer.complete(true);
              }
            }
          }
        }
      });

      socket.send(packet, address, relayConfigPort);
      print('📤 Config sent to $relayIp:$relayConfigPort');
      print(' -> $remoteServerIp:$remoteServerPort (user: $bedrockUsername)');

      try {
        await completer.future.timeout(
          Duration(seconds: TIMEOUT_SECONDS),
          onTimeout: () {
            print('⚠️ No response from relay server (timeout)');
            return false;
          },
        );
      } catch (e) {
        print('⚠️ Timeout waiting for relay server response');
      }

      await subscription.cancel();

      if (receivedAck) {
        print('✅ Relay server acknowledged configuration');
      }

      return receivedAck;
    } catch (e) {
      print('❌ Error sending config: $e');
      return false;
    } finally {
      socket?.close();
    }
  }

  static Uint8List _encodePacket({
    required String remoteServerIp,
    required int remoteServerPort,
    required String bedrockUsername,
  }) {
    final ipBytes = utf8.encode(remoteServerIp);
    final usernameBytes = utf8.encode(bedrockUsername);

    final buffer = BytesBuilder();
    buffer.add(MAGIC);
    buffer.addByte(PACKET_ID);

    // IP
    buffer.addByte(ipBytes.length >> 8);
    buffer.addByte(ipBytes.length & 0xFF);
    buffer.add(ipBytes);

    // Port
    buffer.addByte(remoteServerPort >> 8);
    buffer.addByte(remoteServerPort & 0xFF);

    // Username
    buffer.addByte(usernameBytes.length >> 8);
    buffer.addByte(usernameBytes.length & 0xFF);
    buffer.add(usernameBytes);

    return buffer.toBytes();
  }
}
