//
//  RedmineKeyView.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import SwiftUI

struct RedmineKeyView: View {
    @Binding var shouldShow: Bool
    
    @State private var savedKey = UserDefaults.standard.string(forKey: SaveKey.redmineKey.rawValue) {
        didSet {
            if savedKey != nil {
                redmineKey = savedKey!
            }
        }
    }
    @State private var redmineKey: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Redmine API Key"), footer:
                                HStack(spacing: 0) {
                                    Text("Copy your Redmine API key from ")
                                        .foregroundColor(.gray)
                                    
                                    Text("here.")
                                        .foregroundColor(.blue)
                                        .underline()
                                        .onTapGesture {
                                            let url = URL.init(string: "https://redmine.lightningkite.com/my/account")
                                            guard let stackOverflowURL = url, UIApplication.shared.canOpenURL(stackOverflowURL) else { return }
                                            UIApplication.shared.open(stackOverflowURL)
                                        }
                                }
                            ) {
                        TextField("Enter Redmine Key", text: $redmineKey)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    UserDefaults.standard.set(self.redmineKey, forKey: SaveKey.redmineKey.rawValue)
                    self.shouldShow.toggle()
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, maxHeight: 36)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()
                })
            }
            .navigationTitle("Settings")
        }
    }
}

struct RedmineKeyView_Previews: PreviewProvider {
    static var previews: some View {
        RedmineKeyView(shouldShow: .constant(true))
    }
}
