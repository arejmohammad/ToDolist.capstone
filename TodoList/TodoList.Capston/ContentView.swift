//
//  ContentView.swift
//  TodoList.Capston
//
//  Created by Areej Mohammad on 02/04/1443 AH.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest (entity: TodoList.entity(), sortDescriptors: [NSSortDescriptor(key:"deadline", ascending:false)], animation: .default)
    private var mylist : FetchedResults<TodoList>
    @State var name : String = ""
    @State var desc : String = ""
    @State var deadline = Date()
    @State var check : Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                    Color.yellow
                      .opacity(0.3)
                    .ignoresSafeArea()
            VStack(alignment: .center, spacing: 7.0) {
                TextField ("name", text: $name)
                    .padding(.horizontal)
                TextField ("description", text: $desc)
                    .padding(.horizontal)
                DatePicker(selection: $deadline, in:Date()... , displayedComponents: .date ) {
                            
                    Text("Select a date : \(deadline.formatted(date: .abbreviated , time: .omitted ))")}

                
                Button {
                    do {
                        let todo = TodoList(context: viewContext)
                        todo.name = name
//                        todo.desc = desc
                        todo.deadline = deadline
                        try viewContext.save()
                    }catch{
                        
                    }
                }label: {
                    Text ("save")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .background(Color .yellow)
                }
                List {
                    if mylist.isEmpty {
                        Text("The list is empty")
                    }else {
                        ForEach(mylist){ todo in
                            NavigationLink ( destination: {
                                EdittodoList (todolist: todo)
                            },label: {
                                HStack {
                                    VStack {
                                        Text(todo.name ?? "")
                                        Text(todo.desc ?? "")
                                        Text(todo.deadline?.asString(style: .full) ?? Date().asString(style: .full))
                                    }
                                    Spacer()
                                    Button {
                                        todo.check = !todo.check
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            
                                        }
                                    }label: {
                                        Image(systemName: todo.check ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(Color(.systemGreen ))
                                    }.buttonStyle(.borderless)

                                }
                            })
                                .swipeActions(edge: .trailing, allowsFullSwipe: true){
                                    Button(role: .destructive) {
                                        if let deletedTodo = mylist.firstIndex(of: todo){
                                            viewContext.delete(mylist[deletedTodo])
                                            do {
                                                try viewContext.save()
                                            }catch {}
                                        }
                                    }label: {
                                        Image(systemName: "trash")
                                    }.tint(.red)
                                }
                        }
                    }
                }
            
            }
            .navigationTitle("To do list 🗓")
            .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistantContainer =
        CoreDataManger.shared.persistentContainer
        ContentView()
//            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, persistantContainer.viewContext)
    }
}
extension Date {
  func asString(style: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
  }
}
