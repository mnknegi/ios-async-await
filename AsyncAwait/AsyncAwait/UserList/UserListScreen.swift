//
//  UserListScreen.swift
//  AsyncAwait
//
//  Created by Mayank Negi on 26/10/24.
//

import SwiftUI

struct UserListScreen: View {

    @StateObject var viewModel = UserListViewModel()

    var body: some View {
        NavigationStack {
            List(self.viewModel.users, id: \.id) { user in
                UserRowView(user: user)
            }
            .task {
                await self.viewModel.fetchAllUsers()
            }
            .listStyle(.plain)
            .navigationTitle("Employees")
            .toolbar {
                Button(action: {
                    Task {
                        await self.viewModel.fetchAllUsers()
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                })
            }
        }
    }
}

#Preview {
    UserListScreen()
}
