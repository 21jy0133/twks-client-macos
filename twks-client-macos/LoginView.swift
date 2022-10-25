//
//  LoginView.swift
//  twks-client-macos
//
//  Created by xiaoyue on 2022/10/23.
//

import SwiftUI

// Capture part of the screen

struct LoginView: View {
    @EnvironmentObject var userState : UserState
    
    @State private var username = ""
    @State private var password = ""
    
    @State private var loginFailedAlert = false
    @State private var loginFailedMessage = "Failed"
    
    
    func handleSignIn() {
        print("Hello, sign in!")
        let url = URL(string: "http://localhost:8000/auth/login/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let requestData = ["email": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {

                        print("Error took place \(error)")
                self.loginFailedAlert = true
                self.loginFailedMessage = "Failed once"

                        return

            }

            guard let data = data else { return }
            do {
                let objectJson = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                
                
                
                let data = objectJson["data"] as! Dictionary<String, Any>
                
                userState.login(accessToken: data["accessToken"] as! String, refreshToken: data["refreshToken"] as! String)
                
                
                print(objectJson)
            } catch let error {
                print("error", error)
            }
        }
        task.resume()
    }
    
    var body: some View {
        VStack{
            
            // Welcome
            VStack(spacing:15){
                Text("Hello There")
                Text(UserDefaults.standard.string(forKey: "accessToken")!)
                Text(String(userState.isLoginedIn))
                Text("Please sign in to continue.")
            }
            .padding(.top,45)
            Spacer()
            
            // Form
            VStack(spacing: 15){
                VStack(alignment: .center, spacing: 30){
                    VStack(alignment: .center) {
                        TextField("User name (email address)", text:$username)
                            .textContentType(.oneTimeCode)
                        Divider()
                            .background(Color.gray)
                    }
                    VStack(alignment: .center) {
                        TextField("Password", text:$password)
                            .textContentType(.oneTimeCode)
                        Divider()
                            .background(Color.gray)
                    }
                }
                HStack{
                    Spacer()
                    Button(action: {}){
                        Text("Forgot Pass?")
                        
                    }
                }
            }.alert(isPresented: $loginFailedAlert) { // 4
                
                Alert(
                    title: Text("Login failed"),
                    message: Text("Message")
                )}
            .padding(.horizontal,35)
            Button(action: {
                
                //self.handleSignIn()
                
                let task = Process()
                task.launchPath = "/usr/sbin/screencapture"
                var arguments = [String]()
                arguments.append("-x")
                let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
                let cachePath = String(describing: cacheURL?.absoluteString)
                print(cachePath)
                arguments.append(cachePath + "/Screenshot111" + ".png")
                task.arguments = arguments
                task.launch()
                
                
            }) {
                
                Text("Sign in")}
        }
        .padding(.bottom,30)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
