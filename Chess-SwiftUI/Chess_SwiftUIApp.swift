//
//  Chess_SwiftUIApp.swift
//  Chess-SwiftUI
//
//  Created by Mac on 30/05/2021.
//

import SwiftUI

class Game: ObservableObject {
    @Published var fields: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,999]
    
    //Variable holding all of the holders for PieceViews
    @Published var Holders: [HolderView] = [
        HolderView(id: 0),HolderView(id: 1),HolderView(id: 2),HolderView(id: 3),HolderView(id: 4),HolderView(id: 5),HolderView(id: 6),HolderView(id: 7),
        HolderView(id: 8),HolderView(id: 9),HolderView(id: 10),HolderView(id: 11),HolderView(id: 12),HolderView(id: 13),HolderView(id: 14),HolderView(id: 15),
        HolderView(id: 16),HolderView(id: 17),HolderView(id: 18),HolderView(id: 19),HolderView(id: 20),HolderView(id: 21),HolderView(id: 22),HolderView(id: 23),
        HolderView(id: 24),HolderView(id: 25),HolderView(id: 26),HolderView(id: 27),HolderView(id: 28),HolderView(id: 29),HolderView(id: 30),HolderView(id: 31),
        HolderView(id: 32),HolderView(id: 33),HolderView(id: 34),HolderView(id: 35),HolderView(id: 36),HolderView(id: 37),HolderView(id: 38),HolderView(id: 39),
        HolderView(id: 40),HolderView(id: 41),HolderView(id: 42),HolderView(id: 43),HolderView(id: 44),HolderView(id: 45),HolderView(id: 46),HolderView(id: 47),
        HolderView(id: 48),HolderView(id: 49),HolderView(id: 50),HolderView(id: 51),HolderView(id: 52),HolderView(id: 53),HolderView(id: 54),HolderView(id: 55),
        HolderView(id: 56),HolderView(id: 57),HolderView(id: 58),HolderView(id: 59),HolderView(id: 60),HolderView(id: 61),HolderView(id: 62),HolderView(id: 63),
        HolderView(id: 999),
    ]
    
    //Coords indexes in array are corresponding to Holders indexes in array
    var Coordinates: [Coord] = [
        Coord(0, 0),Coord(0, 1),Coord(0, 2),Coord(0, 3),Coord(0, 4),Coord(0, 5),Coord(0, 6),Coord(0, 7),
        Coord(1, 0),Coord(1, 1),Coord(1, 2),Coord(1, 3),Coord(1, 4),Coord(1, 5),Coord(1, 6),Coord(1, 7),
        Coord(2, 0),Coord(2, 1),Coord(2, 2),Coord(2, 3),Coord(2, 4),Coord(2, 5),Coord(2, 6),Coord(2, 7),
        Coord(3, 0),Coord(3, 1),Coord(3, 2),Coord(3, 3),Coord(3, 4),Coord(3, 5),Coord(3, 6),Coord(3, 7),
        Coord(4, 0),Coord(4, 1),Coord(4, 2),Coord(4, 3),Coord(4, 4),Coord(4, 5),Coord(4, 6),Coord(4, 7),
        Coord(5, 0),Coord(5, 1),Coord(5, 2),Coord(5, 3),Coord(5, 4),Coord(5, 5),Coord(5, 6),Coord(5, 7),
        Coord(6, 0),Coord(6, 1),Coord(6, 2),Coord(6, 3),Coord(6, 4),Coord(6, 5),Coord(6, 6),Coord(6, 7),
        Coord(7, 0),Coord(7, 1),Coord(7, 2),Coord(7, 3),Coord(7, 4),Coord(7, 5),Coord(7, 6),Coord(7, 7),
        Coord(999, 999),
    ]
    
    //Variable holding all the pieces with their ID, Type, Color, PieceType
    //Piece ID - 1 = key
    @Published var Pieces: [Piece] = [Piece(1,1,.Rook),Piece(2,2,.Knight),Piece(3,3,.Bishop),Piece(4,4,.Queen),Piece(5,1,.King),Piece(6,1,.Bishop),Piece(7,1,.Knight),Piece(8,1,.Rook),Piece(9,1,.wPawn),Piece(10,1,.wPawn),Piece(11,1,.wPawn),Piece(12,1,.wPawn),Piece(13,1,.wPawn),Piece(14,1,.wPawn),Piece(15,1,.wPawn),Piece(16,1,.wPawn),Piece(17,0,.bPawn),Piece(18,0,.Rook),Piece(19,0,.Knight)]
    
    //Variable holding Pieces location
    //Piece ID - 1 == Key
    //Holder ID AND COORDS == Value
    @Published var GameState: [Int] =
        [0,1,2,3,4,5,6,7,
         8,9,10,11,12,13,14,15,
         55,56,57]
    
    //Chosen piece ID
    @Published var ChosenPieceID: Int = 0
    @Published var isPicked = false
    @Published var ChosenHolder = 0
    @Published var PossibleMoves = [Int]()
    @Published var Threats = [Int]()
    
    func set() -> Void {
        for index in 0..<GameState.count {
            //Piece ID = array index +1
            Holders[GameState[index]].piece_ID = index+1
        }
    }
    
    func pick() -> Void {
        //pick the Piece
        isPicked = true
    }
    
    func put() -> Void {
        //check if holdes is on list of possible moves of a Piece or is on list of threats
        if(Holders[ChosenHolder].piece_ID == -1){
        hidePossibileMoves()
        //Remove piece from it's initial holer
        Holders[GameState[ChosenPieceID-1]].piece_ID = 0
        //update Piece holder's ID in GameState2
        GameState[ChosenPieceID-1] = ChosenHolder
        //put Piece on new Holder
        Holders[ChosenHolder].piece_ID = ChosenPieceID
        //reset chosen Piece and holder
        ChosenPieceID = 0
        ChosenHolder = 0
        isPicked = false
        }
    }
    
    func getPieceIDByLocation(locId: Int) -> Int {
        for p_ID in 0..<GameState.count {
            if GameState[p_ID] == locId{
                //Piece ID = array index + 1
                return p_ID+1
            }
        }
        return 0
    }
    
    //GAME LOGIC
    
    func addToCoord(_ piece_cord: (Int, Int),_ move: (Int, Int),_ mltp: Int = 1) -> Coord {
        return Coord(piece_cord.0+(move.0*mltp), piece_cord.1+(move.1*mltp))
    }
    
    func combineCoords(_ a: Coord,_ b: Coord) -> Coord {
        return Coord(a.file+b.file, a.rank+b.rank)
    }
    
    func isPossibleMove(_ piece_cord: (Int, Int),_ move: (Int, Int),_ mltp: Int = 1) -> Bool {
        return checkDestinationCord(Coord(move.0*mltp, move.1*mltp)) == 0
    }
    
    func getHolderIDFromCoord(_ c: Coord) -> Int {
        for h_ID in 0..<Coordinates.count {
            if Coordinates[h_ID] == c {
                //Piece ID = array index + 1
                return h_ID
            }
        }
        return 64
    }
    
    func HolderExist(_ h_ID: Int) -> Bool {
        return Holders.contains(where: {$0.id == h_ID})
    }
    
    func getHolderCoordsByPiece(_ p_ID: Int) -> Coord {
        return Coordinates[GameState[p_ID-1]]
    }
    
    func getHolderCoordsByID(_ h_ID: Int) -> Coord {
        return Coordinates[h_ID]
    }
    
    func isColiding(_ cord_ID: Int) -> Bool {
        return Holders[cord_ID].piece_ID > 0
    }
    
    func checkDestinationCord(_ destination: Coord) -> Int {
        return Holders[getHolderIDFromCoord(destination)].piece_ID
    }
    
    //returns piece_ID of Holder
    func checkDestination(_ c_ID: Int) -> Int {
        return Holders[c_ID].piece_ID
    }
    
    func getLocationByPieceID(_ p_ID: Int) -> Int {
        return GameState[p_ID-1]
    }
    
    func isEnemyPiece(_ h_ID: Int) -> Bool {
        let pl_color = Pieces[ChosenPieceID-1].color
        return Pieces[getPieceIDByLocation(locId: h_ID)-1].color != pl_color
    }
    
    func isThreatened(_ p_ID: Int) -> Bool {
        return Pieces[p_ID-1].Piece_state == .threatened
    }
    
    func finalCheck() -> Void {
        var loc = getLocationByPieceID(ChosenPieceID)
        
        if Pieces[ChosenPieceID-1].piece_type == .bPawn && Coordinates[getLocationByPieceID(ChosenPieceID)].rank ==  0 {
            Pieces[ChosenPieceID-1].Piece_state = .promotion
            Pieces[ChosenPieceID-1].promoteTo_dev()
            Pieces[ChosenPieceID-1].Piece_state = .free
            let moves = Pieces[ChosenPieceID-1].moves
            let type = Pieces[ChosenPieceID-1].piece_type
            
        } else if Pieces[ChosenPieceID-1].piece_type == .wPawn && Coordinates[getLocationByPieceID(ChosenPieceID)].rank ==  7 {
            Pieces[ChosenPieceID-1].Piece_state = .promotion
            Pieces[ChosenPieceID-1].promoteTo_dev()
            Pieces[ChosenPieceID-1].Piece_state = .free
            let moves = Pieces[ChosenPieceID-1].moves
            let type = Pieces[ChosenPieceID-1].piece_type

        }
        ChosenPieceID = 0
    }

    
    func checkAttack(_ p_ID: Int) -> Void {
        if(isThreatened(p_ID)){
            //remove piece from its initial holder
            var a = Holders[getLocationByPieceID(ChosenPieceID)].piece_ID
            Holders[getLocationByPieceID(ChosenPieceID)].piece_ID = 0
            //update piece location in gamestate
            GameState[ChosenPieceID-1] = getLocationByPieceID(p_ID)
            //put piece on final holder
            Holders[getLocationByPieceID(p_ID)].piece_ID = ChosenPieceID
            //place the attacked piece on invisible holder
            GameState[p_ID-1] = 999
            finalCheck()
            hidePossibileMoves()
            isPicked = false
        }
    }
    
    //get Moves of chosen piece
    //filter moves of Pawn after first push
    func getPieceMoves() -> [(Int,Int)] {
        switch Pieces[ChosenPieceID-1].piece_type {
        case .wPawn:
            if getHolderCoordsByPiece(ChosenPieceID).rank < 2 {
                return Pieces[ChosenPieceID-1].moves+[(2,0)]
            } else {
                return Pieces[ChosenPieceID-1].moves
            }
        case .bPawn:
            if getHolderCoordsByPiece(ChosenPieceID).rank > 5 {
                return Pieces[ChosenPieceID-1].moves+[(-2,0)]
            } else {
                return Pieces[ChosenPieceID-1].moves
            }
        default:
            //return any other piece moveset
            return Pieces[ChosenPieceID-1].moves
        }
    }
    
    func showPossibleMoves() -> Void {
        let moves = getPieceMoves()
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        var possibleHoldersIDs: [Int] = []
        //var threatenedPieces: [Int] = []
        for move in moves {
            if(moveMultiplier()){
                for x in 1...8 {
                    //collision Check
                    if(Holders[getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x)))].piece_ID > 0){
                        break
                    } else {
                        possibleHoldersIDs.append(getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x))))
                    }
                }
            } else {
                //check if Pawn is using attack move
                if ((Pieces[ChosenPieceID-1].piece_type == .bPawn || Pieces[ChosenPieceID-1].piece_type == .wPawn) && move.1 != 0){
                    // check if attacked holder holds a piece
                    if Holders[getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))].piece_ID != 0 {
                        //check if it is an enemy's piece
                        if isEnemyPiece(getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))) {
                            Pieces[checkDestination(getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))) - 1].Piece_state = .threatened
                            //threatenedPieces.append(Holders[getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))].piece_ID)
                        }
                    }
                } else {
                possibleHoldersIDs.append(getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)))
                }
            }
        }
        var verifiedHoldersIDs: [Int] = []
        for ID in possibleHoldersIDs {
            if(ID != 999 && Holders[ID].piece_ID == 0){
                verifiedHoldersIDs.append(ID)
                Holders[ID].piece_ID = -1
            }
        }
        //Threats = threatenedPieces
        PossibleMoves = verifiedHoldersIDs
    }
    
    func hidePossibileMoves() -> Void {
        for id in PossibleMoves {
            Holders[id].piece_ID = 0
        }
        PossibleMoves.removeAll()
    }
    
    //function to multiply vectors of moves for Bishop, Rook and Queen
    func moveMultiplier() -> Bool {
        if (Pieces[ChosenPieceID-1].piece_type == .Bishop || Pieces[ChosenPieceID-1].piece_type == .Rook || Pieces[ChosenPieceID-1].piece_type == .Queen) {
            return true
        } else {
            return false
        }
    }
}

