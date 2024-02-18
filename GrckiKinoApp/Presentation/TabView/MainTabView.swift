//
//  TabView.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import SwiftUI
import Combine

public enum Tab: Hashable {
        case upcomingDraws
        case stock
        case liveDraws
        case results
}

struct MainTabView: View {
    
    @State public var selectedTab = Tab.upcomingDraws
    private var cancellables = Set<AnyCancellable>()
    @StateObject var viewModel: UpcomingDrawsViewModel
    @StateObject var resultsViewModel: ResultsViewModel
    @StateObject var stockViewModel: StockViewModel

    init() {
        let networkingService = NetworkingService()
        let repository = DrawsRepository(networkingService: networkingService)
        _viewModel = StateObject(wrappedValue: UpcomingDrawsViewModel(repository: repository))
        _resultsViewModel = StateObject(wrappedValue: ResultsViewModel(repository: repository))
        _stockViewModel = StateObject(wrappedValue: StockViewModel())
        
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().isOpaque = false
    }
    
    var body: some View {
        
        TabView (selection: $selectedTab) {
            UpcomingDraws(viewModel: viewModel,
                          selectedTab: $selectedTab)
                .tabItem {
                    Label(NSLocalizedString(LocalizationKeys.upcomingDrawsTitle, comment: ""), 
                          systemImage: Images.clock)
                }
                .tag(Tab.upcomingDraws)
            
            StockView(viewModel: stockViewModel,
                      draw: $viewModel.selectedDraw)
                .tabItem {
                    Label(NSLocalizedString(LocalizationKeys.ticketTitle, comment: ""), 
                          systemImage: Images.square)
                }
                .tag(Tab.stock)
            
            LiveDrawView()
                .tabItem {
                    Label(NSLocalizedString(LocalizationKeys.liveDrawTitle, comment: ""),
                          systemImage: Images.play)
                }
                .tag(Tab.liveDraws)
            
            ResultsView(viewModel: resultsViewModel)
                .tabItem {
                    Label(NSLocalizedString(LocalizationKeys.resultsTitle, comment: ""),
                          systemImage: Images.results)
                }
                .tag(Tab.results)
        }
        .accentColor(.yellow)
    }
}

#Preview {
    MainTabView()
}
