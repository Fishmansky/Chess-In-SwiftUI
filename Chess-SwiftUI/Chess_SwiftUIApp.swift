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
    //White King = 5
    //Black King = 29
    @Published var Pieces: [Piece] = [Piece(1,1,.Rook),Piece(2,1,.Knight),Piece(3,1,.Bishop),Piece(4,1,.Queen),Piece(5,1,.King),Piece(6,1,.Bishop),Piece(7,1,.Knight),Piece(8,1,.Rook),Piece(9,1,.wPawn),Piece(10,1,.wPawn),Piece(11,1,.wPawn),Piece(12,1,.wPawn),Piece(13,1,.wPawn),Piece(14,1,.wPawn),Piece(15,1,.wPawn),Piece(16,1,.wPawn),Piece(17,0,.bPawn),Piece(18,0,.bPawn),Piece(19,0,.bPawn),Piece(20,0,.bPawn),Piece(21,0,.bPawn),Piece(22,0,.bPawn),Piece(23,0,.bPawn),Piece(24,0,.bPawn),Piece(25,0,.Rook),Piece(26,0,.Knight),Piece(27,0,.Bishop),Piece(28,0,.Queen),Piece(29,0,.King),Piece(30,0,.Bishop),Piece(31,0,.Knight),Piece(32,0,.Rook)]
    
    //Variable holding Pieces location
    //Piece ID - 1 == Key
    //Holder ID AND COORDS == Value
    @Published var GameState: [Int] =
        [0,1,2,3,4,5,6,7,
         8,9,10,11,12,13,14,15,
         48,49,50,51,52,53,54,55,
         56,57,58,59,60,61,62,63]
    
    //Chosen piece ID
    @Published var ChosenPieceID: Int = 0
    @Published var isPicked = false
    @Published var ChosenHolder = 0
    @Published var PossibleMoves = [Int]()
    @Published var showPromotion = false
    @Published var ThreatsState: [(Int, Int)] = []
    
    //GAME LOGIC
    
    func set() -> Void {
        for index in 0..<GameState.count {
            //Piece ID = array index +1
            Holders[GameState[index]].piece_ID = index+1
        }
    }
    
    func put() -> Void {
        //check if holdes is on list of possible moves of a Piece or is on list of threats
        if(Holders[ChosenHolder].piece_ID == -1){
            //check for enpassant pawn state or attack
            enPassantCheck()
            //remove pointers from holders
            hidePossibileMoves()
            //Remove piece from it's initial holer
            Holders[GameState[ChosenPieceID-1]].piece_ID = 0
            //update Piece holder's ID in GameState2
            GameState[ChosenPieceID-1] = ChosenHolder
            //put Piece on new Holder
            Holders[ChosenHolder].piece_ID = ChosenPieceID
            //pawn promotion check
            promotionCheck()
            //create function to remove state from previously threatened pieces
            resetRelations()
            //check the position
            if Pieces[ChosenPieceID-1].piece_type == .Rook || Pieces[ChosenPieceID-1].piece_type == .Bishop || Pieces[ChosenPieceID-1].piece_type == .Queen {
                PositionCheck()
            }
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
    
    func addToCoord(_ piece_cord: (Int, Int),_ move: (Int, Int),_ mltp: Int = 1) -> Coord {
        return Coord(piece_cord.0+(move.0*mltp), piece_cord.1+(move.1*mltp))
    }
    
    func combineCoords(_ a: Coord,_ b: Coord) -> Coord {
        return Coord(a.file+b.file, a.rank+b.rank)
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
    
    func getHolderCoordsByPiece(_ p_ID: Int) -> Coord {
        return Coordinates[GameState[p_ID-1]]
    }
    
    func getLocationByPieceID(_ p_ID: Int) -> Int {
        return GameState[p_ID-1]
    }
    
    func isEnemyPiece(_ p_ID: Int) -> Bool {
        return Pieces[p_ID-1].color != Pieces[ChosenPieceID-1].color
    }
    
    func isEnemyPieceOnHolder(_ h_ID: Int) -> Bool {
        if Holders[h_ID].piece_ID > 0 {
        return Pieces[Holders[h_ID].piece_ID-1].color != Pieces[ChosenPieceID-1].color
        } else {
            return false
        }
    }
    
    func isThreatened(_ p_ID: Int) -> Bool {
        return Pieces[p_ID-1].isThreatened()
    }
    
    func isPinned(_ p_ID: Int) -> Bool {
        return Pieces[p_ID-1].isPinned()
    }
    
    func isProtecting(_ p_ID: Int) -> Bool {
        return Pieces[p_ID-1].isProtecting()
    }
    
    func resetRelations() -> Void {
        for r in Pieces[ChosenPieceID-1].relations {
            Pieces[r.0 - 1].removeRelation(ChosenPieceID)
        }
        Pieces[ChosenPieceID-1].clearRelations()
    }
    
    func isEnemyPawnPushMove(_ move: (Int, Int)) -> Bool {
        let enemyColor = Pieces[ChosenPieceID-1].color == 1 ? 0 : 1
        if enemyColor == 0 {
            return Moves.bpawn.first! == move
        } else {
            return Moves.wpawn.first! == move
        }
    }
    
    func inv_dir(_ dir: (Int, Int)) -> (Int, Int){
        return (dir.0 * -1,dir.1 * -1)
    }
    
    func PositionCheck() -> Void {
        //chec if there is a piece and king on line of the attack of current piece
        //if there only a king then it's check
        //if there a piece protecting its king then assess it's state
        //if piece can capture your attacking piece the it's .protecting
        //if piece cannot capture your attacking piece the it's .pinned
        
        let thisPieceCoords = getHolderCoordsByPiece(ChosenPieceID)
        let thisPieceMoves = getSpecificPieceMoves(ChosenPieceID)
        let thisPieceHolder = getLocationByPieceID(ChosenPieceID)
        
        var enemyKingOnLine = false
        var enemyKingDistance = 0
        var enemyKingHolderID = 64
        
        var enemyPieceOnLine = false
        var enemyPieceDistance = 0
        var enemyPieceHolderID = 64

        
        var direction: (Int, Int) = (0,0)
        
        //check if piece is pointing in any way at enemys king
        for move in thisPieceMoves {
            for x in 1...8 {
                let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x)))
                // check if attacked holder holds an enemys king
                if isEnemyKingOnHolder(hol_ID) {
                    enemyKingDistance = x
                    enemyKingOnLine = true
                    enemyKingHolderID = hol_ID
                    direction = move
                    break
                }
            }
        }
        
        //if there is no king on the line assess the position
        if !enemyKingOnLine {
            for move in thisPieceMoves {
                if moveMultiplier() {
                    for x in 1...8 {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x)))
                        // check if attacked holder holds an enemys king
                        if isEnemyPieceOnHolder(hol_ID) && !isEnemyKingOnHolder(hol_ID) {
                            //look for pieces that can attack your piece and set its state
                            if getAttackedHoldersOfPiece(Holders[hol_ID].piece_ID).contains(where: {$0 == thisPieceHolder}) {
                                Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .is_threatening)
                                Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .threatened)
                                Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .is_threatening)
                                Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .threatened)
                            } else {
                                Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .is_threatening)
                                Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .threatened)
                            }
                        }
                    }
                } else {
                    let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0), thisPieceCoords.file+(move.1)))
                    // check if attacked holder holds an enemys king
                    if isEnemyPieceOnHolder(hol_ID) && !isEnemyKingOnHolder(hol_ID) {
                        //look for pieces that can attack your piece and set its state
                        if getAttackedHoldersOfPiece(Holders[hol_ID].piece_ID).contains(where: {$0 == thisPieceHolder}) {
                            Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .is_threatening)
                            Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .threatened)
                            Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .is_threatening)
                            Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .threatened)
                        } else {
                            Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .is_threatening)
                            Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .threatened)
                        }
                    }
                }
            }
        } else if enemyKingOnLine {
            //if there is a king on line of attack check for pieces protecting the king
            for move in thisPieceMoves {
                if move == direction  {
                    for x in 1...enemyKingDistance {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(direction.0*x), thisPieceCoords.file+(direction.1*x)))
                        // check if attacked holder holds enemy piece
                        if hol_ID != 64 && enemyPieceDistance < enemyKingDistance {
                            if isEnemyPieceOnHolder(hol_ID) && !isEnemyKingOnHolder(hol_ID) {
                                enemyPieceDistance = x
                                enemyPieceOnLine = true
                                enemyPieceHolderID = hol_ID
                                break
                            }
                        }
                    }
                    //check for pieces on other lines of attack and set their relations
                } else {
                    for x in 1...8 {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x)))
                        // check if attacked holder holds an enemys king
                        if isEnemyPieceOnHolder(hol_ID) && !isEnemyKingOnHolder(hol_ID) {
                            //look for pieces that can attack your piece and set its state
                            if getAttackedHoldersOfPiece(Holders[hol_ID].piece_ID).contains(where: {$0 == thisPieceHolder}) {
                                Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .is_threatening)
                                Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .threatened)
                                Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .is_threatening)
                                Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .threatened)
                                break
                            } else {
                                Pieces[getPieceIDByLocation(locId: hol_ID)-1].addRelation(ChosenPieceID, .is_threatening)
                                Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: hol_ID), .threatened)
                                break
                            }
                        }
                    }
                }
            }
            //if there is no piece protecting the king then our piece is checking the king
            if !enemyPieceOnLine{
                Pieces[getPieceIDByLocation(locId: enemyKingHolderID)-1].addRelation(ChosenPieceID, .gives_check)
                Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: enemyKingHolderID), .in_check)
            } else {
                let enemyCanAttack = getAttackedHoldersOfPiece(getPieceIDByLocation(locId: enemyPieceHolderID)).contains(where: {$0 == thisPieceHolder})
                let enemyCanMove = getSpecificPieceMoves(getPieceIDByLocation(locId: enemyPieceHolderID)).contains(where: {$0.self == direction || $0.self == inv_dir(direction)})
                if enemyKingDistance > enemyPieceDistance {
                    //if there is a piece protecting the king check if it can move on the line of attack
                    if enemyCanMove && !enemyCanAttack {
                        Pieces[getPieceIDByLocation(locId: enemyPieceHolderID)-1].addRelation(Holders[enemyKingHolderID].piece_ID, .protects)
                        Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: enemyPieceHolderID), .threatened)
                    } else if enemyCanAttack {
                        //check if enemy can attack our piece
                        Pieces[getPieceIDByLocation(locId: enemyPieceHolderID)-1].addRelation(ChosenPieceID, .is_threatening)
                        Pieces[getPieceIDByLocation(locId: enemyPieceHolderID)-1].addRelation(ChosenPieceID, .threatened)
                        Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: enemyPieceHolderID), .is_threatening)
                        Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: enemyPieceHolderID), .threatened)
                    } else {
                        //if if cannot move nor attack our piece then its pinned
                        Pieces[getPieceIDByLocation(locId: enemyPieceHolderID)-1].addRelation(ChosenPieceID, .is_pinning)
                        Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: enemyPieceHolderID), .pinned)
                    }
                } else {
                    Pieces[getPieceIDByLocation(locId: enemyKingHolderID)-1].addRelation(ChosenPieceID, .gives_check)
                    Pieces[ChosenPieceID-1].addRelation(getPieceIDByLocation(locId: enemyKingHolderID), .in_check)
                }
            }
        }
    }
    
    func getAttackedHoldersOfPiece(_ p_ID: Int) -> [Int] {
        if Pieces[p_ID-1].piece_type == .bPawn || Pieces[p_ID-1].piece_type == .wPawn {
            return getPossiblePawnMoves(p_ID)
        } else {
            return getPossiblePiecesMoves(p_ID)
        }
    }
    
    func enPassantCheck() -> Void {
        //check if pawn is chosen
        if Pieces[ChosenPieceID-1].piece_type == .wPawn || Pieces[ChosenPieceID-1].piece_type == .bPawn {
            //check if pawn is pushed two squares forward to set is state as en_passantable
            if (getHolderCoordsByPiece(ChosenPieceID).rank == 1 && Pieces[ChosenPieceID-1].piece_type == .wPawn) || ( getHolderCoordsByPiece(ChosenPieceID).rank == 6 && Pieces[ChosenPieceID-1].piece_type == .bPawn) {
                if PossibleMoves.first != ChosenHolder {
                    Pieces[ChosenPieceID-1].addRelation(ChosenPieceID, .en_passantable)
                }
                //check if en passant move is being played
            } else if (Coordinates[Holders[ChosenHolder].id].file != Coordinates[GameState[ChosenPieceID-1]].file){
                let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                let hol_ID2 = getHolderIDFromCoord(Coord(Coordinates[Holders[ChosenHolder].id].rank+mod,Coordinates[Holders[ChosenHolder].id].file))
                let p_ID = Holders[hol_ID2].piece_ID
                if Holders[hol_ID2].piece_ID != 0 && Holders[hol_ID2].piece_ID != 999 {
                    if Pieces[p_ID-1].isEnpassantable() && isEnemyPieceOnHolder(hol_ID2){
                        //remove pawn attacked by en passant
                        Holders[hol_ID2].piece_ID = 0
                        //update the attacked piece position in GameState, put it on invisible holder
                        GameState[p_ID-1] = 999
                    }
                }
            }
        }
    }
    
    func getPromotedPawn()-> Int {
        for p_ID in 0..<Pieces.count {
            if Pieces[p_ID].STATE() == .promotion{
                //Piece ID = array index + 1
                return p_ID + 1
            }
        }
        return 999
    }
    
    func promoteTo(_ p_T: PieceTypes) -> Void {
        if getPromotedPawn() != 999 {
            Pieces[getPromotedPawn()-1].piece_type = p_T
            //check position
            PositionCheck()
        }
    }
    
    func promotionCheck() -> Void {
        if Pieces[ChosenPieceID-1].piece_type == .bPawn && Coordinates[getLocationByPieceID(ChosenPieceID)].rank ==  0 {
            Pieces[ChosenPieceID-1].addRelation(ChosenPieceID, .promotion)
            showPromotion = true
        } else if Pieces[ChosenPieceID-1].piece_type == .wPawn && Coordinates[getLocationByPieceID(ChosenPieceID)].rank ==  7 {
            Pieces[ChosenPieceID-1].addRelation(ChosenPieceID, .promotion)
            showPromotion = true
        }
    }
    
    func Attack(_ p_ID: Int) -> Void {
        if((isThreatened(p_ID) || isPinned(p_ID)) && isEnemyPiece(p_ID)){
            //remove piece from its initial holder
            Holders[getLocationByPieceID(ChosenPieceID)].piece_ID = 0
            //update piece location in gamestate
            GameState[ChosenPieceID-1] = getLocationByPieceID(p_ID)
            //put piece on final holder
            Holders[getLocationByPieceID(p_ID)].piece_ID = ChosenPieceID
            //place the attacked piece on invisible holder
            GameState[p_ID-1] = 999
            promotionCheck()
            resetRelations()
            PositionCheck()
            ChosenPieceID = 0
            ChosenHolder = 0
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
                return Moves.wpawn+[(2,0)]
            } else {
                return Moves.wpawn
            }
        case .bPawn:
            if getHolderCoordsByPiece(ChosenPieceID).rank > 5 {
                return Moves.bpawn+[(-2,0)]
            } else {
                return Moves.bpawn
            }
        case .Knight:
            return Moves.knight
        case .Bishop:
            return Moves.bishop
        case .Rook:
            return Moves.rook
        case .Queen:
            return Moves.queen
        case .King:
            return Moves.king
        }
    }
    
    func getSpecificPieceMoves(_ p_ID: Int) -> [(Int,Int)] {
        switch Pieces[p_ID-1].piece_type {
        case .wPawn:
            var moves: [(Int,Int)] = []
            moves.append(Moves.bpawn.first!)
            return moves
        case .bPawn:
            var moves: [(Int,Int)] = []
            moves.append(Moves.bpawn.first!)
            return moves
        case .Knight:
            return Moves.knight
        case .Bishop:
            return Moves.bishop
        case .Rook:
            return Moves.rook
        case .Queen:
            return Moves.queen
        case .King:
            return Moves.king
        }
    }
    
    func PinDirection() -> (Int, Int) {
        let KingID = Pieces[ChosenPieceID-1].color == 1 ? 5 : 29
        let KingH_ID = getLocationByPieceID(KingID)
        let PieceH_ID = getLocationByPieceID(ChosenPieceID)
        
        if Coordinates[KingH_ID].file == Coordinates[PieceH_ID].file {
            if Coordinates[KingH_ID].rank > Coordinates[PieceH_ID].rank {
                return (-1,0)
            } else {
                return (1,0)
            }
        } else if Coordinates[KingH_ID].rank == Coordinates[PieceH_ID].rank {
            if Coordinates[KingH_ID].file > Coordinates[PieceH_ID].file {
                return (0,-1)
            } else {
                return (0,1)
            }
        } else {
            let f_x = Coordinates[KingH_ID].file - Coordinates[PieceH_ID].file
            let r_x = Coordinates[KingH_ID].rank - Coordinates[PieceH_ID].rank
            
            return (r_x.signum(),f_x.signum())
            
        }
    }
    
    func isPawn() -> Bool {
        let pawnColor = Pieces[ChosenPieceID-1].color
        if pawnColor == 1 {
            if Pieces[ChosenPieceID-1].piece_type == .wPawn {
                return true
            }
        } else {
            if Pieces[ChosenPieceID-1].piece_type == .bPawn {
                return true
            }
        }
        return false
    }
    
    func isEnemyKing(_ p_ID: Int) -> Bool {
        if isEnemyPiece(ChosenPieceID){
            let enKingID = Pieces[ChosenPieceID-1].color == 1 ? 29 : 5
            if p_ID == enKingID {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func isEnemyKingOnHolder(_ h_ID: Int) -> Bool {
        let enKingID = Pieces[ChosenPieceID-1].color == 1 ? 29 : 5
        return Holders[h_ID].piece_ID == enKingID
    }
    
    func kingInCheck() -> Bool {
        let KingID = Pieces[ChosenPieceID-1].color == 1 ? 5 : 29
        return Pieces[KingID-1].piece_state == .in_check
    }
    
    func kingInDoubleCheck() -> Bool {
        let KingID = Pieces[ChosenPieceID-1].color == 1 ? 5 : 29
        return Pieces[KingID-1].piece_state == .double_check
    }
    
    func getCheckingPieces() -> [Int] {
        var ar: [Int] = []
        for p_ID in 0..<Pieces.count {
            if Pieces[p_ID].piece_state == .gives_check{
                //Piece ID = array index + 1
                ar.append(p_ID + 1)
            }
        }
        return ar
    }
    
    func canSaveKing() -> Void {
        //function should provide possible ways to get king out of check without moving it like:
        // - holders that ca be taken be pieces to stand on the line of check
        // - pieces that can capture the enemy piece that is checking the king
        //let direction = PinDirection()
        //let checkingPieces = getCheckingPieces()
        
    }
    
    
    func PossiblePawnStateMoves() -> Void {
        let p_s = Pieces[ChosenPieceID-1].STATE()
        switch p_s {
        case .free, .threatened, .protects:
            showPossiblePawnMoves()
            break
        case .is_threatening, .promotion, .gives_check, .en_passantable:
            showPossiblePawnMoves()
            break
        case .in_check:
            canSaveKing()
            break
        case .is_pinning, .pinned, .double_check, .checkmate:
            //no moves
            break;
        }
    }
    
    func PossiblePawnStateMoves2() -> Void {
        let p_s = Pieces[ChosenPieceID-1].STATE()
        switch p_s {
        case .free, .threatened, .is_threatening, .pinned, .en_passantable, .promotion:
            showPossiblePawnMoves()
            break
        case .protects:
            showPossiblePawnMoves()
            break
        case .in_check, .double_check, .gives_check:
            canSaveKing()
            break
        case .is_pinning, .checkmate:
            //no moves
            break;
        }
    }
    
    func getPossiblePawnMoves(_ p_ID: Int) -> [Int] {
        let moves = getSpecificPieceMoves(p_ID)
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        var possibleHoldersIDs: [Int] = []
        for move in moves {
            //check if Pawn is using attack move
            if (move.1 != 0){
                let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                // check if attacked holder holds a piece
                if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                    //check if it is an enemy's piece
                    if isEnemyPieceOnHolder(hol_ID) {
                        //add piece holderID to possible moves
                        possibleHoldersIDs.append(hol_ID)
                    }
                    //check for en_passantable pawns
                } else if Holders[hol_ID].piece_ID == 0 {
                    let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                    let hol_ID2 = getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1))
                    let p_ID = Holders[hol_ID2].piece_ID
                    if Holders[hol_ID2].piece_ID != 0 && Holders[hol_ID2].piece_ID != 999 {
                        if Pieces[p_ID-1].piece_state == .en_passantable && isEnemyPieceOnHolder(hol_ID2){
                            //add piece holderID to possible moves
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                }
            } else {
                let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                // check if holder holds a piece
                if Holders[hol_ID].piece_ID == 0 {
                    //add piece holderID to possible moves
                    possibleHoldersIDs.append(hol_ID)
                } else {
                    break
                }
            }
        }
        var verifiedHoldersIDs: [Int] = []
        for ID in possibleHoldersIDs {
            if(ID != 64 && Holders[ID].piece_ID == 0){
                verifiedHoldersIDs.append(ID)
            }
        }
        return verifiedHoldersIDs
    }
    
    func showPossiblePawnMoves() -> Void {
        let moves = getPieceMoves()
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        var possibleHoldersIDs: [Int] = []
        for move in moves {
            //check if Pawn is using attack move
            if (move.1 != 0){
                let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                // check if attacked holder holds a piece
                if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                    //check if it is an enemy's piece
                    if isEnemyPieceOnHolder(hol_ID) {
                        //set piece state as threatened
                        Pieces[Holders[hol_ID].piece_ID - 1].addRelation(ChosenPieceID, .is_threatening)
                    }
                    //check for en_passantable pawns
                } else if Holders[hol_ID].piece_ID == 0 {
                    let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                    let hol_ID2 = getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1))
                    let p_ID = Holders[hol_ID2].piece_ID
                    if Holders[hol_ID2].piece_ID > 0 && Holders[hol_ID2].piece_ID != 999 {
                        if Pieces[p_ID-1].isEnpassantable() && isEnemyPieceOnHolder(hol_ID2){
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                }
            } else {
                let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                // check if holder holds a piece
                if Holders[hol_ID].piece_ID == 0 {
                    possibleHoldersIDs.append(hol_ID)
                } else {
                    break
                }
            }
        }
        var verifiedHoldersIDs: [Int] = []
        for ID in possibleHoldersIDs {
            if(ID != 64 && Holders[ID].piece_ID == 0){
                verifiedHoldersIDs.append(ID)
                Holders[ID].piece_ID = -1
            }
        }
        PossibleMoves = verifiedHoldersIDs

    }
    
    func PossiblePiecesStateMoves() -> Void {
        let p_s = Pieces[ChosenPieceID-1].STATE()
        switch p_s {
        case .free, .threatened, .protects, .pinned:
            showPossiblePiecesMoves()
            break
        case .is_threatening, .promotion, .gives_check, .en_passantable:
            showPossiblePiecesMoves()
            break
        case .in_check:
            canSaveKing()
            break
        case .is_pinning, .double_check, .checkmate:
            //no moves
            break;
        }
    }
    
    func PossiblePiecesStateMoves2() -> Void {
        let p_s = Pieces[ChosenPieceID-1].STATE()
        switch p_s {
        case .free, .threatened, .is_threatening, .pinned, .en_passantable, .promotion:
            showPossiblePiecesMoves2()
            break
        case .protects:
            showPossiblePiecesMoves2()
            break
        case .in_check, .double_check, .gives_check:
            canSaveKing()
            break
        case .is_pinning, .checkmate:
            //no moves
            break;
        }
    }
    
    func getPossiblePiecesMoves(_ p_ID: Int) -> [Int] {
        let moves = getSpecificPieceMoves(p_ID)
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        var possibleHoldersIDs: [Int] = []
        for move in moves {
            if(moveMultiplier()){
                for x in 1...8 {
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x)))
                    // check if attacked holder holds a piece
                    if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                        //check if it is an enemy's piece
                        if isEnemyPieceOnHolder(hol_ID) {
                            //add piece holderID to possible moves
                            possibleHoldersIDs.append(hol_ID)

                            break
                        } else {
                            break
                        }
                    } else if Holders[hol_ID].piece_ID == 0{
                        possibleHoldersIDs.append(hol_ID)
                    }
                }
            } else {
                //check if chosenPiece is Pawn type
                if (Pieces[ChosenPieceID-1].piece_type == .bPawn || Pieces[ChosenPieceID-1].piece_type == .wPawn) {
                    //check if Pawn is using attack move
                    if (move.1 != 0){
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                        // check if attacked holder holds a piece
                        if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                            //check if it is an enemy's piece
                            if isEnemyPieceOnHolder(hol_ID) {
                                //add piece holderID to possible moves
                                possibleHoldersIDs.append(hol_ID)
                            }
                            //check for en_passantable pawns
                        } else if Holders[hol_ID].piece_ID == 0 {
                            let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                            let hol_ID2 = getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1))
                            let p_ID = Holders[hol_ID2].piece_ID
                            if Holders[hol_ID2].piece_ID != 0 && Holders[hol_ID2].piece_ID != 999 {
                                if Pieces[p_ID-1].piece_state == .en_passantable && isEnemyPieceOnHolder(hol_ID2){
                                    possibleHoldersIDs.append(hol_ID)
                                }
                            }
                        }
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                        // check if attacked holder holds a piece
                        if Holders[hol_ID].piece_ID == 0 {
                            //add piece holderID to possible moves
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                } else {
                    //check attack of other type of pieces
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                    // check if attacked holder holds a piece
                    if Holders[hol_ID].piece_ID != 0 {
                        //check if it is an enemy's piece
                        if isEnemyPieceOnHolder(hol_ID) {
                            //add piece holderID to possible moves
                            possibleHoldersIDs.append(hol_ID)
                        }
                    } else if Holders[hol_ID].piece_ID == 0{
                        possibleHoldersIDs.append(hol_ID)
                    }
                }
            }
        }
        var verifiedHoldersIDs: [Int] = []
        for ID in possibleHoldersIDs {
            if(ID != 64 && Holders[ID].piece_ID == 0){
                verifiedHoldersIDs.append(ID)
            }
        }
        return verifiedHoldersIDs
    }
    
    func showPossiblePiecesMoves() -> Void {
        let moves = getPieceMoves()
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        var possibleHoldersIDs: [Int] = []
        for move in moves {
            if(moveMultiplier()){
                for x in 1...8 {
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x)))
                    // check if attacked holder holds a piece
                    if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                        //check if it is an enemy's piece
                        if isEnemyPieceOnHolder(hol_ID) {
                            //set piece state as threatened
                            Pieces[Holders[hol_ID].piece_ID - 1].addRelation(ChosenPieceID, .is_threatening)
                            Pieces[ChosenPieceID - 1].addRelation(Holders[hol_ID].piece_ID, .threatened)
                            break
                        } else {
                            break
                        }
                    } else if Holders[hol_ID].piece_ID == 0{
                        possibleHoldersIDs.append(hol_ID)
                    }
                }
            } else {
                //check attack of other type of pieces
                let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                // check if attacked holder holds a piece
                if Holders[hol_ID].piece_ID != 0 {
                    //check if it is an enemy's piece
                    if isEnemyPieceOnHolder(hol_ID) {
                        //set piece state as threatened
                        Pieces[Holders[hol_ID].piece_ID - 1].addRelation(ChosenPieceID, .is_threatening)
                        Pieces[ChosenPieceID - 1].addRelation(Holders[hol_ID].piece_ID, .threatened)
                    }
                } else if Holders[hol_ID].piece_ID == 0{
                    possibleHoldersIDs.append(hol_ID)
                }
            }
        }
        var verifiedHoldersIDs: [Int] = []
        for ID in possibleHoldersIDs {
            if(ID != 64 && Holders[ID].piece_ID == 0){
                verifiedHoldersIDs.append(ID)
                Holders[ID].piece_ID = -1
            }
        }
        PossibleMoves = verifiedHoldersIDs
    }
    
    func showPossiblePiecesMoves2() -> Void {
        let moves = getPieceMoves()
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        var possibleHoldersIDs: [Int] = []
        if Pieces[ChosenPieceID-1].isProtecting() {
            let dir = inv_dir(PinDirection())
            if(moveMultiplier()){
                for x in 1...8 {
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+(dir.0*x), holderCoords.file+(dir.1*x)))
                    // check if attacked holder holds a piece
                    if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                        //check if it is an enemy's piece
                        if isEnemyPieceOnHolder(hol_ID) {
                            //set piece state as threatened
                            Pieces[Holders[hol_ID].piece_ID - 1].addRelation(ChosenPieceID, .is_threatening)
                            Pieces[ChosenPieceID - 1].addRelation(Holders[hol_ID].piece_ID, .threatened)
                            break
                        } else {
                            break
                        }
                    } else if Holders[hol_ID].piece_ID == 0{
                        possibleHoldersIDs.append(hol_ID)
                    }
                }
            } else {
                //check attack of other type of pieces
                let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+dir.0, holderCoords.file+dir.1))
                // check if attacked holder holds a piece
                if Holders[hol_ID].piece_ID != 0 {
                    //check if it is an enemy's piece
                    if isEnemyPieceOnHolder(hol_ID) {
                        //set piece state as threatened
                        Pieces[Holders[hol_ID].piece_ID - 1].addRelation(ChosenPieceID, .is_threatening)
                        Pieces[ChosenPieceID - 1].addRelation(Holders[hol_ID].piece_ID, .threatened)
                    }
                } else if Holders[hol_ID].piece_ID == 0{
                    possibleHoldersIDs.append(hol_ID)
                }
            }
            var verifiedHoldersIDs: [Int] = []
            for ID in possibleHoldersIDs {
                if(ID != 64 && Holders[ID].piece_ID == 0){
                    verifiedHoldersIDs.append(ID)
                    Holders[ID].piece_ID = -1
                }
            }
            PossibleMoves = verifiedHoldersIDs
        } else {
            for move in moves {
                if(moveMultiplier()){
                    for x in 1...8 {
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x)))
                        // check if attacked holder holds a piece
                        if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                            //check if it is an enemy's piece
                            if isEnemyPieceOnHolder(hol_ID) {
                                //set piece state as threatened
                                Pieces[Holders[hol_ID].piece_ID - 1].addRelation(ChosenPieceID, .is_threatening)
                                Pieces[ChosenPieceID - 1].addRelation(Holders[hol_ID].piece_ID, .threatened)
                                break
                            } else {
                                break
                            }
                        } else if Holders[hol_ID].piece_ID == 0{
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                } else {
                    //check attack of other type of pieces
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                    // check if attacked holder holds a piece
                    if Holders[hol_ID].piece_ID != 0 {
                        //check if it is an enemy's piece
                        if isEnemyPieceOnHolder(hol_ID) {
                            //set piece state as threatened
                            Pieces[Holders[hol_ID].piece_ID - 1].addRelation(ChosenPieceID, .is_threatening)
                            Pieces[ChosenPieceID - 1].addRelation(Holders[hol_ID].piece_ID, .threatened)
                        }
                    } else if Holders[hol_ID].piece_ID == 0{
                        possibleHoldersIDs.append(hol_ID)
                    }
                }
            }
            var verifiedHoldersIDs: [Int] = []
            for ID in possibleHoldersIDs {
                if(ID != 64 && Holders[ID].piece_ID == 0){
                    verifiedHoldersIDs.append(ID)
                    Holders[ID].piece_ID = -1
                }
            }
            PossibleMoves = verifiedHoldersIDs
        }
    }
    
    func showPossibleMoves() -> Void {
        if (Pieces[ChosenPieceID-1].piece_type == .bPawn || Pieces[ChosenPieceID-1].piece_type == .wPawn){
            PossiblePawnStateMoves2()
        } else {
            PossiblePiecesStateMoves2()
        }
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
    private var Piece_type: PieceTypes
    private var Piece_state: PlayState = .free
    private var _state: [PlayState] = [.free]
    private var Relations: [(Int, PlayState)] = []
    
    public var id: Int { get { return ID } }
    public var color: Int { get { return COLOR } }
    public var piece_type: PieceTypes { get {return Piece_type} set {Piece_type = newValue } }
    public var piece_state: PlayState { get { return Piece_state} set { Piece_state = newValue } }
    public var relations: [(Int, PlayState)] { get { return Relations } }
    
    init(_ i: Int,_ c: Int, _ p_t: PieceTypes){
        ID = i
        COLOR = c
        Piece_type = p_t
    }
    
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        return lhs.id == rhs.id
    }
    
    func clearRelations() -> Void {
        self.Relations = []
        self.addRelation(self.ID, .free)
    }
    
    func getPieceRelation(_ p_ID: Int) -> PlayState {
        if let rel = Relations.first(where: {$0.0 == p_ID}) {
            return rel.1
        } else {
            return .free
        }
    }
    
    func addRelation(_ p_ID: Int, _ p_s: PlayState) -> Void {
        Relations.append((p_ID, p_s))
        if isThreatened() || isPinned() || isProtecting(){
            notFree()
        }
    }
    
    func removeRelation(_ p_ID: Int) -> Void {
        Relations.removeAll(where: {$0.0 == p_ID})
    }
    
    func isThreatened() -> Bool {
        if Relations.contains(where: {$0.1 == .is_threatening}) {
            return true
        }
        return false
    }
    
    func isPinned() -> Bool {
        if Relations.contains(where: {$0.1 == .is_pinning}) {
            return true
        }
        return false
    }
    
    func isProtecting() -> Bool {
        let kingID = COLOR == 1 ? 5 : 29
        if Relations.contains(where: {$0.0 == kingID && $0.1 == .protects}) {
            return true
        }
        return false
    }
    
    func beingPromoted() -> Bool {
        if Relations.contains(where: {$0.1 == .promotion}) {
            return true
        }
        return false
    }
    
    func notFree() -> Void {
        Relations.removeAll(where: {$0.1 == .free })
    }
    
    func isEnpassantable() -> Bool {
        if self.piece_type == .wPawn || self.piece_type == .bPawn {
            if Relations.contains(where: {$0.1 == .en_passantable}){
                return true
            }
        }
        return false
    }
    
    func STATE() -> PlayState {
        if beingPromoted() {
            return .promotion
        } else if isPinned() {
            return .is_pinning
        } else {
            if isProtecting() {
                return .protects
            } else if isThreatened() {
                if isProtecting() {
                    return .protects
                }
                return .is_threatening
            }
        }
        return .free
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
    case is_threatening
    case pinned
    case is_pinning
    case en_passantable
    case promotion
    case in_check
    case protects
    case gives_check
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
