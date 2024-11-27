//
//  UserRowView.swift
//  AsyncAwait
//
//  Created by Mayank Negi on 27/11/24.
//

import SwiftUI

struct UserRowView: View {

    let user: UserViewModel

    var body: some View {
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
}

#Preview {
    UserRowView(user: UserViewModel(user: User(id: 1, firstName: "abc", lastName: "xyz", email: "abc.xyz@gmail.com", avatar: "https://reqres.in/img/faces/2-image.jpg")))
}
