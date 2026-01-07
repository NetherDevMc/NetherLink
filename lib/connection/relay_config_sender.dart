import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';

class RelayConfigSender {
  static final List<int> MAGIC = [0xFE, 0xED, 0xBE, 0xEF];
  static const int PACKET_ID = 0x01;
  static const int ACK_PACKET_ID = 0x02;

  static Future<void> sendConfigSimple({
    required String relayIp,
    required int relayConfigPort,
    required String remoteServerIp,
    required int remoteServerPort,
    required String bedrockUsername,
  }) async {
    RawDatagramSocket? socket;

    try {
      socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

      final packet = _encodePacket(
        remoteServerIp: remoteServerIp,
        remoteServerPort: remoteServerPort,
        bedrockUsername: bedrockUsername,
      );

      final address = InternetAddress(relayIp);
      socket.send(packet, address, relayConfigPort);

      print('📤 Config sent to $relayIp:$relayConfigPort');
      print(' -> $remoteServerIp:$remoteServerPort (user: $bedrockUsername)');

      await Future.delayed(Duration(milliseconds: 100));
    } catch (e) {
      print('❌ Error sending config: $e');
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
