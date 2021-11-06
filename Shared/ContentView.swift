//
//  ContentView.swift
//  Shared
//
//  Created by AlecNipp on 11/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var currentMoney = 0.0
    @State var moneyDelta = 1
    
    let timeIncrement = 0.1
    
    var body: some View {
        ZStack {
            VStack{
                Text("$\(currentMoney)")
                    .font(.largeTitle)
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
