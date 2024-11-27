//
//  UserDetailViewModel.swift
//  AsyncAwait
//
//  Created by Mayank Negi on 27/11/24.
//

import Foundation

@MainActor
final class UserDetailViewModel: ObservableObject {

    /**
     We can pass the whole UserViewModel
     but doing it by making a server call for this tutorial.
     */
    let userId: Int

    let service: Service

    @Published var user: UserViewModel?

    init(service: Service = Service(), userId: Int) {
        self.service = service
        self.userId = userId
    }

    func fetchUser() async {
        let request = URLRequest(url: URL(string: "https://reqres.in/api/users/\(userId)")!)
        do {
            let userDetail: UserDetail = try await self.service.performRequest(request)
            self.user = UserViewModel(user: userDetail.data)
        } catch {
            print("Error: ", error.localizedDescription)
        }
    }
}
