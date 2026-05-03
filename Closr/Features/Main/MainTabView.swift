
//
//  MainTabView.swift
//  Closr
//
//  Created by Aditya Varshney on 03/05/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(AppColors.backgroundSecondary)
        
        // Remove border line
        appearance.shadowColor = .clear

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor(AppColors.textSecondary)
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(AppColors.textSecondary), .font: UIFont.systemFont(ofSize: 10, weight: .medium)]
        
        itemAppearance.selected.iconColor = UIColor(AppColors.brand)
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(AppColors.brand), .font: UIFont.systemFont(ofSize: 10, weight: .bold)]

        appearance.stackedLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)

            Text("Explore")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
                .tag(1)

            Text("Discuss")
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                    Text("Discuss")
                }
                .tag(2)

            MemoriesView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Memories")
                }
                .badge("!") 
                .tag(3)

            Text("Us")
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "heart.fill" : "heart")
                    Text("Us")
                }
                .tag(4)
        }
        .tint(AppColors.brand)
    }
}

#Preview {
    MainTabView()
}
