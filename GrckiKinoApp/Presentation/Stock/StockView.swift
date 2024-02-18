//
//  StockView.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import SwiftUI



struct StockView: View {
    let columns = [GridItem](repeating: .init(.flexible()), count: 10)
    let columnsSelected = [GridItem](repeating: .init(.flexible()), count: 7)
    
    @ObservedObject var viewModel: StockViewModel
    @Binding var draw: Draw?
    
    var body: some View {
        ScrollView{
            VStack (alignment: .leading) {
                HStack {
                    Text(LocalizedStringKey(LocalizationKeys.drawTime))
                    Text(draw?.formattedDrawTime ?? "")
                        .monospaced()
                    Text(LocalizedStringKey(LocalizationKeys.round))
                    Text("\(String(draw?.drawId ?? 0))")
                }
                
                HStack (alignment: .center) {
                    Button(action: {
                        viewModel.generateRandomSelections()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 30)
                                .foregroundStyle(.blue.opacity(0.5))
                            Text(LocalizedStringKey(LocalizationKeys.randomSelection))
                        }
                    })
                    Spacer()
                    Text(LocalizedStringKey(LocalizationKeys.numbers))
                        .bold()
                    Picker("", selection: $viewModel.maxSelection) {
                                 ForEach(1...viewModel.maxNumberLimit, id: \.self) { index in
                                     Text("\(index)").tag(index)
                                 }
                             }
                             .pickerStyle(MenuPickerStyle())
                }
                .padding(.top)
             
                LazyVGrid(columns: columnsSelected, spacing: 20) {
                    ForEach(Array(viewModel.selectedNumbers), id: \.self) { number in
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundColor(Color.forNumber(number))
                                .frame(width: 40, height: 40)
                            Text("\(number)")
                        }
                    }
                    if viewModel.selectedNumbers.count > 0 {
                        Button(action: {
                            viewModel.selectedNumbers.removeAll()
                        }) {
                            Label("", systemImage: Images.trash)
                                .labelStyle(.titleAndIcon)
                                .foregroundStyle(.blue.opacity(0.5))
                                .bold()
                                .padding(.leading)
                        }
                    }
                }
                .padding()
                LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(1...80, id: \.self) { number in
                            NumberView(number: number, isSelected: viewModel.selectedNumbers.contains(number)) {
                                if viewModel.selectedNumbers.contains(number) {
                                    viewModel.selectedNumbers.remove(number)
                                } else {
                                    if viewModel.selectedNumbers.count < viewModel.maxSelection {
                                        viewModel.selectedNumbers.insert(number)
                                    }
                                }
                            }
                        }
                    }
                
                Text(String(format: NSLocalizedString(LocalizationKeys.remainingTime, comment: ""), DateUtils.timeRemainingUntilDraw(drawTime: draw?.drawTime ?? 0)))
                    .padding(.top)
                Spacer()
            }
            .padding()
            .accentColor(.white)
        }
        .blackBackground()
        .edgesIgnoringSafeArea(.all)
    }
}

struct NumberView: View {
    let number: Int
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isSelected {
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.forNumber(number))
                        .frame(width: 27, height: 27)
                }
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.05))
                Text("\(number)")
                    .foregroundColor(.white)
                    .font(.title3)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    StockView(viewModel: StockViewModel(), draw:
            .constant(Draw(gameId: 34234,
                           drawId: 34234234,
                           drawTime: 1707840300000
                          )))
}
