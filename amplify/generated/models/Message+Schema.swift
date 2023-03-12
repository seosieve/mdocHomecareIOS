// swiftlint:disable all
import Amplify
import Foundation

extension Message {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case image
    case status
    case content
    case userID
    case chatroomID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let message = Message.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Messages"
    
    model.attributes(
      .index(fields: ["userID"], name: "byUser"),
      .index(fields: ["chatroomID"], name: "byChatRoom")
    )
    
    model.fields(
      .id(),
      .field(message.image, is: .optional, ofType: .string),
      .field(message.status, is: .optional, ofType: .enum(type: MessageStatus.self)),
      .field(message.content, is: .optional, ofType: .string),
      .field(message.userID, is: .optional, ofType: .string),
      .field(message.chatroomID, is: .optional, ofType: .string),
      .field(message.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(message.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}