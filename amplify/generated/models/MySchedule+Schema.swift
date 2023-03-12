// swiftlint:disable all
import Amplify
import Foundation

extension MySchedule {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case userID
    case scheduleID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let mySchedule = MySchedule.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "MySchedules"
    
    model.attributes(
      .index(fields: ["userID"], name: "byUser"),
      .index(fields: ["scheduleID"], name: "bySchedule")
    )
    
    model.fields(
      .id(),
      .field(mySchedule.userID, is: .optional, ofType: .string),
      .field(mySchedule.scheduleID, is: .optional, ofType: .string),
      .field(mySchedule.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(mySchedule.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}