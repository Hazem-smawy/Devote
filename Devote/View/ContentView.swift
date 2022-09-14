//
//  ContentView.swift
//  Devote
//
//  Created by hazem smawy on 9/13/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Property
    @Environment(\.managedObjectContext) private var viewContext
    @State var task:String = ""
    @State private var showNewTaskView :Bool = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - Function
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
              
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - main view
                
                
                VStack {
                    // MARK: - header
                    Spacer(minLength: 80)
                    
                    // MARK: - new task button
                    Button {
                        showNewTaskView = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(LinearGradient(gradient: Gradient(colors: [.pink,.blue]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(Capsule())
                    )
                    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
                   

                  // MARK: - list
                    List {
                        ForEach(items) { item in
                            VStack (alignment:.leading){
                                Text(item.task ?? " ")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text("Item in \(item.timestamp! , formatter:itemFormatter)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                            }
                            .padding()//:VStack
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: .black.opacity(0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }//:VStack
               
                // MARK: - tasks
                if showNewTaskView {
                    BlankView()
                        .onTapGesture {
                            withAnimation(){
                                showNewTaskView = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskView)
                }
                    
            }//:ZStack
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationBarTitle("Daily Task",displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .background(
                BackgroundView()
            )
            .background(
                backgroundGradient
            )
                
        }//:nav
        .navigationViewStyle(StackNavigationViewStyle())
      
    }


}


// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
