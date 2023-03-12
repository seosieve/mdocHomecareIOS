// swiftlint:disable all
import Amplify
import Foundation

extension User {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case patientNumber
    case phoneNumber
    case email
    case status
    case lastOnlineAt
    case schedules
    case Messages
    case Questionnaries
    case chatrooms
    case state
    case MySchedules
    case sex
    case born
    case phoneNOK
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let user = User.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Users"
    
    model.fields(
      .id(),
      .field(user.name, is: .optional, ofType: .string),
      .field(user.patientNumber, is: .optional, ofType: .string),
      .field(user.phoneNumber, is: .optional, ofType: .string),
      .field(user.email, is: .optional, ofType: .string),
      .field(user.status, is: .optional, ofType: .string),
      .field(user.lastOnlineAt, is: .optional, ofType: .int),
      .hasMany(user.schedules, is: .optional, ofType: ScheduleUser.self, associatedWith: ScheduleUser.keys.user),
      .hasMany(user.Messages, is: .optional, ofType: Message.self, associatedWith: Message.keys.userID),
      .hasMany(user.Questionnaries, is: .optional, ofType: Questionnarie.self, associatedWith: Questionnarie.keys.userID),
      .hasMany(user.chatrooms, is: .optional, ofType: ChatRoomUser.self, associatedWith: ChatRoomUser.keys.user),
      .field(user.state, is: .optional, ofType: .int),
      .hasMany(user.MySchedules, is: .optional, ofType: MySchedule.self, associatedWith: MySchedule.keys.userID),
      .field(user.sex, is: .optional, ofType: .string),
      .field(user.born, is: .optional, ofType: .string),
      .field(user.phoneNOK, is: .optional, ofType: .string),
      .field(user.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(user.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}