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
                HStack {
                    AsyncImage(url: URL(string: user.image)) { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }

                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title3)

                        Text(user.email)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
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
