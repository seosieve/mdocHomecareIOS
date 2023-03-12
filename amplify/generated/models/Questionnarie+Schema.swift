// swiftlint:disable all
import Amplify
import Foundation

extension Questionnarie {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case content
    case Q1
    case Q2
    case Q3
    case Q4
    case Q5
    case Q6
    case Q7
    case userID
    case chatroomID
    case state
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let questionnarie = Questionnarie.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Questionnaries"
    
    model.attributes(
      .index(fields: ["userID"], name: "byUser"),
      .index(fields: ["chatroomID"], name: "byChatRoom")
    )
    
    model.fields(
      .id(),
      .field(questionnarie.content, is: .optional, ofType: .string),
      .field(questionnarie.Q1, is: .optional, ofType: .string),
      .field(questionnarie.Q2, is: .optional, ofType: .string),
      .field(questionnarie.Q3, is: .optional, ofType: .string),
      .field(questionnarie.Q4, is: .optional, ofType: .string),
      .field(questionnarie.Q5, is: .optional, ofType: .string),
      .field(questionnarie.Q6, is: .optional, ofType: .string),
      .field(questionnarie.Q7, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(questionnarie.userID, is: .optional, ofType: .string),
      .field(questionnarie.chatroomID, is: .optional, ofType: .string),
      .field(questionnarie.state, is: .optional, ofType: .int),
      .field(questionnarie.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(questionnarie.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}