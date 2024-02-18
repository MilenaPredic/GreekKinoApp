//
//  ResultsView.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: ResultsViewModel

    let columns = [GridItem](repeating: .init(.flexible()), count: 7)
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.draws) { draw in
                    VStack(alignment: .leading) {
                        HStack{
                            Text(String(format: NSLocalizedString(LocalizationKeys.drawTime, comment: "")))
                            Text("\(draw.formattedDrawDate ?? "")")
                            Text("\(draw.formattedDrawTime ?? "")")
                                .monospaced()
                            Text(String(format: NSLocalizedString(LocalizationKeys.round, comment: "")))
                            Text("\(String(draw.drawId))")
                        }
                        .font(.subheadline)
                        .frame(height: 30, alignment: .leading)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .background(.gray.opacity(0.40))
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(draw.winningNumbers.list, id: \.self) { number in
                                ZStack {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(Color.forNumber(number))
                                        .frame(width: 40, height: 40)
                                    
                                    Text("\(number)")
                               
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .blackBackground()
        .onAppear(perform: {
            viewModel.getResultsForToday()
        })
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(viewModel: 
                        ResultsViewModel(repository:
                                            DrawsRepository(networkingService:
                                                                NetworkingService())))
    }
}
