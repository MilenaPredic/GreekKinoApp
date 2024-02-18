//
//  AppConstants.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 15.2.24..
//

import Foundation

enum APIConstants {
    // Base url
    static let baseURL = "https://api.opap.gr/draws/"
}

enum WebViewConstants {
    // Url
    static let webViewUrl = "https://mozzartbet.com/sr/lotto-animation/26#"
}

enum Images {
    static let trash = "trash"
    static let clock = "clock"
    static let square = "squareshape.split.2x2"
    static let play = "play.circle"
    static let results = "r.circle"
}

enum LocalizationKeys {
    // Tabs
    static let upcomingDrawsTitle = "upcoming_draws_title"
    static let ticketTitle = "ticket_title"
    static let liveDrawTitle = "live_draw_title"
    static let resultsTitle = "results_title"

    // Upcoming Draws
    static let upcomingDraws = "upcoming_draws"
    static let drawingTime = "drawing_time"
    static let remaining = "remaining_for_submission"

    // Stock
    static let drawTime = "draw_time"
    static let round = "round"
    static let randomSelection = "random_selection"
    static let numbers = "numbers"
    static let maxNumbers = "max_number_of_selections"
    static let remainingTime = "remaining_time_for_submission"

    // Results
    static let drawingTimeDate = "drawing_time_with_date"
    static let roundNumber = "round_number"
}
