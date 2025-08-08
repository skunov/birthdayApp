//
//  ContentView.swift
//  birthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    /*= [Friend(name: "Elton Lin", birthday: .now), Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0))]*/
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @State private var selectedFriend: Friend?
    
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    HStack {
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday,format: .dateTime.month(.wide).day().year())
                    }//end hstack
                    .onTapGesture {
                        selectedFriend = friend
                    }//end Tap gesture
                }//end foreach loop
                .onDelete(perform: deleteFriend)
            }//end list
            .navigationTitle("Birthdays")
            .sheet(item: $selectedFriend) { friend in
                NavigationStack {
                    EditFriendView(friend: friend)
                }//ends nav stack
                
            }//ends sheet
            
            .safeAreaInset(edge:.bottom){
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday,
                               in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }//ends DatePicker
                    
                    Button("Save"){
                        let newFriend = Friend(name: newName, birthday: newBirthday)
//                        friends.append(newFriend)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }//ends button
                    
                    .bold()
                    
                }//end Vstack
                .padding()
                .background(.bar)
            }//end safeAreaInset
        }//end Nav
    }//ends body
    
    func deleteFriend(at offsets: IndexSet) {
        for index in offsets {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }//ends for loop
    }//ends deleteFriend function
    
}//ends struct

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
