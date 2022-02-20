//
//  ContentView.swift
//  ToDoListWithSwiftUI+CoreData
//
//  Created by MacBookPro on 19.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Order.entity(),
                  sortDescriptors: [
        NSSortDescriptor(keyPath: \Order.drink,
                         ascending: true)
    ]) var orders: FetchedResults<Order>
    
    @State private var newOrder = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("NewOrder")) {
                    HStack {
                        TextField("New order", text: $newOrder)
                        Button(action: {
                            let order = Order(context: self.managedObjectContext)
                            order.drink = self.newOrder
                            order.createdAt = Date()
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            self.newOrder = ""
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                    }
                }
                Section(header: Text("Your Orders")) {
                    ForEach(self.orders, id: \.self) { order in
                        OderItemView(drink: order.drink ?? "choose drink", createdAt: "\(String(describing: order.createdAt))")
                    }.onDelete(perform: removeOrder)
                }
            }.navigationBarTitle(Text("Order View"))
            .navigationBarItems(trailing: EditButton())
        }
    }
    func removeOrder(at offSets: IndexSet) {
        for index in offSets {
            let man = orders[index]
            managedObjectContext.delete(man)
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct OderItemView: View {
    var drink: String = ""
    var createdAt: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(drink).font(.headline)
                Text(createdAt).font(.caption)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
