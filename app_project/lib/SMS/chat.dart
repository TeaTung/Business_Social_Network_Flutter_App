import 'dart:io';
import 'package:bubble/bubble.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/SMS/providers/chat_provider.dart';
import 'package:test_fix/SMS/providers/room_provider.dart';
import 'package:test_fix/providers/user_info.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.roomId,
    required this.otherUserId,
  }) : super(key: key);

  final String roomId;
  final String otherUserId;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;
  ChatProvider? _chatProvider;
  UserInfoLocal? _userInforProvider;
  var _userTalkingToId;
  var _userTalkingToName;

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.roomId);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.roomId,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.roomId);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.roomId,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) {
    return Bubble(
      child: child,
      color: _userTalkingToId != widget.otherUserId ||
              message.type == types.MessageType.image
          ? Colors.blueGrey.shade300
          : const Color.fromRGBO(248, 145, 71, 0.9),
      margin: nextMessageInGroup
          ? const BubbleEdges.symmetric(horizontal: 6, vertical: 8)
          : null,
      nip: FirebaseChatCore.instance.firebaseUser?.uid != widget.otherUserId
          ? BubbleNip.leftBottom
          : BubbleNip.rightBottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    _userInforProvider = Provider.of<UserInfoLocal>(context, listen: false);
    // _chatProvider!
    //     .getUserTalkingTo(widget.roomId, _userInforProvider!.uid)
    //     .then((data) {
    //   _userTalkingToId = data.id;
    //   _userTalkingToName = data.firstName;
    // });

    // var data =
    //     _chatProvider!.getUserTalkingTo(widget.roomId, _userInforProvider!.uid);
    // _userTalkingToId = data['id'];
    // _userTalkingToName = data['name'];

    final roomsProvider = Provider.of<RoomProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          "${_userTalkingToName}",
          style: GoogleFonts.workSans().copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<types.Room>(
        stream: FirebaseChatCore.instance.room(widget.roomId),
        builder: (context, snapshot) {
          return StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) {
              return SafeArea(
                bottom: false,
                child: Chat(
                  theme: DefaultChatTheme(
                    sentMessageBodyTextStyle: GoogleFonts.ubuntu().copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    receivedMessageBodyTextStyle: GoogleFonts.ubuntu().copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    inputTextStyle: GoogleFonts.ubuntu().copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  bubbleBuilder: _bubbleBuilder,
                  isAttachmentUploading: _isAttachmentUploading,
                  messages: snapshot.data ?? [],
                  onAttachmentPressed: _handleAtachmentPressed,
                  onMessageTap: _handleMessageTap,
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  onSendPressed: _handleSendPressed,
                  user: types.User(
                    id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
