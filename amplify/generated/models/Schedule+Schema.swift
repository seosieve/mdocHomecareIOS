// swiftlint:disable all
import Amplify
import Foundation

extension Schedule {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case Reservation
    case ttime
    case time
    case BOOK
    case Users
    case state
    case MySchedules
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let schedule = Schedule.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Schedules"
    
    model.fields(
      .id(),
      .field(schedule.Reservation, is: .optional, ofType: .string),
      .field(schedule.ttime, is: .optional, ofType: .dateTime),
      .field(schedule.time, is: .optional, ofType: .int),
      .field(schedule.BOOK, is: .optional, ofType: .string),
      .hasMany(schedule.Users, is: .optional, ofType: ScheduleUser.self, associatedWith: ScheduleUser.keys.schedule),
      .field(schedule.state, is: .optional, ofType: .int),
      .hasMany(schedule.MySchedules, is: .optional, ofType: MySchedule.self, associatedWith: MySchedule.keys.scheduleID),
      .field(schedule.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(schedule.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}