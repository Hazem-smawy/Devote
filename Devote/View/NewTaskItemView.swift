//
//  SwiftUIView.swift
//  Devote
//
//  Created by hazem smawy on 9/14/22.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - Property
    @AppStorage("isDarkMode") private var isDarkMode:Bool = true
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task:String = ""
    @Binding var isShowing: Bool
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    // MARK: - Function
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
              
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }

  
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                TextField(" New Task", text: $task)
                    .padding()
                    .background(
                        isDarkMode
                            ? Color(UIColor.tertiarySystemBackground)
                            : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                    .foregroundColor(.pink)
                    .font(.system(size: 24,weight: .bold, design: .rounded))
                
                Button {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                } label: {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .onTapGesture(perform: {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                })
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? .blue : .pink)
                .cornerRadius(10)
                

            }//:VStack
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode
                    ? Color(UIColor.secondarySystemBackground)
                    : Color.white
            )
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.65), radius: 24)
            .frame(maxWidth: 640)
            
        }//:VStack
        .padding()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
