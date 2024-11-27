//
//  UserDetailScreen.swift
//  AsyncAwait
//
//  Created by Mayank Negi on 27/11/24.
//

import SwiftUI

struct UserDetailScreen: View {

    @StateObject var viewModel: UserDetailViewModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string:viewModel.user?.image ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 200, height: 200)
            } placeholder: {
                ProgressView()
            }

            VStack {
                Text(viewModel.user?.name ?? "")
                Text(viewModel.user?.email ?? "")
            }
            .font(.title2)
            .fontWeight(.medium)
            .padding()
        }
        .task {
            await viewModel.fetchUser()
        }
        .navigationTitle("\(viewModel.user?.name ?? "Welcome User")")
    }
}

#Preview {
    UserDetailScreen(viewModel: UserDetailViewModel(userId: 1))
}
