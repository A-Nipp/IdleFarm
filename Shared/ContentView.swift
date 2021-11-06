//
//  ContentView.swift
//  Shared
//
//  Created by AlecNipp on 11/6/21.
//

import SwiftUI

class Game {
    var plots: Array<FarmPlot>
    init() {
        plots = [FarmPlot]()
        for _ in 0...8 {
            plots.append(FarmPlot())
        }
    }
}

struct ContentView: View {
    @State var currentMoney = 0.0
    @State var moneyPerIncrement = 1.0
    @State var currentDate = Date()
    @State var animalCount = 0
    
    
    static let timeDelta = 0.1
    
    let timer = Timer.publish(every: timeDelta, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack{
                Text("$\(currentMoney)")
                    .font(.largeTitle)
                    .onReceive(timer) { input in
                        currentMoney += moneyPerIncrement * ContentView.timeDelta
                    }
                Spacer()
                PlotGrid()
                Spacer()
                BottomPane()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PlotGrid: View {
    var body: some View {
        VStack {
            HStack {
                Button("0") {}
                Button("1") {}
                Button("2") {}
            }
            HStack {
                Button("3") {}
                Button("4") {}
                Button("5") {}
            }
            HStack {
                Button("6") {}
                Button("7") {}
                Button("8") {}
            }
        }
    }
}

struct BottomPane: View {
    var body: some View {
        HStack {
            Button {
                //do something
            } label: {
                Image(systemName: "gear")
            }
            BreedButton()
            
            Button {
                //do something
            } label: {
                Image(systemName: "cart")
            }
            
        }
    }
}

struct BreedButton: View {
    var body: some View {
        Button("BREED") {
            //Breed da animals
        }
    }
}

class FarmPlot {
    static let levelProgressionLabels = ["Wheat", "Barley", "Soy", "Hemp"]
    static let timeToHarvestArray = [5, 10, 15, 20]
    
    var level: Int
    var dateLastHarvested: Date
    var growthPeriod: DateComponents
    var isReadyToHarvest: Bool
    
    init() {
        level = 0
        dateLastHarvested = Date()
        growthPeriod = DateComponents()
        growthPeriod.second = FarmPlot.timeToHarvestArray[level]
        isReadyToHarvest = false
    }
    
    
    
    func getIncomePerHarvest() -> Double {
        return Double(pow(10, Double(level)))
    }
    
    func toString() -> String {
        return FarmPlot.levelProgressionLabels[level]
    }
    func upgrade() -> Void {
        level += 1
    }
    func checkForHarvest(currentDate: Date) -> Void {
        let harvestDate = Calendar.current.date(byAdding: growthPeriod, to: currentDate)
        if currentDate > harvestDate! {
            isReadyToHarvest = true
        }
        else {
            isReadyToHarvest = false
        }
    }
}
