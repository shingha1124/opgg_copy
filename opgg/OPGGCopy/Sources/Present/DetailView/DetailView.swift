//
//  DetailView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject private var viewModel: DetailViewModel
    private let topView: DetailTopView
    private let prevSeasonsView: PreviousSeasonsView
    private let leagueStatsView: LeagueStatsView
    private let navigationConfigurator: NavigationConfigurator
    
    @State var navbarBackgroundAlpha: CGFloat = 0
    
    init(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        topView = DetailTopView(viewModel.viewModels.topView)
        prevSeasonsView = PreviousSeasonsView(viewModel.viewModels.prevSeasons)
        leagueStatsView = LeagueStatsView(viewModel.viewModels.leagueStats)
        navigationConfigurator = NavigationConfigurator()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: OffsetPreferenceKey.self,
                        value: proxy.frame(
                            in: .named("ScrollViewOrigin")
                        ).origin.y
                    )
                }
                .frame(width: 0, height: 0)
                
                LazyVStack(alignment: .leading, spacing: 0) {
                    topView
                    Group {
                        prevSeasonsView
                        leagueStatsView
                    }
                    .background(Color.systemBackground2)
                }
                .padding(.top, 70)
            }
            .coordinateSpace(name: "ScrollViewOrigin")
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                var navbarAlpha = offset * -1 / 180
                navbarAlpha = max(navbarAlpha, 0)
                navbarAlpha = min(navbarAlpha, 1)
                navbarBackgroundAlpha = navbarAlpha
            }
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .top) {
            ZStack {
                CustomNavBar(left: {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.liner(from: .white, to: .blue2, value: navbarBackgroundAlpha))
                    }
                }, center: {
                    Text(viewModel.state.summonerName)
                        .font(.system(size: 19).weight(.bold))
                        .foregroundColor(.systemDarkgrey.opacity(navbarBackgroundAlpha))
                }, right: {
                    Text("3")
                        .font(.system(size: 19).weight(.bold))
                })
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.systemBackground2.opacity(navbarBackgroundAlpha))
            }
        }
        .onAppear {
            viewModel.action.onAppear.send(())
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(DetailViewModel("zkDo7tkDVQsxjkwzskG9-ixLhBHvxOQgB9p9ULVcO1HmtA"))
                .environment(\.colorScheme, .light)
            
            DetailView(DetailViewModel("zkDo7tkDVQsxjkwzskG9-ixLhBHvxOQgB9p9ULVcO1HmtA"))
                .environment(\.colorScheme, .dark)
        }
    }
}

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { }
}
