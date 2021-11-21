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
    
    @Published var WhPlayerTakenPieces = [Piece]()
    var WPCounter: Int {
        var p_value = 0
        for piece in WhPlayerTakenPieces {
            p_value += piece.value()
        }
        return p_value }
    @Published var BlPlayerTakenPieces = [Piece]()
    
    var BPCounter: Int {
        var p_value = 0
        for piece in BlPlayerTakenPieces {
            p_value += piece.value()
        }
        return p_value }
    
    func checkPointsFor(player: Int) -> Int {
        if player == 1 {
            var p_value = 0
            for piece in WhPlayerTakenPieces {
                p_value += piece.value()
            }
            return p_value
        } else {
            var p_value = 0
            for piece in BlPlayerTakenPieces {
                p_value += piece.value()
            }
            return p_value
        }
    }
    
    //Variable holding Pieces location
    //Piece ID - 1 == Key
    //Holder ID AND COORDS == Value
    @Published var GameState: [Int] =
        [0,1,2,3,4,5,6,7,
         8,9,10,11,12,13,14,15,
         48,49,50,51,52,53,54,55,
         56,57,58,59,60,61,62,63]
    
    @Published var ChosenPieceID: Int = 0
    @Published var isPicked = false
    @Published var ChosenHolder = 0
    @Published var PossibleMoves = [Int]()
    @Published var showPromotion = false
    

    @Published var PiecesRelations = [(Int,Relation,Int)]()
    /*
     This variable will hold all the relations between pieces that will help to assess the position
    
     relation format: First Piece ID -> RELATION TO -> Second Piece ID
     example:         QUEEN -> Pins -> PAWN
     
     */
    

    func Assess(_ of: Int) -> MovesRange {
        //check the relations to asses what moves can be played by given piece
        //f.ex. if your king is in check you can only make moves that will save king or move king out of check
        print("White Relations")
        for a in PiecesRelations {
            if a.0 < 17 {
                print(a.0.description+" "+RelationSign[a.1]!+" "+a.2.description)
            }
        }
        print("Black Relations")
        for a in PiecesRelations {
            if a.0 > 16 {
                print(a.0.description+" "+RelationSign[a.1]!+" "+a.2.description)
            }
        }
        
        if !isPinned2(of) {
            return .free
        } else {
            return .restricted
        }
    }
    
    func isThreatened2(_ p_ID: Int) -> Bool {
        return PiecesRelations.contains(where: {$0.2 == p_ID && ($0.1 == .capture_threat || $0.1 == .mutual_capture_threat || $0.1 == .pin_with_mutual_capture_threat) })
    }
    
    func Threatens2(_ p_ID: Int) -> Bool {
        return PiecesRelations.contains(where: {$0.0 == p_ID && ($0.1 == .capture_threat || $0.1 == .mutual_capture_threat || $0.1 == .pin_with_mutual_capture_threat)})
    }
    
    func isPinning2(_ p_ID: Int) -> Bool {
        return PiecesRelations.contains(where: {$0.0 == p_ID && ($0.1 == .pin || $0.1 == .pin_with_movement_possibility || $0.1 == .pin_with_mutual_capture_threat)})
    }
    
    func isPinned2(_ p_ID: Int) -> Bool {
        return PiecesRelations.contains(where: {$0.2 == p_ID && ($0.1 == .pin || $0.1 == .pin_with_movement_possibility || $0.1 == .pin_with_mutual_capture_threat)})
    }
    
    func isProtecting2(_ p_ID: Int) -> Bool {
        return PiecesRelations.contains(where: {$0.2 == p_ID && $0.1 == .protects})
    }
    
    func isPromoting(_ p_ID: Int) -> Bool {
        return PiecesRelations.contains(where: {$0.0 == p_ID && $0.2 == p_ID && $0.1 == .promotion})
    }
    
    func addPieceRelation(_ p_ID: Int, _ relation: Relation, _ to_piece: Int) -> Void {
        PiecesRelations.append((p_ID, relation, to_piece))
        
    }
    
    func alterPieceRelation(_ p_1: Int,_ p_2: Int,_ to_relation: Relation) -> Void {
        for index in 0..<PiecesRelations.count {
            if PiecesRelations[index].0 == p_1 && PiecesRelations[index].2 == p_2{
                PiecesRelations[index].1 = to_relation
            }
        }
    }
    
    func resetRelationsOf(_ p_ID: Int ) -> Void {
        PiecesRelations.removeAll(where: { $0.0 == p_ID })
        PiecesRelations.removeAll(where: { $0.2 == p_ID })
    }
    
    func removePieceRelation(_ p_ID: Int, _ relation: Relation, _ to_piece: Int) -> Void {
        PiecesRelations.removeAll(where: { $0.0 == p_ID })
    }
    
    func findPiecesRelated(to: Int) -> [Int] {
        var relatedPieces = [Int]()
        for Rel in PiecesRelations {
            if Rel.2 == to {
                relatedPieces.append(Rel.0)
            }
        }
        return relatedPieces
    }
    
    func findRelatedPieces(of: Int) -> [Int] {
        var relatedPieces = [Int]()
        for Rel in PiecesRelations {
            if Rel.0 == of {
                relatedPieces.append(Rel.2)
            }
        }
        return relatedPieces
    }
    
    func relationExist(_ of: Int, _ relation: Relation, _ to: Int) -> Bool {
        return PiecesRelations.contains(where: { $0.0 == of && $0.1 == relation && $0.2 == to })
    }
    
    func verifyCurrentRelations(_ p_ID: Int) -> Void {
        // FROM Piece
        let relsOf = findRelatedPieces(of: p_ID)
        for rel in relsOf {
            PiecesRelations.removeAll(where: { $0.0 == p_ID && $0.2 == rel })
        }
        
        //TO Piece
        let relsTo = findPiecesRelated(to: p_ID)
        for rel_piece in relsTo {
            resetRelationsOf(rel_piece)
            if GameState[rel_piece-1] != 999 {
                PositionCheckFor(rel_piece)
            }
        }
    }
    
    func getProtectingPiecesIDs(_ of: Int) -> [Int] {
        var protectingPieces = [Int]()
        for Rel in PiecesRelations {
            if Rel.2 == of && Rel.1 == .protects {
                protectingPieces.append(Rel.0)
            }
        }
        return protectingPieces
    }
    
    func setRelation(_ of: Int, _ to: Int) -> Void {
        let rel = getRelation(of, to)
        if rel != .none && !relationExist(of,rel,to) {
            addPieceRelation(of,rel,to)
        }
        
        let rel2 = getRelation(to, of)
        if rel2 != .none && !relationExist(to,rel,of) {
            addPieceRelation(to,rel2,of)
        }
    }
    
    func getRelation(_ of: Int, _ to: Int) -> Relation{
        
        let thisPieceMoves = getPieceMovesFor(of)
        let thisPieceCoords = getHolderCoordsByPiece(of)
        
        let enemyKingP_ID = Pieces[of-1].color == 1 ? 29 : 5
        
        let enemyPieceHolderID = getLocationByPieceID(to)
        
        var direction: (Int, Int) = (0,0)
        var iCanAttack = false
                
        if isPawn(of) {
            MOVES: for move in thisPieceMoves {
                if move.1 != 0 {
                    if getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1)) == 64 {
                        continue MOVES
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1))
                        if hol_ID == enemyPieceHolderID {
                            direction = move
                            iCanAttack = true
                            break
                        }
                    }
                }
            }
        } else {
            if moveMultiplier(of){
                MOVES: for move in thisPieceMoves {
                    for x in 1...8 {
                        if getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x))) == 64{
                            continue MOVES
                        } else {
                            let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x)))
                            if hol_ID == enemyPieceHolderID {
                                direction = move
                                iCanAttack = true
                                break
                            }
                        }
                    }
                }
            } else {
                MOVES: for move in thisPieceMoves {
                    if getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1)) == 64 {
                        continue MOVES
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1))
                        if hol_ID == enemyPieceHolderID {
                            direction = move
                            iCanAttack = true
                        }
                    }
                }
            }
        }

        
        if to == enemyKingP_ID && iCanAttack == true {
            return Relation.check
        }
        
        //check if our piece can be attacked by given Piece
        let enemyCanAttack = canCaptureMe(getPieceIDByLocation(locId: enemyPieceHolderID), of)
        let enemyCanMove = canMoveOnLine(getPieceIDByLocation(locId: enemyPieceHolderID),direction)
        
        //let enemyKingProtectingPieces = getProtectingPiecesIDs(enemyKingP_ID)
        let enemyPieceProtectsKing = isProtectingOnLine(Holders[enemyPieceHolderID].piece_ID,direction)
        
        if iCanAttack {
            //check if the knight is attacking
            if Moves.knight.contains(where: { $0 == direction }) {
                if !enemyCanMove && !enemyCanAttack {
                    return Relation.capture_threat
                } else if enemyCanMove && !enemyCanAttack{
                    return Relation.capture_threat
                } else if !enemyCanMove && enemyCanAttack{
                    return Relation.mutual_capture_threat
                } else if enemyCanMove && enemyCanAttack{
                    return Relation.mutual_capture_threat
                } else {
                    return .none
                }
            } else {
                //if enemyKingProtectingPieces.contains(where: {$0 == to}){
                if enemyPieceProtectsKing {
                    //if piece is protecting king
                    if !enemyCanMove && !enemyCanAttack {
                        return Relation.pin
                    } else if enemyCanMove && !enemyCanAttack{
                        return Relation.pin_with_movement_possibility
                    } else if !enemyCanMove && enemyCanAttack{
                        return Relation.pin_with_mutual_capture_threat
                    } else if enemyCanMove && enemyCanAttack{
                        return Relation.pin_with_mutual_capture_threat
                    } else {
                        return .none
                    }
                } else {
                    if !enemyCanMove && !enemyCanAttack {
                        return Relation.capture_threat
                    } else if enemyCanMove && !enemyCanAttack{
                        return Relation.capture_threat
                    } else if !enemyCanMove && enemyCanAttack{
                        return Relation.mutual_capture_threat
                    } else if enemyCanMove && enemyCanAttack{
                        return Relation.mutual_capture_threat
                    } else {
                        return .none
                    }
                }
            }
        } else {
            return .none
        }
    }
    
    func isProtectingOnLine(_ p_ID: Int, _ line: (Int,Int)) -> Bool {
        let thisPieceCoords = getHolderCoordsByPiece(p_ID)
        for x in 1...8 {
            if getHolderIDFromCoord(Coord(thisPieceCoords.rank+(line.0*x), thisPieceCoords.file+(line.1*x))) != 64 {
                let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(line.0*x), thisPieceCoords.file+(line.1*x)))
                if isEnemyKingOnHolder(hol_ID) {
                    return true
                }
            } else {
                return false
            }
        }
        return false
    }
    
    //checks if given piece can move
    func canMoveOnLine(_ p_ID: Int,_ dir: (Int, Int)) -> Bool {
        let moves = getPieceMovesFor(p_ID)
        let p_cords = getHolderCoordsByPiece(p_ID)
        
        if Moves.knight.contains(where: { $0 == dir }) {
            return true
        }
        
        if isPawn(p_ID){
            MOVES: for move in moves {
                if move == dir || move == inv_dir(dir) {
                    //check if Pawn is not attacking
                    if (move.1 == 0){
                        if getHolderIDFromCoord(Coord(p_cords.rank+move.0, p_cords.file+move.1)) == 64 {
                            break
                        } else {
                            let hol_ID = getHolderIDFromCoord(Coord(p_cords.rank+move.0, p_cords.file+move.1))
                            // check if attacked holder holds a piece
                            if Holders[hol_ID].piece_ID == 0 {
                                return true
                            } else {
                                return false
                            }
                        }
                    }
                } else {
                    continue MOVES
                }
            }
        } else {
            //check other type of pieces
            MOVES: for move in moves {
                if move == dir || move == inv_dir(dir) {
                    if moveMultiplier() {
                        for x in 1...8 {
                            if getHolderIDFromCoord(Coord(p_cords.rank+(move.0*x), p_cords.file+(move.1*x))) == 64{
                                continue MOVES
                            } else {
                                let hol_ID = getHolderIDFromCoord(Coord(p_cords.rank+(move.0*x), p_cords.file+(move.1*x)))
                                // check if attacked holder holds a piece
                                if Holders[hol_ID].piece_ID == 0 {
                                    return true
                                } else {
                                    return false
                                }
                            }
                        }
                    } else {
                        if getHolderIDFromCoord(Coord(p_cords.rank+(move.0), p_cords.file+(move.1))) == 64{
                            continue MOVES
                        } else {
                            let hol_ID = getHolderIDFromCoord(Coord(p_cords.rank+(move.0), p_cords.file+(move.1)))
                            if Holders[hol_ID].piece_ID == 0 {
                                return true
                            } else {
                                return false
                            }
                        }
                    }
                } else {
                    continue MOVES
                }
            }
        }
        return false
    }
    
    //checks if given piece can attack our piece
    func canCaptureMe(_ p_ID: Int, _ px_ID: Int) -> Bool {
        let moves = getPieceMovesFor(p_ID)
        let p_cords = getHolderCoordsByPiece(p_ID)
                
        if isPawn(p_ID){
            MOVES: for move in moves {
                //check if Pawn is using attack move
                if (move.1 != 0){
                    if getHolderIDFromCoord(Coord(p_cords.rank+move.0, p_cords.file+move.1)) == 64 {
                        continue MOVES
                    }
                    let hol_ID = getHolderIDFromCoord(Coord(p_cords.rank+move.0, p_cords.file+move.1))
                    // check if attacked holder holds a piece
                    if Holders[hol_ID].piece_ID == px_ID {
                        return true
                    }
                }
            }
        } else {
            //check other type of pieces
            MOVES: for move in moves {
                if moveMultiplier() {
                    for x in 1...8 {
                        if getHolderIDFromCoord(Coord(p_cords.rank+(move.0*x), p_cords.file+(move.1*x))) == 64{
                            continue MOVES
                        } else {
                            let hol_ID = getHolderIDFromCoord(Coord(p_cords.rank+(move.0*x), p_cords.file+(move.1*x)))
                            if Holders[hol_ID].piece_ID == px_ID {
                                return true
                            }
                        }
                    }
                } else {
                    if getHolderIDFromCoord(Coord(p_cords.rank+(move.0), p_cords.file+(move.1))) == 64{
                        continue MOVES
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(p_cords.rank+(move.0), p_cords.file+(move.1)))
                        if Holders[hol_ID].piece_ID == px_ID {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    func isAttackedBy() -> [Int] {
        let myPiece = ChosenPieceID
        let myPieceHolderID = getLocationByPieceID(myPiece)
        let thisPieceCoords = getHolderCoordsByPiece(myPiece)
        
        var Attackers: [Int] = []
        
        //check if there any enemy piece that can attack our piece on all lines of attack
        MOVES: for move in Moves.queen {
            for x in 1...8 {
                if getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x))) == 64{
                    continue MOVES
                } else {
                    let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x)))
                    if Holders[hol_ID].piece_ID > 0 {
                        if isEnemyPieceOnHolder(hol_ID) {
                            let enemyCanAttack = getAttackedHoldersOfPiece(getPieceIDByLocation(locId: hol_ID)).contains(where: {$0 == myPieceHolderID})
                            if enemyCanAttack {
                                Attackers.append(Holders[hol_ID].piece_ID)
                                continue MOVES
                            }
                        }
                    }
                }
            }
        }
        
        //check if there any knights that can attack our piece
        MOVES2: for move in Moves.knight {
            if getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1)) == 64 {
                continue MOVES2
            } else {
                let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1))
                if Holders[hol_ID].piece_ID > 0 {
                    if isEnemyPieceOnHolder(hol_ID) {
                        let p_at = Holders[hol_ID].piece_ID
                        let enemyCanAttack = getAttackedHoldersOfPiece(p_at).contains(where: {$0 == myPieceHolderID})
                        if enemyCanAttack {
                            Attackers.append(Holders[hol_ID].piece_ID)
                            continue MOVES2
                        }
                    }
                }
            }
        }
        
        return Attackers
    }
    
    func breaksThePin(_ p_ID: Int) -> (Bool, Int) {
        //check if the move made by this piece broke the pin between some other pieces
        //returns bool and ID of pinned piece
        //if false returns false, 0
        
        for pin in PiecesRelations {
            if pin.1 == .pin || pin.1 == .pin_with_movement_possibility || pin.1 == .pin_with_mutual_capture_threat {
                let line = PinDirectionOf(pin.0)
                let thisPieceCoords = getHolderCoordsByPiece(p_ID)
                for x in 1...8 {
                    if getHolderIDFromCoord(Coord(thisPieceCoords.rank+(line.0*x), thisPieceCoords.file+(line.1*x))) != 64 {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(line.0*x), thisPieceCoords.file+(line.1*x)))
                        if hol_ID == getHolderIdByPieceId(p_ID) {
                            return (true, pin.2)
                        }
                    }
                }
                return (false, 0)
            }
        }
        
        return (false, 0)
    }
    
    func canSaveKing() -> Void {
        //function should provide possible ways to get king out of check without moving it like:
        // - holders that can be taken be pieces to stand on the line of check
        // - pieces that can capture the enemy piece that is checking the king
        //let direction = PinDirection()
        //let checkingPieces = getCheckingPieces()
        
    }
    
    func CheckKingsProtection() -> Void {
        let kings = [5,29]
        
        for king in kings {
            
            let kingCoords = getHolderCoordsByPiece(king)
            
            let relatedPieces = findPiecesRelated(to: king)
            
            MOVES: for move in Moves.queen {
                for x in 1...8 {
                    if getHolderIDFromCoord(Coord(kingCoords.rank+(move.0*x), kingCoords.file+(move.1*x))) == 64 {
                        continue MOVES
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(kingCoords.rank+(move.0*x), kingCoords.file+(move.1*x)))
                        if Holders[hol_ID].piece_ID > 0 {
                            if Pieces[king-1].color == Pieces[Holders[hol_ID].piece_ID - 1].color {
                                if !relatedPieces.contains(where: {$0 == Holders[hol_ID].piece_ID }){
                                    //addPieceRelation(Holders[hol_ID].piece_ID, .protects, king)
                                    continue MOVES
                                }
                            }
                        } else if Holders[hol_ID].piece_ID == 0 {
                            break
                        }
                    }
                }
            }
        }
    }
    
    func InCheckBy() -> [Int] {
        //get enemys king ID
        let wk = Pieces[ChosenPieceID-1].color == 1 ? 5 : 29
    
        let KingHolderID = getLocationByPieceID(wk)
        let thisPieceCoords = getHolderCoordsByPiece(wk)
        
        var Checks: [Int] = []
        
        //check if there any enemy piece that can check the king on all lines of attack
        MOVES: for move in Moves.queen {
            for x in 1...8 {
                if getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x))) == 64{
                    continue MOVES
                } else {
                    let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x)))
                    if isEnemyPiece(hol_ID) {
                        let enemyCanAttack = getAttackedHoldersOfPiece(getPieceIDByLocation(locId: hol_ID)).contains(where: {$0 == KingHolderID})
                        if enemyCanAttack {
                            Checks.append(hol_ID)
                            continue MOVES
                        }
                    } else if !isEnemyPiece(hol_ID) {
                        
                        addPieceRelation(getPieceIDByLocation(locId: hol_ID), .protects, wk)
                        continue MOVES
                    }
                }
            }
        }
        
        //check if there any knights that can check the king
        MOVES2: for move in Moves.knight {
            if getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0), thisPieceCoords.file+(move.1))) == 64{
                continue MOVES2
            } else {
                let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0), thisPieceCoords.file+(move.1)))
                if isEnemyPiece(hol_ID) {
                    let enemyCanAttack = getAttackedHoldersOfPiece(getPieceIDByLocation(locId: hol_ID)).contains(where: {$0 == KingHolderID})
                    if enemyCanAttack {
                        Checks.append(hol_ID)
                        continue MOVES2
                    }
                }
            }
        }
        
        return Checks
    }
    
    //GAME LOGIC
    
    func set() -> Void {
        for index in 0..<GameState.count {
            //Piece ID = array index +1
            Holders[GameState[index]].piece_ID = index+1
        }
        //CheckKingsProtection()
    }
    
    func put() -> Void {
        //check if holdes is on list of possible moves of a Piece or is on list of threats
        //Holders[ChosenHolder].piece_ID == -1 ||
        if(PossibleMoves.contains(Holders[ChosenHolder].id)){
            //check for enpassant pawn state or attack
            enPassantCheck()
            //remove pointers from holders
            hidePossibileMoves()
            //Remove piece from it's initial holer
            Holders[GameState[ChosenPieceID-1]].piece_ID = 0
            //update Piece holder's ID in GameState
            GameState[ChosenPieceID-1] = ChosenHolder
            //put Piece on new Holder
            Holders[ChosenHolder].piece_ID = ChosenPieceID
            //pawn promotion check
            promotionCheck()
            //create function to remove state from previously threatened pieces
            verifyCurrentRelations(ChosenPieceID)
            //CheckKingsProtection()
            //check the position
            PositionCheck()
            //reset chosen Piece and holder
            ChosenPieceID = 0
            ChosenHolder = 0
            isPicked = false
        }
    }
    
    func Attack(_ p_ID: Int) -> Void {
        if((isThreatened2(p_ID) || isPinned2(p_ID)) && isEnemyPiece(p_ID)){
            //Move attacked piece to Players pieces counter Array
            if Pieces[p_ID-1].color == 0 {
                WhPlayerTakenPieces.append(Pieces[p_ID-1])
            } else {
                BlPlayerTakenPieces.append(Pieces[p_ID-1])
            }
            //remove piece from its initial holder
            Holders[getLocationByPieceID(ChosenPieceID)].piece_ID = 0
            //update piece location in gamestate
            GameState[ChosenPieceID-1] = getLocationByPieceID(p_ID)
            //put piece on final holder
            Holders[getLocationByPieceID(p_ID)].piece_ID = ChosenPieceID
            //place the attacked piece on invisible holder
            GameState[p_ID-1] = 999
            promotionCheck()
            verifyCurrentRelations(ChosenPieceID)
            //CheckKingsProtection()
            PositionCheck()

            ChosenPieceID = 0
            ChosenHolder = 0
            hidePossibileMoves()
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
    
    func isEnemyPieceOnHolderFor(_ h_ID: Int, _ p_ID: Int) -> Bool {
        return Pieces[Holders[h_ID].piece_ID-1].color != Pieces[p_ID-1].color
    }
    
    func isFriendlyPieceOnHolder(_ h_ID: Int) -> Bool {
        if Holders[h_ID].piece_ID > 0 {
        return Pieces[Holders[h_ID].piece_ID-1].color == Pieces[ChosenPieceID-1].color
        } else {
            return false
        }
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
        //function looks for new pieces to set the relations with
        
        let thisPieceCoords = getHolderCoordsByPiece(ChosenPieceID)
        let thisPieceMoves = getPieceMovesFor(ChosenPieceID)
        
        var relatedPieces: [Int] = []
        
        if isPawn() {
            MOVES: for move in thisPieceMoves {
                if move.1 != 0 {
                    if getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1)) == 64 {
                        continue MOVES
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1))
                        
                        if Holders[hol_ID].piece_ID > 0 {
                            if isEnemyPiece(Holders[hol_ID].piece_ID) {
                                relatedPieces.append(Holders[hol_ID].piece_ID)
                                continue MOVES
                            } else if !isEnemyPiece(Holders[hol_ID].piece_ID) {
                                continue MOVES
                            }
                        }
                    }
                }
            }
        } else {
            MOVES: for move in thisPieceMoves {
                if(moveMultiplier()){
                    for x in 1...8 {
                        if getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x))) == 64 {
                            continue MOVES
                        } else {
                            let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x)))
                            
                            if Holders[hol_ID].piece_ID > 0 {
                                if isEnemyPiece(Holders[hol_ID].piece_ID) {
                                    relatedPieces.append(Holders[hol_ID].piece_ID)
                                    continue MOVES
                                } else if !isEnemyPiece(Holders[hol_ID].piece_ID) {
                                    continue MOVES
                                }
                            }
                        }
                    }
                } else {
                    if getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1)) == 64 {
                        continue MOVES
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1))
                        
                        if Holders[hol_ID].piece_ID > 0 {
                            if isEnemyPiece(Holders[hol_ID].piece_ID) {
                                relatedPieces.append(Holders[hol_ID].piece_ID)
                                continue MOVES
                            } else if !isEnemyPiece(Holders[hol_ID].piece_ID) {
                                continue MOVES
                            }
                        }
                    }
                }
            }
        }
        
        let otherAttackingPieces = isAttackedBy()
            
        let allRelatedPieces = Array(Set(relatedPieces + otherAttackingPieces))
        
        for P in allRelatedPieces {
            setRelation(ChosenPieceID, P)
        }
    }
    
    func PositionCheckFor(_ p_ID: Int) -> Void {
        let thisPieceCoords = getHolderCoordsByPiece(p_ID)
        let thisPieceMoves = getSpecificPieceMoves(p_ID)
        
        MOVES: for move in thisPieceMoves {
            if(moveMultiplier(p_ID)){
                for x in 1...8 {
                    if getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x))) == 64 {
                        continue MOVES
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+(move.0*x), thisPieceCoords.file+(move.1*x)))
                        
                        if Holders[hol_ID].piece_ID > 0 {
                            if isEnemyPieceOnHolderFor(hol_ID, p_ID) {
                                ChosenPieceID = p_ID
                                setRelation(p_ID, Holders[hol_ID].piece_ID)
                                continue MOVES
                            } else if !isEnemyPiece(Holders[hol_ID].piece_ID) {
                                continue MOVES
                            }
                        }
                    }
                }
            } else {
                if getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1)) == 64 {
                    continue MOVES
                } else {
                    let hol_ID = getHolderIDFromCoord(Coord(thisPieceCoords.rank+move.0, thisPieceCoords.file+move.1))
                    
                    if Holders[hol_ID].piece_ID > 0 {
                        if isEnemyPieceOnHolderFor(hol_ID, p_ID) {
                            setRelation(p_ID, Holders[hol_ID].piece_ID)
                            continue MOVES
                        } else if !isEnemyPiece(Holders[hol_ID].piece_ID) {
                            continue MOVES
                        }
                    }
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
            //check if pawn is pushed two squares forward to set it state as en_passantable
            if (getHolderCoordsByPiece(ChosenPieceID).rank == 1 && Pieces[ChosenPieceID-1].piece_type == .wPawn) || ( getHolderCoordsByPiece(ChosenPieceID).rank == 6 && Pieces[ChosenPieceID-1].piece_type == .bPawn) {
                if PossibleMoves.first != ChosenHolder {
                    Pieces[ChosenPieceID-1].addRelation(ChosenPieceID, .en_passantable)
                }
                //check if en passant move is being played
            } else if (Coordinates[Holders[ChosenHolder].id].file != Coordinates[GameState[ChosenPieceID-1]].file){
                let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                let hol_ID2 = getHolderIDFromCoord(Coord(Coordinates[Holders[ChosenHolder].id].rank+mod,Coordinates[Holders[ChosenHolder].id].file))
                let p_ID = Holders[hol_ID2].piece_ID
                if Holders[hol_ID2].piece_ID != 0 && Holders[hol_ID2].piece_ID != 999 && hol_ID2 != 64{
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
    
    func getPawnToPromote() -> Int {
        let promotionSquares = [0,1,2,3,4,5,6,7,56,57,58,59,60,61,62,63]
        let WPawns = [9,10,11,12,13,14,15,16]
        let BPawns = [17,18,19,20,21,22,23,24]
        
        for PromSqr in promotionSquares {
            if PromSqr < 8 {
                for Pawn_ID in BPawns {
                    if Holders[PromSqr].piece_ID == Pawn_ID {
                        return Pawn_ID
                    }
                }
            } else {
                for Pawn_ID in WPawns {
                    if Holders[PromSqr].piece_ID == Pawn_ID {
                        return Pawn_ID
                    }
                }
            }
        }
        return 999
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
    
    func promoteTo(_ to: PieceTypes) -> Void {
        let p_ID = getPawnToPromote()
        if p_ID != 999 {
            Pieces[p_ID-1].piece_type = to
            //check position <==== TO UPDATE
            PositionCheckFor(p_ID)
        }
    }
    
    func promotionCheck() -> Void {
        if Pieces[ChosenPieceID-1].piece_type == .bPawn && Coordinates[getLocationByPieceID(ChosenPieceID)].rank ==  0 {
            Pieces[ChosenPieceID-1].addRelation(ChosenPieceID, .promotion)
            addPieceRelation(ChosenPieceID, .promotion , ChosenPieceID)
            showPromotion = true
        } else if Pieces[ChosenPieceID-1].piece_type == .wPawn && Coordinates[getLocationByPieceID(ChosenPieceID)].rank ==  7 {
            Pieces[ChosenPieceID-1].addRelation(ChosenPieceID, .promotion)
            addPieceRelation(ChosenPieceID, .promotion , ChosenPieceID)
            showPromotion = true
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
    
    func getPieceMovesFor(_ p_ID: Int) -> [(Int,Int)] {
        switch Pieces[p_ID-1].piece_type {
        case .wPawn:
            if getHolderCoordsByPiece(p_ID).rank < 2 {
                return Moves.wpawn+[(2,0)]
            } else {
                return Moves.wpawn
            }
        case .bPawn:
            if getHolderCoordsByPiece(p_ID).rank > 5 {
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
    
    func PinDirectionOf(_ p_ID: Int) -> (Int, Int) {
        let KingID = Pieces[p_ID-1].color == 1 ? 5 : 29
        let KingH_ID = getLocationByPieceID(KingID)
        let PieceH_ID = getLocationByPieceID(p_ID)
        
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
    
    func isPawn(_ p_ID: Int) -> Bool {
        let pawnColor = Pieces[p_ID-1].color
        if pawnColor == 1 {
            if Pieces[p_ID-1].piece_type == .wPawn {
                return true
            }
        } else {
            if Pieces[p_ID-1].piece_type == .bPawn {
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
    
    func getPossiblePawnMoves(_ p_ID: Int) -> [Int] {
        let moves = getPieceMovesFor(p_ID)
        let holderCoords = getHolderCoordsByPiece(p_ID)
        var possibleHoldersIDs: [Int] = []
        MOVES: for move in moves {
            //check if Pawn is using attack move
            if (move.1 != 0){
                if getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)) == 64 {
                    continue MOVES
                } else {
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                    // check if attacked holder holds a piece
                    if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999{
                        //check if it is an enemy's piece
                        if isEnemyPieceOnHolder(hol_ID) {
                            //add piece holderID to possible moves
                            possibleHoldersIDs.append(hol_ID)
                        }
                        //check for en_passantable pawns
                    } else if Holders[hol_ID].piece_ID == 0 {
                        let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                        if getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1)) == 64 {
                            continue MOVES
                        } else {
                            let hol_ID2 = getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1))
                            let p_ID = Holders[hol_ID2].piece_ID
                            if Holders[hol_ID2].piece_ID != 0 && Holders[hol_ID2].piece_ID != 999 {
                                if Pieces[p_ID-1].piece_state == .en_passantable && isEnemyPieceOnHolder(hol_ID2){
                                    //add piece holderID to possible moves
                                    possibleHoldersIDs.append(hol_ID)
                                }
                            }
                        }
                    }
                }
            } else {
                if getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)) == 64 {
                    continue MOVES
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
        }
        return possibleHoldersIDs
    }
    
    func showPossiblePawnMoves() -> Void {
        let moves = getPieceMoves()
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        var possibleHoldersIDs: [Int] = []
        let piece_state = Assess(ChosenPieceID)
        if piece_state == .free {
            for move in moves {
                //check if Pawn is using attack move
                if (move.1 != 0){
                    if getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)) == 64 {
                      break
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                        // check if attacked holder holds a piece
                        if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                            //check if it is an enemy's piece
                            if isEnemyPieceOnHolder(hol_ID) {
                                possibleHoldersIDs.append(hol_ID)
                            }
                            //check for en_passantable pawns
                        } else if Holders[hol_ID].piece_ID == 0 {
                            let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                            let hol_ID2 = getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1))
                            let p_ID = Holders[hol_ID2].piece_ID
                            if Holders[hol_ID2].piece_ID > 0 && Holders[hol_ID2].piece_ID != 999 && hol_ID2 != 64 {
                                if Pieces[p_ID-1].isEnpassantable() && isEnemyPieceOnHolder(hol_ID2){
                                    possibleHoldersIDs.append(hol_ID)
                                }
                            }
                        }
                    }
                } else {
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                    // check if holder holds a piece
                    if Holders[hol_ID].piece_ID == 0 && hol_ID != 64 {
                        possibleHoldersIDs.append(hol_ID)
                    }
                }
            }
            PossibleMoves = possibleHoldersIDs
        } else if piece_state == .restricted {
            //for restricted moves
            let KingID = Pieces[ChosenPieceID-1].color == 1 ? 5 : 29
            var a = getProtectingPiecesIDs(KingID)
            if getProtectingPiecesIDs(KingID).contains(where: {$0 == ChosenPieceID}) {
                //if pawn protects the king then check if it can move on the line of attack
                let lineOfAttack = PinDirection()
                
                for move in moves {
                    if move == lineOfAttack || move == inv_dir(lineOfAttack){
                    //check if Pawn is using attack move
                        if (move.1 != 0){
                            if getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)) == 64 {
                                break
                            } else {
                                let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                                // check if attacked holder holds a piece
                                if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999{
                                    //check if it is an enemy's piece
                                    if isEnemyPieceOnHolder(hol_ID) {
                                        possibleHoldersIDs.append(hol_ID)
                                    }
                                    //check for en_passantable pawns
                                } else if Holders[hol_ID].piece_ID == 0 && hol_ID != 64 {
                                    let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                                    let hol_ID2 = getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1))
                                    let p_ID = Holders[hol_ID2].piece_ID
                                    if Holders[hol_ID2].piece_ID > 0 && Holders[hol_ID2].piece_ID != 999 && hol_ID2 != 64 {
                                        if Pieces[p_ID-1].isEnpassantable() && isEnemyPieceOnHolder(hol_ID2){
                                            possibleHoldersIDs.append(hol_ID)
                                        }
                                    }
                                }
                            }

                        } else {
                            let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                            // check if holder holds a piece
                            if Holders[hol_ID].piece_ID == 0 && hol_ID != 64 {
                                possibleHoldersIDs.append(hol_ID)
                            }
                        }
                    }
                }
                PossibleMoves = possibleHoldersIDs
            } else {
                PossibleMoves = possibleHoldersIDs
            }
        } else {
            //no moves available
            PossibleMoves = possibleHoldersIDs
        }
    }
    
    func showPossiblePawnMoves2() -> Void {
        let moves = getPieceMoves()
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        var possibleHoldersIDs: [Int] = []
        let piece_state = Assess(ChosenPieceID)
        if piece_state == .free {
            for move in moves {
                //check if Pawn is using attack move
                if (move.1 != 0){
                    if getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)) == 64 {
                      break
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                        // check if attacked holder holds a piece
                        if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999 {
                            //check if it is an enemy's piece
                            if isEnemyPieceOnHolder(hol_ID) {
                                possibleHoldersIDs.append(hol_ID)
                            }
                            //check for en_passantable pawns
                        } else if Holders[hol_ID].piece_ID == 0 {
                            let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                            let hol_ID2 = getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1))
                            let p_ID = Holders[hol_ID2].piece_ID
                            if Holders[hol_ID2].piece_ID > 0 && Holders[hol_ID2].piece_ID != 999 && hol_ID2 != 64 {
                                if Pieces[p_ID-1].isEnpassantable() && isEnemyPieceOnHolder(hol_ID2){
                                    possibleHoldersIDs.append(hol_ID)
                                }
                            }
                        }
                    }
                } else {
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                    // check if holder holds a piece
                    if Holders[hol_ID].piece_ID == 0 && hol_ID != 64 {
                        possibleHoldersIDs.append(hol_ID)
                    }
                }
            }
            PossibleMoves = possibleHoldersIDs
        } else if piece_state == .restricted {
            //for restricted moves
            //if pawn protects the king then check if it can move on the line of attack
            let lineOfAttack = PinDirection()
            
            for move in moves {
                
                if move.0 == 2 || move.0 == -2 {
                    //check if Pawn is being push two squares and it's on line of attack
                    let moveLine = (move.0/2,move.1)
                    
                    if moveLine == lineOfAttack || move == inv_dir(lineOfAttack) {
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                        // check if holder holds a piece
                        if Holders[hol_ID].piece_ID == 0 && hol_ID != 64 {
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                    
                }
                
                if move == lineOfAttack || move == inv_dir(lineOfAttack) {
                //check if Pawn is using attack move
                    if (move.1 != 0){
                        if getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)) == 64 {
                            break
                        } else {
                            let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                            // check if attacked holder holds a piece
                            if Holders[hol_ID].piece_ID != 0 && Holders[hol_ID].piece_ID != 999{
                                //check if it is an enemy's piece
                                if isEnemyPieceOnHolder(hol_ID) {
                                    possibleHoldersIDs.append(hol_ID)
                                }
                                //check for en_passantable pawns
                            } else if Holders[hol_ID].piece_ID == 0 && hol_ID != 64 {
                                let mod = Pieces[ChosenPieceID-1].piece_type == .bPawn ? 1 : -1
                                let hol_ID2 = getHolderIDFromCoord(Coord(holderCoords.rank+move.0+mod, holderCoords.file+move.1))
                                let p_ID = Holders[hol_ID2].piece_ID
                                if Holders[hol_ID2].piece_ID > 0 && Holders[hol_ID2].piece_ID != 999 && hol_ID2 != 64 {
                                    if Pieces[p_ID-1].isEnpassantable() && isEnemyPieceOnHolder(hol_ID2){
                                        possibleHoldersIDs.append(hol_ID)
                                    }
                                }
                            }
                        }

                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                        // check if holder holds a piece
                        if Holders[hol_ID].piece_ID == 0 && hol_ID != 64 {
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                }
            }
            PossibleMoves = possibleHoldersIDs
        } else {
            //no moves available
            PossibleMoves = possibleHoldersIDs
        }
    }
    
    func PossiblePiecesStateMoves() -> Void {
        let p_s = Assess(ChosenPieceID)
        switch p_s {
        case .free, .restricted:
            showPossiblePiecesMoves()
            break
        case .none:
            //no moves
            break;
        }
    }
    
    func getPossiblePiecesMoves(_ p_ID: Int) -> [Int] {
        let moves = getPieceMovesFor(p_ID)
        let holderCoords = getHolderCoordsByPiece(p_ID)
        var possibleHoldersIDs: [Int] = []
        
        if Pieces[p_ID-1].piece_type == .King || Pieces[p_ID-1].piece_type == .Knight {
            MOVES: for move in moves {
                if getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)) == 64 {
                    continue MOVES
                } else {
                    let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                    // check if attacked holder holds a piece
                    if Holders[hol_ID].piece_ID > 0 && Holders[hol_ID].piece_ID != 999{
                        //check if it is an enemy's piece
                        if isEnemyPieceOnHolderFor(hol_ID,p_ID) {
                            //add piece holderID to possible moves
                            possibleHoldersIDs.append(hol_ID)
                            break
                        } else {
                            break
                        }
                    } else if Holders[hol_ID].piece_ID == 0 {
                        possibleHoldersIDs.append(hol_ID)
                    }
                }
            }
        } else {
            MOVES: for move in moves {
                for x in 1...8 {
                    if getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x))) == 64 {
                        continue MOVES
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x)))
                        // check if attacked holder holds a piece
                        if Holders[hol_ID].piece_ID > 0 && Holders[hol_ID].piece_ID != 999{
                            //check if it is an enemy's piece
                            if isEnemyPieceOnHolderFor(hol_ID,p_ID) {
                                //add piece holderID to possible moves
                                possibleHoldersIDs.append(hol_ID)
                                break
                            } else {
                                break
                            }
                        } else if Holders[hol_ID].piece_ID == 0 {
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                }
            }
        }
        return possibleHoldersIDs
    }
    
    func getHolderIdByPieceId(_ p_ID: Int) -> Int {
        for h in Holders {
            if h.piece_ID == p_ID {
                return h.id
            }
        }
        return 0
    }
    
    //get moves of piece considering its protecting a king or not
    func showPossiblePiecesMoves() -> Void {
        let moves = getPieceMoves()
        let holderCoords = getHolderCoordsByPiece(ChosenPieceID)
        
        var possibleHoldersIDs: [Int] = []
        let piece_state = Assess(ChosenPieceID)

        if piece_state == .restricted {
            if Pieces[ChosenPieceID-1].piece_type == .Knight {
                return
            }
            let dir = inv_dir(PinDirection())
            if(moveMultiplier()){
                for x in 1...8 {
                    if getHolderIDFromCoord(Coord(holderCoords.rank+(dir.0*x), holderCoords.file+(dir.1*x))) == 64 {
                        break
                    } else {
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+(dir.0*x), holderCoords.file+(dir.1*x)))
                        // check if attacked holder holds a piece
                        if Holders[hol_ID].piece_ID > 0 && Holders[hol_ID].piece_ID != 999 {
                            //check if it is an enemy's piece
                            if isEnemyPieceOnHolder(hol_ID) {
                                //set piece state as threatened
                                possibleHoldersIDs.append(hol_ID)
                                break
                            } else {
                                break
                            }
                        } else if Holders[hol_ID].piece_ID == 0 {
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                }
            } else {
                //check attack of other type of pieces
                let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+dir.0, holderCoords.file+dir.1))
                // check if attacked holder holds a piece
                if Holders[hol_ID].piece_ID > 0 && Holders[hol_ID].piece_ID != 999 {
                    //check if it is an enemy's piece
                    if isEnemyPieceOnHolder(hol_ID) {
                        //set piece state as threatened
                        possibleHoldersIDs.append(hol_ID)
                    }
                } else if Holders[hol_ID].piece_ID == 0 {
                    possibleHoldersIDs.append(hol_ID)
                }
            }
            PossibleMoves = possibleHoldersIDs
            
        } else if piece_state == .free {
            for move in moves {
                if(moveMultiplier()){
                    for x in 1...8 {
                        if getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x))) != 64 {
                            
                            let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+(move.0*x), holderCoords.file+(move.1*x)))
                            // check if attacked holder holds a piece
                            if Holders[hol_ID].piece_ID > 0 && Holders[hol_ID].piece_ID != 999{
                                //check if it is an enemy's piece
                                if isEnemyPieceOnHolder(hol_ID) {
                                    //set piece state as threatened
                                    possibleHoldersIDs.append(hol_ID)
                                    break
                                } else {
                                    break
                                }
                            } else if Holders[hol_ID].piece_ID == 0 {
                                possibleHoldersIDs.append(hol_ID)
                            }
                        }
                    }
                } else {
                    if getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1)) != 64 {
                        //check attack of other type of pieces
                        let hol_ID = getHolderIDFromCoord(Coord(holderCoords.rank+move.0, holderCoords.file+move.1))
                        // check if attacked holder holds a piece
                        if Holders[hol_ID].piece_ID > 0 && Holders[hol_ID].piece_ID != 999 {
                            //check if it is an enemy's piece
                            if isEnemyPieceOnHolder(hol_ID) {
                                //set piece state as threatened
                                possibleHoldersIDs.append(hol_ID)
                            }
                        } else if Holders[hol_ID].piece_ID == 0 {
                            possibleHoldersIDs.append(hol_ID)
                        }
                    }
                }
            }
            PossibleMoves = possibleHoldersIDs
        } else {
            PossibleMoves = possibleHoldersIDs
        }
    }
    
    func showPossibleMoves() -> Void {
        if (Pieces[ChosenPieceID-1].piece_type == .bPawn || Pieces[ChosenPieceID-1].piece_type == .wPawn){
            showPossiblePawnMoves2()
        } else {
            showPossiblePiecesMoves()
        }
    }
    
    func hidePossibileMoves() -> Void {
//        for id in PossibleMoves {
//            Holders[id].piece_ID = 0
//        }
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
    
    func moveMultiplier(_ p_ID: Int) -> Bool {
        if (Pieces[p_ID-1].piece_type == .Bishop || Pieces[p_ID-1].piece_type == .Rook || Pieces[p_ID-1].piece_type == .Queen) {
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
        if self.Relations.contains(where: {$0.1 == .en_passantable }){
            self.Relations = []
            self.addRelation(self.ID, .free)
            self.addRelation(self.ID, .en_passantable)
        } else if self.Relations.contains(where: {$0.1 == .promotion }){
            self.Relations = []
            self.addRelation(self.ID, .free)
            self.addRelation(self.ID, .promotion)
        } else {
            self.Relations = []
            self.addRelation(self.ID, .free)
        }
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
        if (self.piece_type == .wPawn || self.piece_type == .bPawn) && self.Relations.contains(where: {$0.1 == .en_passantable}) {
           return true
        } else {
            return false
        }
    }
    
    func STATE() -> PlayState {
        var a = self.Relations
        if beingPromoted() {
            return .promotion
        } else if isPinned() {
            return .is_pinning
        } else {
            if isProtecting() && isThreatened() {
                return .protects
            } else if isProtecting() && !isThreatened() {
                return .protects
            } else if !isProtecting() && isThreatened() {
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
    
    func value() -> Int{
        switch self.piece_type {
            case .Queen:
                return 9
        case .Rook:
            return 5
        case .Bishop, .Knight:
            return 3
        case .bPawn, .wPawn:
            return 1
        case .King:
            return 0
        }
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

enum MovesRange {
    case free
    case restricted
    case none
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

var RelationSign = [ Relation.capture_threat : "-->",
                     Relation.mutual_capture_threat : "<->",
                     Relation.pin : "->x",
                     Relation.pin_with_movement_possibility : ">-x",
                     Relation.pin_with_mutual_capture_threat : "<>x",
                     Relation.check : ">>x",
                     Relation.protects : "-|x",
                     Relation.promotion : "^^^",
                     Relation.none : "-X-"
]

enum Relation {
    case capture_threat
    case mutual_capture_threat
    case pin
    case pin_with_movement_possibility
    case pin_with_mutual_capture_threat
    case check
    case protects
    case promotion
    case none
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

var Moves2 = [ PieceTypes.wPawn : Moves.wpawn,
               PieceTypes.bPawn : Moves.bpawn,
               PieceTypes.Knight : Moves.knight,
               PieceTypes.Bishop : Moves.bishop,
               PieceTypes.Rook : Moves.rook,
               PieceTypes.Queen : Moves.queen,
               PieceTypes.King : Moves.king]

@main
struct Chess_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
