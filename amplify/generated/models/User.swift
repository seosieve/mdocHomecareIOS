// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var name: String?
  public var patientNumber: String?
  public var phoneNumber: String?
  public var email: String?
  public var status: String?
  public var lastOnlineAt: Int?
  public var schedules: List<ScheduleUser>?
  public var Messages: List<Message>?
  public var Questionnaries: List<Questionnarie>?
  public var chatrooms: List<ChatRoomUser>?
  public var state: Int?
  public var MySchedules: List<MySchedule>?
  public var sex: String?
  public var born: String?
  public var phoneNOK: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String? = nil,
      patientNumber: String? = nil,
      phoneNumber: String? = nil,
      email: String? = nil,
      status: String? = nil,
      lastOnlineAt: Int? = nil,
      schedules: List<ScheduleUser>? = [],
      Messages: List<Message>? = [],
      Questionnaries: List<Questionnarie>? = [],
      chatrooms: List<ChatRoomUser>? = [],
      state: Int? = nil,
      MySchedules: List<MySchedule>? = [],
      sex: String? = nil,
      born: String? = nil,
      phoneNOK: String? = nil) {
    self.init(id: id,
      name: name,
      patientNumber: patientNumber,
      phoneNumber: phoneNumber,
      email: email,
      status: status,
      lastOnlineAt: lastOnlineAt,
      schedules: schedules,
      Messages: Messages,
      Questionnaries: Questionnaries,
      chatrooms: chatrooms,
      state: state,
      MySchedules: MySchedules,
      sex: sex,
      born: born,
      phoneNOK: phoneNOK,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String? = nil,
      patientNumber: String? = nil,
      phoneNumber: String? = nil,
      email: String? = nil,
      status: String? = nil,
      lastOnlineAt: Int? = nil,
      schedules: List<ScheduleUser>? = [],
      Messages: List<Message>? = [],
      Questionnaries: List<Questionnarie>? = [],
      chatrooms: List<ChatRoomUser>? = [],
      state: Int? = nil,
      MySchedules: List<MySchedule>? = [],
      sex: String? = nil,
      born: String? = nil,
      phoneNOK: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.patientNumber = patientNumber
      self.phoneNumber = phoneNumber
      self.email = email
      self.status = status
      self.lastOnlineAt = lastOnlineAt
      self.schedules = schedules
      self.Messages = Messages
      self.Questionnaries = Questionnaries
      self.chatrooms = chatrooms
      self.state = state
      self.MySchedules = MySchedules
      self.sex = sex
      self.born = born
      self.phoneNOK = phoneNOK
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}