//
//  UserState.swift
//  twks-client-macos
//
//  Created by xiaoyue on 2022/10/24.
//
import Foundation

class UserState: ObservableObject {
    @Published var name = ""
    @Published var status = ""
    @Published var isLoginedIn = false
    
    
    func login(accessToken: String, refreshToken: String) {
        print(accessToken)
        print(refreshToken)
        UserDefaults.standard.set(accessToken, forKey:"accessToken")
        UserDefaults.standard.set(refreshToken, forKey:"refreshToken")
        
        DispatchQueue.main.async {
            self.isLoginedIn = true
        }
    }
    
    func start
    
    
}
