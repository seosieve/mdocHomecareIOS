// swiftlint:disable all
import Amplify
import Foundation

public struct MySchedule: Model {
  public let id: String
  public var userID: String?
  public var scheduleID: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      userID: String? = nil,
      scheduleID: String? = nil) {
    self.init(id: id,
      userID: userID,
      scheduleID: scheduleID,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      userID: String? = nil,
      scheduleID: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.userID = userID
      self.scheduleID = scheduleID
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}