//
//  UpcomingDraws.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import SwiftUI

struct UpcomingDraws: View {
    @ObservedObject var viewModel: UpcomingDrawsViewModel
    @Binding var selectedTab: Tab
    
    var body: some View {
        ScrollView{
            VStack{
                Text(LocalizedStringKey(LocalizationKeys.upcomingDraws))
                    .font(.title)
                    .padding(.bottom)
                HStack{
                    Text(LocalizedStringKey(LocalizationKeys.drawTime))
                    Spacer()
                    Text(LocalizedStringKey(LocalizationKeys.remaining))
                }
                .font(.footnote)
                .bold()
                .padding(.vertical)
                
                ForEach(viewModel.draws) { draw in
                    Button(action: {
                        self.selectedTab = .stock
                        viewModel.selectedDraw = draw
                    }) {
                        HStack {
                            Text(draw.formattedDrawTime ?? "")
                            Spacer()
                            Text(DateUtils.timeRemainingUntilDraw(drawTime: draw.drawTime))
                                .foregroundColor(.gray)
                        }
                        .monospaced()
                        .padding(.horizontal)
                        .contentShape(Rectangle())
                    }
                    Divider().background(.blue)
                }
                Spacer()
            }
            .padding()
            .blackBackground()
           
        }  .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.getUpcomingDraws()
            }
    }
}
    #Preview {
        UpcomingDraws(viewModel:
                        UpcomingDrawsViewModel(repository:
                                                DrawsRepository(networkingService:
                                                                    NetworkingService())),
                      selectedTab: .constant(.upcomingDraws))
    }
