//
//  LastTryApp.swift
//  LastTry
//
//  Created by Dev Katyal on 2025-06-12.
//

import SwiftUI

@main
struct LastTryApp: App {
    @StateObject private var viewModel = AppViewModel()
    @StateObject private var achievementViewModel = AchievementViewModel()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.hasCompletedOnboarding {
                MainNavigationView()
                    .environmentObject(viewModel)
                    .environmentObject(achievementViewModel)
            } else {
                SplashView()
                    .environmentObject(viewModel)
                    .environmentObject(achievementViewModel)
            }
        }
    }
}
