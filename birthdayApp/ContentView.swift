//
//  ContentView.swift
//  birthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var friends: [Friend] = [Friend(name: "Elton Lin", birthday: .now), Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0))]
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        NavigationStack {
            List(friends, id: \.name) { friend in
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday,format: .dateTime.month(.wide).day().year())
                }//end hstack
            }//end list
            .navigationTitle("Birthdays")
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
                        friends.append(newFriend)
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
}//ends struct

#Preview {
    ContentView()
}
