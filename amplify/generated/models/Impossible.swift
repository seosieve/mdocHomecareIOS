// swiftlint:disable all
import Amplify
import Foundation

public struct Impossible: Model {
  public let id: String
  public var userID: String?
  public var ttime: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      userID: String? = nil,
      ttime: String? = nil) {
    self.init(id: id,
      userID: userID,
      ttime: ttime,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      userID: String? = nil,
      ttime: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.userID = userID
      self.ttime = ttime
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}