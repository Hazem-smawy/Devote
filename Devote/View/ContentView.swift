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
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
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
                    HStack(spacing: 10) {
                        // title
                        Text("Devote")
                            .font(.system(.largeTitle))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        //edit button
                        
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth:70, minHeight:  24)
                            .background(
                                Capsule()
                                    .stroke(.white,lineWidth: 2)
                            )
                        //appearance button
                        
                        Button {
                            //toggle
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill":"moon.circle")
                                .resizable()
                                .frame(width:24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }

                    }//:HStack
                    .padding()
                    .foregroundColor(.white)
                    Spacer(minLength: 80)
                    
                    // MARK: - new task button
                    Button {
                        showNewTaskView = true
                        playSound(sound: "sound-ding", type: "mp3")
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
                           ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: .black.opacity(0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }//:VStack
                .blur(radius: showNewTaskView ? 8.0  : 0 ,opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                // MARK: - tasks
                if showNewTaskView {
                    BlankView(
                        backgroundColor: isDarkMode ? .black : .gray,
                        backgroundOpacity:isDarkMode ? 0.3 : 0.5
                    )
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
            .navigationBarHidden(true)
            .background(
                BackgroundView()
                    .blur(radius: showNewTaskView ? 8.0 : 0 , opaque: false)
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
