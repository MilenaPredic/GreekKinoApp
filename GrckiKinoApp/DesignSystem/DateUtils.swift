//
//  DateUtils.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 15.2.24..
//

import Foundation

struct DateUtils {
    
    static func formatTimestamp(_ timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp / 1000)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    static func formatDrawTime(drawTime: TimeInterval) -> (date: String, time: String) {
        let date = Date(timeIntervalSince1970: drawTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM"
        let formattedDate = dateFormatter.string(from: date)

        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: date)
        return (date: formattedDate, time: formattedTime)
    }
    
    static func timeRemainingUntilDraw(drawTime: TimeInterval) -> String {
        let drawDate = Date(timeIntervalSince1970: drawTime / 1000)
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: drawDate)
        if let hours = remaining.hour, let minutes = remaining.minute, let seconds = remaining.second {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        return "00:00:00"
    }
}
