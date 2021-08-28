//
//  ContentView.swift
//  Chess-SwiftUI
//
//  Created by Mac on 30/05/2021.
//

import SwiftUI

struct Chessboard: View {
    var files = [0,1,2,3,4,5,6,7]
    var ranks = [0,1,2,3,4,5,6,7]
    
    var body: some View{
        VStack(alignment: .center, spacing: 0){
            ForEach(ranks.reversed(), id: \.self) { file in
                HStack(alignment: .center, spacing: 0){
                    ForEach(files, id: \.self) { rank in
                        Square(coords: (rank,file))
                    }
                }
            }
        }
        .border(Color.black, width: 1)
    }
}

struct Square: View {
    var coords: (Int, Int)
    
    func getColor() -> Color {
        if(coords.0 % 2 == 0) {
            if(coords.1 % 2 == 0){
                return Color(.black)
            } else {
                return Color(.white)
            }
        } else {
            if(coords.1 % 2 == 0){
                return Color(.white)
            } else {
                return Color(.black)
            }
        }
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(getColor())
            .frame(width: 46, height: 46)
    }
}

struct HolderView: View, Hashable {
    @EnvironmentObject var Game: Game
    var id: Int
    var piece_ID: Int = 0
    
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(id);
        hasher.combine(piece_ID);
    }

    static func == (lhs: HolderView, rhs: HolderView) -> Bool {
        return lhs.id == rhs.id && lhs.piece_ID == rhs.piece_ID
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color.white.opacity(0.01))
                .frame(width: 46, height: 46)
                .background(Color.white.opacity(0))
            if(piece_ID > 0 ){
                PieceView(piece_ID: piece_ID)
            } else if (piece_ID == -1) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 11, height: 11)
            }
        }
        .onTapGesture {
            Game.ChosenHolder = id
            if(Game.isPicked){
                Game.put()
            }
        }
    }
}

struct PieceView: View {
    @EnvironmentObject var Game: Game
    @State var isTapped = false
    var piece_ID: Int
    var body: some View {
        ZStack{
            Circle().frame(width: isTapped ? 42:36 , height: isTapped ? 42:36, alignment: .center)
                .foregroundColor(Game.Pieces[piece_ID-1].color == 0 ? .green : .blue)
                .onTapGesture {
                    //if there is no piece picked yet then pick this one
                    if(!Game.isPicked){
                        isTapped.toggle()
                        Game.ChosenPieceID = piece_ID
                        Game.isPicked = true
                        Game.showPossibleMoves()
                    //if this piece is pickedshowPossibleMoves
                    } else if (Game.isPicked && Game.ChosenPieceID == self.piece_ID) {
                        isTapped = false
                        Game.isPicked = false
                        Game.hidePossibileMoves()
                    } else if (Game.isPicked && Game.ChosenPieceID != self.piece_ID) {
                        Game.checkAttack(piece_ID)
                    }
                }
            Text(piece_ID.description)
                .foregroundColor(.white)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        .frame(width: 46, height: 46)
    }
}

struct MovingView: View {
    @EnvironmentObject var Game: Game

    var body: some View {
        VStack{
            Button(action: { Game.set() }, label: {
                Text("Set")
            })
            ZStack{
                Chessboard()
                VStack(alignment: .center, spacing: 0){
                    HStack(alignment: .center, spacing: 0){
                        ForEach(Game.Holders, id: \.self) { Holder in
                            if(Holder.id > 55 && Holder.id < 64){
                            Holder
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 0){
                        ForEach(Game.Holders, id: \.self) { Holder in
                            if(Holder.id > 47 && Holder.id < 56){
                            Holder
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 0){
                        ForEach(Game.Holders, id: \.self) { Holder in
                            if(Holder.id > 39 && Holder.id < 48){
                            Holder
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 0){
                        ForEach(Game.Holders, id: \.self) { Holder in
                            if(Holder.id > 31 && Holder.id < 40){
                            Holder
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 0){
                        ForEach(Game.Holders, id: \.self) { Holder in
                            if(Holder.id > 23 && Holder.id < 32){
                            Holder
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 0){
                        ForEach(Game.Holders, id: \.self) { Holder in
                            if(Holder.id > 15 && Holder.id < 24){
                            Holder
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 0){
                        ForEach(Game.Holders, id: \.self) { Holder in
                            if(Holder.id > 7 && Holder.id < 16){
                            Holder
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 0){
                        ForEach(Game.Holders, id: \.self) { Holder in
                            if(Holder.id < 8){
                            Holder
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @StateObject var GameStatus = Game()
    var body: some View {
        MovingView()
            .environmentObject(GameStatus)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
