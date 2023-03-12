// swiftlint:disable all
import Amplify
import Foundation

public struct ScheduleUser: Model {
  public let id: String
  public var schedule: Schedule
  public var user: User
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      schedule: Schedule,
      user: User) {
    self.init(id: id,
      schedule: schedule,
      user: user,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      schedule: Schedule,
      user: User,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.schedule = schedule
      self.user = user
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}