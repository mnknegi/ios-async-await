//
//  UserListViewModel.swift
//  AsyncAwait
//
//  Created by Mayank Negi on 26/10/24.
//

import Foundation

@MainActor
final class UserListViewModel: ObservableObject {

    let service: Service
    @Published var users: [UserViewModel] = []

    let pageIds = [1, 2]

    init(service: Service = Service()) {
        self.service = service
    }

    /**
     Fetch list of users using pageIds
     Every page has 6 users.
     */
    private func fetchUsers(pageId id: Int) async -> [UserViewModel]? {
        let request = URLRequest(url: URL(string: "https://reqres.in/api/users?page=\(id)")!)
        do {
            async let userData: UserData = self.service.performRequest(request)
            return try await userData.data.map { UserViewModel.init(user: $0) }
        } catch {
            print("Error: ", error.localizedDescription)
        }

        return nil
    }

    // Create two child tasks and fetch users concurrently.
    func fetchAllUsers() async {
        self.refreshAllUsers()
        await withTaskGroup(of: [UserViewModel].self) { group in
            for pageId in pageIds {
                group.addTask {
                    await self.fetchUsers(pageId: pageId) ?? []
                }
            }

            for await result in group {
                self.users += result
            }
        }
    }

    private func refreshAllUsers() {
        self.users = []
    }
}

final class UserViewModel {

    let user: User

    init(user: User) {
        self.user = user
    }

    var id: Int {
        self.user.id
    }

    var name: String {
        self.user.firstName.appendingFormat(" %@", self.user.lastName)
    }

    var email: String {
        self.user.email
    }

    var image: String {
        self.user.avatar
    }
}
