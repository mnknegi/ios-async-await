//
//  UserDetailScreen.swift
//  AsyncAwait
//
//  Created by Mayank Negi on 27/11/24.
//

import SwiftUI

struct UserDetailScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 200, height: 200)

            VStack {
                Text("abc xyz")
                Text("abc@gmail.com")
            }
            .font(.title2)
            .fontWeight(.medium)
            .padding()
        }
    }
}

#Preview {
    UserDetailScreen()
}
