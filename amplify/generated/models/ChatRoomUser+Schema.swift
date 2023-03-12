// swiftlint:disable all
import Amplify
import Foundation

extension ChatRoomUser {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case user
    case chatRoom
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let chatRoomUser = ChatRoomUser.keys
    
    model.pluralName = "ChatRoomUsers"
    
    model.attributes(
      .index(fields: ["userID"], name: "byUser"),
      .index(fields: ["chatRoomID"], name: "byChatRoom")
    )
    
    model.fields(
      .id(),
      .belongsTo(chatRoomUser.user, is: .required, ofType: User.self, targetName: "userID"),
      .belongsTo(chatRoomUser.chatRoom, is: .required, ofType: ChatRoom.self, targetName: "chatRoomID"),
      .field(chatRoomUser.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(chatRoomUser.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}