class Coord: Hashable {
    static func == (lhs: Coord, rhs: Coord) -> Bool {
        return lhs.file == rhs.file && lhs.rank == rhs.rank
    }
    
    var file: Int
    var rank: Int
    
    func getCoords() -> (Int, Int){
        return (rank, file)
    }
    
    init(_ r: Int,_ f: Int){
        file = f
        rank = r
    }
    
    func hash(into hasher: inout Hasher)
    {
            hasher.combine(file);
            hasher.combine(rank);
    }
}



class Piece: ObservableObject {

    //Piece will only provide it's ID to other Views
    //Piece type will be accesible only through Game.Pieces[ID]
    
    //Piece ID != 0 as 0 is reserved for free space on holders
    private var ID: Int
    private var COLOR: Int
    public var piece_type: PieceTypes
    
    public var moves: [(Int, Int)]
    private var piece_state: PlayState = .free
    
    public var Piece_state: PlayState { get { return piece_state} set { piece_state = newValue } }
    public var id: Int { get { return ID } }
    public var color: Int { get { return COLOR } }

    func promoteTo(_ p_T: PieceTypes) {
        piece_type = p_T
    }
    
    func promoteTo_dev() {
        self.piece_type = .Queen
        self.moves = Moves.queen
    }
    
    init(_ i: Int,_ c: Int, _ p_t: PieceTypes){
        ID = i
        COLOR = c
        self.piece_type = p_t
        switch p_t {
        case .wPawn:
            moves = Moves.wpawn;
        case .bPawn:
            moves = Moves.bpawn;
        case .Knight:
            moves = Moves.knight;
        case .Bishop:
            moves = Moves.bishop;
        case .Rook:
            moves = Moves.rook;
        case .Queen:
            moves = Moves.queen;
        case .King:
            moves = Moves.king;
        }
    }
    
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(id);
        hasher.combine(color);
        hasher.combine(piece_type);
    }
}

