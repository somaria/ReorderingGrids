//
//  ContentView.swift
//  ReOrderingGrids
//
//  Created by daryl on 5/1/24.
//

import SwiftUI
import WrappingHStack


struct ContentView: View {
    
    @State private var colors: [String] = ["This is a", "cat", "and", "a mouse", "a dog", "the dragon"]
    
    @State private var draggingItem: String?
    
    var body: some View {
        //        NavigationStack {
        
        //                let columns = Array(repeating: GridItem(spacing: 10), count: 3)
        
        ScrollView {
            WrappingHStack(alignment: .leading) {
                
                ForEach(colors, id: \.self) { color in
                    //                        GeometryReader {
                    //                            let _ = $0.size
                    
                    Text(color)
                        .fixedSize()
                        .padding(.leading, 3)
                        .padding(.trailing, 3)
                    
                        .font(.largeTitle)
                        .draggable(color) {
                            Text(color)
                                .border(.red)
                                .onAppear {
                                    draggingItem = color
                                }
                        }
                        .dropDestination(for: String.self) { items, location in
                            draggingItem = nil
                            return false
                        } isTargeted: { status in
                            
                            if let draggingItem, status, draggingItem != color {
                                
                                if let sourceIndex = colors.firstIndex(of: draggingItem),
                                   
                                    let destinationIndex = colors.firstIndex(of: color) {
                                    
                                    withAnimation(.bouncy) {
                                        let sourceItem = colors.remove(at: sourceIndex)
                                        
                                        colors.insert(sourceItem, at: destinationIndex)
                                        
                                    }
                                    
                                }
                                
                            }
                            //                                    }
                        }
                        .padding(.leading, 6)
                }
                Spacer()
            }
            
            
            Button {
            } label: {
                Text("Submit")
            }
            
        }
    }
    
}

#Preview {
    ContentView()
}
