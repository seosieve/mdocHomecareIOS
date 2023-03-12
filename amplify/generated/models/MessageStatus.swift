// swiftlint:disable all
import Amplify
import Foundation

public enum MessageStatus: String, EnumPersistable {
  case sent = "SENT"
  case delivered = "DELIVERED"
  case read = "READ"
}