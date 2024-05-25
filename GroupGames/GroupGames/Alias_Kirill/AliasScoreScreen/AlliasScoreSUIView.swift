//
//  AlliasScoreSUIView.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 25.05.2024.
//

import SwiftUI

struct MyUIKitViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var points: Int

    func updateUIViewController(_ uiViewController: AliasGameViewController, context: Context) {

    }

    func makeUIViewController(context: Context) -> AliasGameViewController {
        let controller = AliasGameViewController(viewModel: AliasGameViewModel())
        controller.onDismiss = {
            self.points = controller.viewModel.points
        }
        return controller
    }
}

struct AliasScoreSUIView: View {
    @State private var turning: Int = 0
    @State private var winFlag: (Bool, String, Int) = (false, "", 0)
    @State private var isUIKitScreenPresented = false
    @State private var points: Int = 0
    @State private var showAlert = false
    @State private var closeTupped = false
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: AliasScoreViewModelSUI

    var body: some View {
        VStack(spacing: 0) {
            ScoreContentView(
                viewModel: viewModel,
                turning: $turning,
                winFlag: $winFlag,
                closeTupped: $closeTupped
            )
            .padding(.top, 50)
            .padding(.horizontal, 20)
            Spacer()
            Button(action: {
                isUIKitScreenPresented = true
            }) {
                Text("Начать игру")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 70)
        }
        .background(Color.blue.opacity(0.8))
        .fullScreenCover(
            isPresented: $isUIKitScreenPresented,
            onDismiss: {
                updateScore(with: points)
                if turning == 0 && winFlag.0 {
                    showAlert = true
                }
            },
            content: {
                MyUIKitViewControllerWrapper(points: $points)
                    .toolbar(.hidden)
            })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Поздравляем!!!"),
                message: Text("Команда '\(winFlag.1)' одержала победу!!"),
                dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                })
            )
        }
        .onChange(of: closeTupped, { _, newValue in
            if newValue {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }

    func updateScore(with newScore: Int) {
        let team = viewModel.defaultTeams[turning]
        guard let currentScore = Int(team.3) else { return }
        let updatedScore = currentScore + newScore

        if updatedScore >= AliasUserDefaultsDataManager.shared.getWinPoints() && updatedScore > winFlag.2 {
            winFlag = (true, team.0, updatedScore)
        }

        viewModel.defaultTeams[turning].3 = String(updatedScore)
        passTurn()
    }

    func passTurn() {
        turning = (turning + 1) % viewModel.defaultTeams.count
    }
}

struct ScoreContentView: View {
    @ObservedObject var viewModel: AliasScoreViewModelSUI
    @Binding var turning: Int
    @Binding var winFlag: (Bool, String, Int)
    @Binding var closeTupped: Bool

    var body: some View {
        VStack(spacing: 20) {
            ScoreTitleLabel(teamName: viewModel.defaultTeams[turning].0, closeTupped: $closeTupped)
            StepTeamView(teamImage: viewModel.defaultTeams[turning].1, backgroundColor: viewModel.defaultTeams[turning].2)
            TeamsTableView(viewModel: viewModel)
        }
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 3)
        )
    }
}

struct ScoreTitleLabel: View {
    let teamName: String
    @Binding var closeTupped: Bool

    var body: some View {
        HStack {
            Button(action: {
                closeTupped = true
            }) {
                Image(systemName: "arrowshape.backward")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.black)
            }
            .closeButton()
            Text("Очередь команды '\(teamName)'")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 20)
            Spacer()
        }
    }
}

struct StepTeamView: View {
    let teamImage: UIImage
    let backgroundColor: UIColor

    var body: some View {
        ZStack {
            Color(backgroundColor)
                .frame(width: 150, height: 150)
                .cornerRadius(75)
            Image(uiImage: teamImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
        }
    }
}

struct TeamView: View {
    let teamImage: UIImage
    let backgroundColor: UIColor

    var body: some View {
        ZStack {
            Color(backgroundColor)
                .frame(width: 60, height: 60)
                .cornerRadius(75)
            Image(uiImage: teamImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
        }
    }
}

struct TeamsTableView: View {
    @ObservedObject var viewModel: AliasScoreViewModelSUI

    var body: some View {
        List(0..<viewModel.defaultTeams.count, id: \.self) { index in
            AliasTeamCell(
                teamName: viewModel.defaultTeams[index].0,
                teamImage: viewModel.defaultTeams[index].1,
                backgroundColor: viewModel.defaultTeams[index].2,
                score: viewModel.defaultTeams[index].3
            )
        }
        .listStyle(.plain)
        .frame(minHeight: 0, maxHeight: .infinity)
    }
}

struct AliasTeamCell: View {
    let teamName: String
    let teamImage: UIImage
    let backgroundColor: UIColor
    let score: String

    var body: some View {
        HStack {
            TeamView(teamImage: teamImage, backgroundColor: backgroundColor)
                .padding(.top, 5)
            Text(teamName)
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold))
            Spacer()
            Text(score)
                .foregroundColor(Color.red.opacity(0.7))
                .font(.system(size: 20, weight: .bold))
        }
        .background(Color.white)
        .cornerRadius(30)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white, lineWidth: 3)
        )
    }
}

struct CloseButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 40, height: 40)
            .background(Color.yellow)
            .clipShape(.rect(cornerRadius: 12))
            .padding(.horizontal, 10)
    }
}

extension Button {
    func closeButton() -> some View {
        self.modifier(CloseButtonModifier())
    }
}

#Preview {
    AliasScoreSUIView(viewModel: AliasScoreViewModelSUI(
        defaultTeams: [
            ("Мега Марсиане", UIImage.alien, UIColor.systemRed.withAlphaComponent(0.5)),
            ("Чудесные Лягушки", UIImage.frog, UIColor.systemGreen.withAlphaComponent(0.5))
        ]))
}
