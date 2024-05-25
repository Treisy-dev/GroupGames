//
//  FiveSecondsPlayersSUIView.swift
//  GroupGames
//
//  Created by Давид Васильев on 25.05.2024.
//

import SwiftUI

struct MyUIKitViewControllerWrapper: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: FiveSecondsGameScreenViewController, context: Context) {

    }

    let namesPlayers: [(String, UIImage)]
    func makeUIViewController(context: Context) -> FiveSecondsGameScreenViewController {
        let controller = FiveSecondsGameScreenViewController(viewModel: FiveSecondsGameScreenViewModel(namesPlayers: namesPlayers))
        return controller
    }
}

struct AddPlayerButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 60, height: 60)
            .background(Color.black.opacity(0.1))
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.blue, lineWidth: 3))
            .padding(.trailing, 16)
    }
}

extension Button {
    func addPlayerButton() -> some View {
        self.modifier(AddPlayerButtonModifier())
    }
}

struct FiveSecondsPlayersSUIView: View {
    @ObservedObject var viewModel = FiveSecondsPlayersViewModelSUI()
    var body: some View {
        ZStack {
            BackView()
            VStack {
                TopView()
                    .padding(.top, 50)
                PlayersView(viewModel: viewModel, players: viewModel.players)
                    .padding(.top, 10)
                Spacer()
                BottomView(viewModel: viewModel)
                    .padding(.bottom, 80)
            }
        }
    }
}

struct BackView: View {
    var body: some View {
        Image(.backOrange)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
}

struct TopView: View {
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(.exit5S)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 40, height: 40)
            .padding(.leading, -45)
            Text("Добавьте игроков")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 26))
        }
    }
}

struct PlayersView: View {
    @ObservedObject var viewModel: FiveSecondsPlayersViewModelSUI
    var players: [Player]
    var body: some View {
        ForEach(players) { player in
            PlayerViewCell(viewModel: viewModel, player: player)
        }
        .listRowBackground(Capsule().fill(Color.clear).padding(.vertical, 2).padding(.horizontal, 20))
        .listRowSeparator(.hidden)
        .background(Color.clear)
        .padding(.horizontal)
        .padding(.trailing, 20)
        .padding(.leading, 20)
        .padding(.top, 16)
        .frame(minHeight: 50, maxHeight: 80)
    }

}

struct PlayerViewCell: View {
    @ObservedObject var viewModel: FiveSecondsPlayersViewModelSUI
    let player: Player
    var body: some View {
        HStack {
            Image(uiImage: player.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.leading, 10)
            Text(player.name)
                .bold()
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                viewModel.deletePlayer(name: player.name)
            }) {
                Image(.trash5S)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 40, height: 40)
        }
        .padding(4)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct BottomView: View {
    @ObservedObject var viewModel: FiveSecondsPlayersViewModelSUI
    @Environment(\.presentationMode) private var presentationMode
    @State private var isPresented: Bool = false
    var body: some View {
        HStack {
            Button(action: {
                viewModel.addPlayer()
            }) {
                Text("+")
                    .padding()
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(.white)
            }
            .addPlayerButton()
            Button(action: {
                isPresented = true
            }) {
                Text("Начать игру")
                    .padding()
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(width: 240, height: 60)
            .background(Color.black.opacity(0.1))
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.blue, lineWidth: 3))
        }
        .frame(height: 30)
        .fullScreenCover(isPresented: $isPresented, content: {
            MyUIKitViewControllerWrapper(namesPlayers: viewModel.players.map({($0.name, $0.image)}))
                .toolbar(.hidden)
        })
    }
}

struct Player: Identifiable {
    var id: UUID
    let name: String
    let image: UIImage
}

#Preview {
    FiveSecondsPlayersSUIView()
}
