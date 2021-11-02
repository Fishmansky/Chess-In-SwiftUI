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
            PlayerCounter(color: 0)
            ForEach(ranks.reversed(), id: \.self) { file in
                HStack(alignment: .center, spacing: 0){
                    ForEach(files, id: \.self) { rank in
                        Square(coords: (rank,file))
                    }
                }
            }
            PlayerCounter(color: 1)
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
    var highlight: Bool { Game.PossibleMoves.contains(id) ? true : false }
    
    
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
                .background(highlight ? Color.red.opacity(0.5) : Color.white.opacity(0))
            Text(id.description)
                .foregroundColor(.red).opacity(0.7)
            if(piece_ID > 0 ){
                PieceView(piece_ID: piece_ID)
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

struct PromotionView: View {
    @EnvironmentObject var Game: Game
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
                //.ignoresSafeArea()
            VStack(alignment: .center, spacing: 5) {
                Text("Promote to:")
                Button(action: {
                    Game.promoteTo(.Queen)
                    Game.showPromotion.toggle()
                }, label: {
                    Text("Queen")
                })
                Button(action: {
                    Game.promoteTo(.Rook)
                    Game.showPromotion.toggle()
                }, label: {
                    Text("Rook")
                })
                Button(action: {
                    Game.promoteTo(.Bishop)
                    Game.showPromotion.toggle()
                }, label: {
                    Text("Bishop")
                })
                Button(action: {
                    Game.promoteTo(.Knight)
                    Game.showPromotion.toggle()
                }, label: {
                    Text("Knight")
                })
            }.frame(width: 140, height: 140, alignment: .center)
            .background(Color.white)
            .cornerRadius(5)
        }
        .frame(width: 500, height: 420, alignment: .center)
    }
}

struct PlayerCounter: View {
    @EnvironmentObject var Game: Game
    var color: Int
    var body: some View {
        ZStack{
            Capsule().foregroundColor(.white).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            HStack{
                Text("PlayerName")
                Text("Points: \( color == 1 ? Game.WPCounter : Game.BPCounter )")
                
            }
        }.frame(width: 368, height: 60, alignment: .center)

    }
}

struct PieceView: View {
    @EnvironmentObject var Game: Game
    @State var isTapped = false
    var piece_ID: Int
    var imgName: String {
        switch Game.Pieces[piece_ID-1].piece_type {
        case .wPawn:
            return "wp"
        case .bPawn:
            return "bp"
        case .Bishop:
            return Game.Pieces[piece_ID-1].color == 1 ? "wb" : "bb"
        case .Knight:
            return Game.Pieces[piece_ID-1].color == 1 ? "wkn" : "bkn"
        case .Rook:
            return Game.Pieces[piece_ID-1].color == 1 ? "wr" : "br"
        case .Queen:
            return  Game.Pieces[piece_ID-1].color == 1 ? "wq" : "bq"
        case .King:
            return Game.Pieces[piece_ID-1].color == 1 ? "wk" : "bk"
        }
    }
    var body: some View {
        ZStack{
//            Circle().frame(width: isTapped ? 42:36 , height: isTapped ? 42:36, alignment: .center)
//                .foregroundColor(Game.Pieces[piece_ID-1].color == 0 ? .green : .blue)
                Image(imgName).resizable()
                    .scaledToFit().frame(width: isTapped ? 48:42 , height: isTapped ? 48:42, alignment: .center)
                .onTapGesture {
                    //if there is no piece picked yet then pick this one
                    if(!Game.isPicked){
                        isTapped.toggle()
                        Game.ChosenPieceID = piece_ID
                        Game.isPicked = true
                        Game.showPossibleMoves()
                    //if this piece is picked showPossibleMoves
                    } else if (Game.isPicked && Game.ChosenPieceID == self.piece_ID) {
                        isTapped = false
                        Game.isPicked = false
                        Game.hidePossibileMoves()
                    } else if (Game.isPicked && Game.ChosenPieceID != self.piece_ID) {
                        Game.Attack(piece_ID)
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
    @State var showPromotion = false
    @State var promo_piece = 0
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
                if(Game.showPromotion){
                    PromotionView()
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
