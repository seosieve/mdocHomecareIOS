// swiftlint:disable all
import Amplify
import Foundation

extension ScheduleUser {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case schedule
    case user
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let scheduleUser = ScheduleUser.keys
    
    model.pluralName = "ScheduleUsers"
    
    model.attributes(
      .index(fields: ["scheduleID"], name: "bySchedule"),
      .index(fields: ["userID"], name: "byUser")
    )
    
    model.fields(
      .id(),
      .belongsTo(scheduleUser.schedule, is: .required, ofType: Schedule.self, targetName: "scheduleID"),
      .belongsTo(scheduleUser.user, is: .required, ofType: User.self, targetName: "userID"),
      .field(scheduleUser.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(scheduleUser.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}