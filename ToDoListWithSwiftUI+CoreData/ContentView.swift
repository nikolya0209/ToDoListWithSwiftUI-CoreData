//
//  ContentView.swift
//  ToDoListWithSwiftUI+CoreData
//
//  Created by MacBookPro on 19.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var newOrder = ""
    
    var body: some View {
        List {
            Section(header: Text("NewOrder")) {
                HStack {
                    TextField("New order", text: $newOrder)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