class Player: ObservableObject {
    @Published var Pieces: [Piece] = []
    var color: Color
    init(_ s: Int){
        if s == 0{
            color = .white
        }
        else {
            color = .black
        }
    }
}
 
enum PieceTypes {
    case wPawn
    case bPawn
    case Knight
    case Bishop
    case Rook
    case Queen
    case King
}

enum PlayState {
    case free
    case threatened
    case pinned
    case double_push
    case en_passantable
    case promotion
    case in_check
    case double_check
    case checkmate
}

class Moves {
    static var wpawn: [(Int, Int)] = [(1,0),(1,1),(1,-1)]
    static var bpawn: [(Int, Int)] = [(-1,0),(-1,-1),(-1,1)]
    static var knight: [(Int, Int)] = [(2,1), (2,-1), (-2,1), (-2,-1), (1,2), (1,-2), (-1,2), (-1,-2)]
    static var bishop: [(Int, Int)] = [(1,1), (1,-1), (-1,1), (-1,-1)]
    static var rook: [(Int, Int)] = [(0,1), (0,-1), (1,0), (-1,0)]
    static var queen: [(Int, Int)] = [(0,1), (0,-1), (1,0), (-1,0), (1,1), (1,-1), (-1,1), (-1,-1)]
    static var king: [(Int, Int)] = [(0,1), (0,-1), (1,0), (-1,0), (1,1), (1,-1), (-1,1), (-1,-1)]
}

@main
struct Chess_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
