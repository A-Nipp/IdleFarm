//
//  ContentView.swift
//  Shared
//
//  Created by AlecNipp on 11/6/21.
//

import SwiftUI

struct GameSettings {
    static let maxTileWidth = 100.0
    static let maxTileHeight = 100.0
}
struct ContentView: View {
    static let timeDelta = 0.1
    let animals = [Animal(name: "Chicken", multiplier: 1), Animal(name: "Cow", multiplier: 2)]
    
    @State var currentMoney = 0.0
    @State var currentDate = Date()
    @State var animalCount = 0
    @State var animalType = 0
    
    var plots: [FarmPlot] {
        var plots = [FarmPlot]()
        for _ in 0...8 {
            plots.append(FarmPlot())
        }
        return plots
    }

    
    var moneyPerIncrement: Double {
        return Double(animalCount) * animals[animalType].multiplier
    }
    

    
    
    let timer = Timer.publish(every: ContentView.timeDelta, on: .main, in: .common).autoconnect()

    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack{
                Text("$\(currentMoney)")
                    .font(.largeTitle)
                    .onReceive(timer) { input in
                        updateGame(currentTime: input)
                    }
                Spacer()
                PlotGrid(plots: plots)
                Spacer()
                BottomPane(animalCount: $animalCount)
            }
        }
    }
    
    func updateGame(currentTime: Date) {
        currentMoney += moneyPerIncrement * ContentView.timeDelta
    }
    
//    func updateGame(currentTime: Date) {
//        game.update(currentTime)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PlotGrid: View {
    var plots: [FarmPlot]
    var body: some View {
        VStack {
            HStack {
                PlotButton(plot: plots[0])
                PlotButton(plot: plots[1])
                PlotButton(plot: plots[2])
            }
            HStack {
                PlotButton(plot: plots[3])
                Button{
                    
                } label: {
                    Image("Barn_icon")
                    .resizable()
                    .frame(maxWidth: GameSettings.maxTileWidth, maxHeight: GameSettings.maxTileHeight)
                }
                PlotButton(plot: plots[5])
            }
            HStack {
                PlotButton(plot: plots[6])
                PlotButton(plot: plots[7])
                PlotButton(plot: plots[8])
            }
        }
    }
}

struct Animal {
    var name: String
    var multiplier: Double
}

struct PlotButton: View {
    var plot: FarmPlot
    var body: some View {
        Button {
            plot.harvest()
        } label: {
            Text(plot.toString())
        }
        .frame(maxWidth: GameSettings.maxTileWidth, maxHeight: GameSettings.maxTileHeight)
        .foregroundColor(Color.white)
        .background(Color.black)
    }
}
struct BottomPane: View {
    @Binding var animalCount: Int
    var body: some View {
        HStack {
            Button {
                //do something
            } label: {
                Image(systemName: "gear")
            }
            BreedButton(animalCount: $animalCount)
            
            Button {
                //do something
            } label: {
                Image(systemName: "cart")
            }
            
        }
    }
}

struct BreedButton: View {
    @Binding var animalCount: Int
    var body: some View {
        Button("BREED") {
            breedAnimals()
        }
    }
    func breedAnimals() {
        animalCount += 1
    }
}

struct Crop {
    var name: String
    var timeToGrow: Int
    var ticksToHarvest: Int
}

let crops = [Crop(name: "Wheat", timeToGrow: 5, ticksToHarvest: 10),
             Crop(name: "Barley", timeToGrow: 10, ticksToHarvest: 15)
]
class FarmPlot {
    
    var level: Int
    var dateLastHarvested: Date
    var growthPeriod: DateComponents
    var currentCrop: Crop
    var isReadyToHarvest: Bool
    var isHarvesting: Bool
    var harvestRate: Int
    var ticksToHarvest: Int
    
    init() {
        level = 0
        currentCrop = crops[level]
        dateLastHarvested = Date()
        growthPeriod = DateComponents()
        growthPeriod.second = currentCrop.timeToGrow
        isReadyToHarvest = false
        isHarvesting = false
        harvestRate = 1
        ticksToHarvest = currentCrop.ticksToHarvest
    }
    
    
    
    func getIncomePerHarvest() -> Double {
        return Double(pow(10, Double(level)))
    }
    
    func toString() -> String {
        return crops[level].name
    }
    func upgrade() -> Void {
        level += 1
    }
    func update(currentDate: Date) -> Void {
        if isReadyToHarvest{
            // don't check for harvest
        }
        else {
            checkForHarvest(currentDate: currentDate)
        }
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
    func harvest() {
        // Do nothing yet
        if isReadyToHarvest {
            
        }
    }
}
