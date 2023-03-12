// swiftlint:disable all
import Amplify
import Foundation

public struct Questionnarie: Model {
  public let id: String
  public var content: String?
  public var Q1: String?
  public var Q2: String?
  public var Q3: String?
  public var Q4: String?
  public var Q5: String?
  public var Q6: String?
  public var Q7: [String?]?
  public var userID: String?
  public var chatroomID: String?
  public var state: Int?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      content: String? = nil,
      Q1: String? = nil,
      Q2: String? = nil,
      Q3: String? = nil,
      Q4: String? = nil,
      Q5: String? = nil,
      Q6: String? = nil,
      Q7: [String?]? = nil,
      userID: String? = nil,
      chatroomID: String? = nil,
      state: Int? = nil) {
    self.init(id: id,
      content: content,
      Q1: Q1,
      Q2: Q2,
      Q3: Q3,
      Q4: Q4,
      Q5: Q5,
      Q6: Q6,
      Q7: Q7,
      userID: userID,
      chatroomID: chatroomID,
      state: state,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      content: String? = nil,
      Q1: String? = nil,
      Q2: String? = nil,
      Q3: String? = nil,
      Q4: String? = nil,
      Q5: String? = nil,
      Q6: String? = nil,
      Q7: [String?]? = nil,
      userID: String? = nil,
      chatroomID: String? = nil,
      state: Int? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.content = content
      self.Q1 = Q1
      self.Q2 = Q2
      self.Q3 = Q3
      self.Q4 = Q4
      self.Q5 = Q5
      self.Q6 = Q6
      self.Q7 = Q7
      self.userID = userID
      self.chatroomID = chatroomID
      self.state = state
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}