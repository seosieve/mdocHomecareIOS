// swiftlint:disable all
import Amplify
import Foundation

public struct Schedule: Model {
  public let id: String
  public var Reservation: String?
  public var ttime: Temporal.DateTime?
  public var time: Int?
  public var BOOK: String?
  public var Users: List<ScheduleUser>?
  public var state: Int?
  public var MySchedules: List<MySchedule>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      Reservation: String? = nil,
      ttime: Temporal.DateTime? = nil,
      time: Int? = nil,
      BOOK: String? = nil,
      Users: List<ScheduleUser>? = [],
      state: Int? = nil,
      MySchedules: List<MySchedule>? = []) {
    self.init(id: id,
      Reservation: Reservation,
      ttime: ttime,
      time: time,
      BOOK: BOOK,
      Users: Users,
      state: state,
      MySchedules: MySchedules,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      Reservation: String? = nil,
      ttime: Temporal.DateTime? = nil,
      time: Int? = nil,
      BOOK: String? = nil,
      Users: List<ScheduleUser>? = [],
      state: Int? = nil,
      MySchedules: List<MySchedule>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.Reservation = Reservation
      self.ttime = ttime
      self.time = time
      self.BOOK = BOOK
      self.Users = Users
      self.state = state
      self.MySchedules = MySchedules
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}