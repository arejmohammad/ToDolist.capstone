//
//  EdittodoList.swift
//  TodoList.Capston
//
//  Created by Areej Mohammad on 02/04/1443 AH.
//

import SwiftUI


struct EdittodoList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    @State var name : String = ""
    @State var desc : String = ""
    @State var deadline = Date()

    init(todolist: TodoList? = nil){
        self.todolist = todolist
        _name = State(initialValue: todolist?.name ?? "")
        _desc = State(initialValue: todolist?.desc ?? "")
    }
    var todolist : TodoList?
    var body: some View {
        NavigationView {
            VStack {
                TextField ("name", text:$name)
                TextField("description", text:$desc)
                    .padding(.horizontal)
                DatePicker(selection: $deadline, in: Date()... , displayedComponents: .date) {
                            
                    Text("Select a date : \(deadline.formatted(date: .long, time: .omitted))")}
                
                Button {
                    do {
                        if let todolist = todolist {
                            todolist.name = name
                            todolist.desc = desc
                            todolist.deadline = deadline
                            try viewContext.save()
                        }
                    } catch {
                        
                    }
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Edit")
                }
            }
        }
    }
}
struct UpdateTaskyView_Previews: PreviewProvider {
    static var previews: some View {
        let persistantContainer = CoreDataManger.shared.persistentContainer
        EdittodoList()
            .environment(\.managedObjectContext, persistantContainer.viewContext)
    }
}

