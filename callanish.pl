%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 			CALLANISH 			%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
%Grupo 2 			   %
%Turma 5 			   %
%----------------------%
%Pedro Faria 	ei11167%
%Rui Botto 		ei11021%
%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%
%Static New Boards%
%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%Empty Initial Board%
%%%%%%%%%%%%%%%%%%%%%

board([[0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0]]).	

%%%%%%%%%%%%%
%Test Boards%
%%%%%%%%%%%%%

board2([[0,0,0,0,0,0,0,0,0],
	   [1,2,2,2,0,0,0,0,0],
	   [2,0,0,0,0,0,0,0,0],
	   [1,0,0,0,0,0,0,0,0],
	   [1,0,0,0,0,0,0,0,0],
	   [1,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0]]).		

board3([[0,0,0,0,0,0,0,0,0],
	   [2,2,2,2,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0]]).

board4([[0,0,0,0,0,0,0,0,0],
	   [2,0,0,0,0,0,0,0,0],
	   [2,0,0,0,0,0,0,0,0],
	   [2,0,0,0,0,0,0,0,0],
	   [2,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0],
	   [0,0,0,0,0,0,0,0,0]]).		

%%%%%%%%%%%%%%
%Print Boards%
%%%%%%%%%%%%%%

printTitle:- nl, write('        * * * C A L L A N I S H * * *'),nl,nl.
draw_empty_line:-write('     -----------------------------------').
draw_board(B):- printTitle, nl,write('      A   B   C   D   E   F   G   H   I'), nl, draw_empty_line, nl, draw_lines(9,B), write('      A   B   C   D   E   F   G   H   I'), nl.
draw_lines(_,[]).
draw_lines(N,[H|T]):- write(N), write('   '), draw_line(H), write('|   '), write(N), nl, draw_empty_line, nl, N2 is N-1, draw_lines(N2,T).
draw_line([]).
draw_line([He|Ta]):- draw_board_element(He), draw_line(Ta).
draw_board_element(0):-write('|   '). %empty cell
draw_board_element(1):-write('| X '). %black piece
draw_board_element(2):-write('| O '). %white piece
draw_board_element(3):-write('| o '). %white stack
draw_board_element(4):-write('| x '). %black stack	

%%%%%%%%%%%%
%Game Logic%
%%%%%%%%%%%%

%%%%%%%%%%%%
%Test games%
%%%%%%%%%%%%

callanish2:- board2(Board),
		play(1, Board, white, 0).

callanish3:- board3(Board),
		play(1, Board, white, 0).

callanish4:- board4(Board),
		play(1, Board, white, 0).

%%%%%%%%%%
%New Game%
%%%%%%%%%%

callanish:- board(Board),
		play(1, Board, white, 0).

%%%%%%%%%%%%
%Game cicle%
%%%%%%%%%%%%

play(Turn, Board, Player, 1):-	nl,write('      *************CHECKMATE*************'),
											 nl,write('       ***White player is the winner***'),nl,nl,
											 draw_board(Board),nl.

play(Turn, Board, Player, 2):-	nl,write('      ***************CHECK***************'),
											nl,write('       ***White player is on check  ***'),nl,nl,
											draw_board(Board),nl,
											write('Turn: '), write(Turn),nl,nl,
											movement(Turn, Board, Player, NewBoard),
											check_end_game(Turn, NewBoard, Player, 2, End2),
											change_turn(Turn, NextTurn, Player, NextPlayer),
											play(NextTurn, NewBoard, NextPlayer, End2).					 							 

play(Turn, Board, Player, 3):-	nl,write('      *************CHECKMATE*************'),
											 nl,write('       ***Black player is the winner***'),nl,nl,
											 draw_board(Board),nl.

play(Turn, Board, Player, 4):-	nl,write('      ***************CHECK***************'),
											nl,write('       ***Black player is on check  ***'),nl,nl,
											draw_board(Board),nl,
											write('Turn: '), write(Turn),nl,nl,
											movement(Turn, Board, Player, NewBoard),
											check_end_game(Turn, NewBoard, Player, 4, End2),
											change_turn(Turn, NextTurn, Player, NextPlayer),
											play(NextTurn, NewBoard, NextPlayer, End2).		

play(Turn, Board, Player, End):-
								draw_board(Board),nl,
								write('Turn: '), write(Turn),nl,nl,
								movement(Turn, Board, Player, NewBoard),
								check_end_game(Turn, NewBoard, Player, End, End2),
								change_turn(Turn, NextTurn, Player, NextPlayer),
								play(NextTurn, NewBoard, NextPlayer, End2).								
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%First and second movements%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

movement(1, B, P, NB):-	play_movement(B, P, NB).

movement(2, B, P, NB):-	play_movement(B, P, NB).

play_movement(B, P, NB):-	repeat,
							ask_for_put(X, Y, P),
							evaluate_put(B, P, X, Y),
							put_piece(B, P, X, Y, NB),!.

%%%%%%%%%%%%%%%%%%%%%
%All other movements%
%%%%%%%%%%%%%%%%%%%%%

movement(T, B, P, NB):-	repeat,
						pick_piece(B, P, Xi, Yi, NB1),
						repeat,
						picked_from(Xi, Yi),
						call_available_movements(Xi, Yi),
						play_movement(NB1, P, Xi, Yi, NB2),draw_board(NB2),
						repeat,
						picked_from(Xi, Yi),
						call_available_movements(Xi, Yi),
						play_movement(NB2, P, Xi, Yi, NB).
					
pick_piece(B, P, Xi, Yi, NB):- 	ask_for_pick(Xi, Yi, P),
								evaluate_pick(B, P, Xi, Yi),
								remove_piece(B, P, Xi, Yi, NB).

play_movement(B, P, Xi, Yi, NB):-	ask_for_put(Xf, Yf, P),
									evaluate_put(B, P, Xi, Yi, Xf, Yf),
									put_piece(B, P, Xf, Yf, NB).

picked_from(Xi, Yi):-	num_to_alpha(Xi, Xalfa), 
						nl,write('Picked from: '),write(Xalfa),write(','),write(Yi),nl,nl.

%%%%%%%%%%%%%%%%%%%%%%%%%
%Available cells to move%
%%%%%%%%%%%%%%%%%%%%%%%%%

call_available_movements(Xi, Yi):-	write('Available cells: '),nl,
									available_movements(Xi, Yi, 1),nl.

available_movements(Xi, Yi, 1):- Xf is Xi+2, Yf is Yi+1, Xf>=1, Xf=<9, Yf>=1, Yf=<9, num_to_alpha(Xf, Xalfa),write('X: '),write(Xalfa),write(' |Y: '),write(Yf),nl, available_movements(Xi, Yi, 2).
available_movements(Xi, Yi, 1):- available_movements(Xi, Yi, 2).
available_movements(Xi, Yi, 2):- Xf is Xi+2, Yf is Yi-1, Xf>=1, Xf=<9, Yf>=1, Yf=<9, num_to_alpha(Xf, Xalfa),write('X: '),write(Xalfa),write(' |Y: '),write(Yf),nl, available_movements(Xi, Yi, 3).
available_movements(Xi, Yi, 2):- available_movements(Xi, Yi, 3).
available_movements(Xi, Yi, 3):- Xf is Xi-2, Yf is Yi+1, Xf>=1, Xf=<9, Yf>=1, Yf=<9, num_to_alpha(Xf, Xalfa),write('X: '),write(Xalfa),write(' |Y: '),write(Yf),nl, available_movements(Xi, Yi, 4).
available_movements(Xi, Yi, 3):- available_movements(Xi, Yi, 4).
available_movements(Xi, Yi, 4):- Xf is Xi-2, Yf is Yi-1, Xf>=1, Xf=<9, Yf>=1, Yf=<9, num_to_alpha(Xf, Xalfa),write('X: '),write(Xalfa),write(' |Y: '),write(Yf),nl, available_movements(Xi, Yi, 5).
available_movements(Xi, Yi, 4):- available_movements(Xi, Yi, 5).
available_movements(Xi, Yi, 5):- Xf is Xi+1, Yf is Yi+2, Xf>=1, Xf=<9, Yf>=1, Yf=<9, num_to_alpha(Xf, Xalfa),write('X: '),write(Xalfa),write(' |Y: '),write(Yf),nl, available_movements(Xi, Yi, 6).
available_movements(Xi, Yi, 5):- available_movements(Xi, Yi, 6).
available_movements(Xi, Yi, 6):- Xf is Xi+1, Yf is Yi-2, Xf>=1, Xf=<9, Yf>=1, Yf=<9, num_to_alpha(Xf, Xalfa),write('X: '),write(Xalfa),write(' |Y: '),write(Yf),nl, available_movements(Xi, Yi, 7).
available_movements(Xi, Yi, 6):- available_movements(Xi, Yi, 7).
available_movements(Xi, Yi, 7):- Xf is Xi-1, Yf is Yi+2, Xf>=1, Xf=<9, Yf>=1, Yf=<9, num_to_alpha(Xf, Xalfa),write('X: '),write(Xalfa),write(' |Y: '),write(Yf),nl, available_movements(Xi, Yi, 8).
available_movements(Xi, Yi, 7):- available_movements(Xi, Yi, 8).
available_movements(Xi, Yi, 8):- Xf is Xi-1, Yf is Yi-2, Xf>=1, Xf=<9, Yf>=1, Yf=<9, num_to_alpha(Xf, Xalfa),write('X: '),write(Xalfa),write(' |Y: '),write(Yf),nl.
available_movements(Xi, Yi, 8).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Transform numerical to alphabetical%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_to_alpha(X, Xalfa):- X1 is X+64, char_code(Xalfa, X1).

%%%%%%%%
%Inputs%
%%%%%%%%

ask_for_put(X, Y, P):-	repeat,
						write('Player '), write(P),
						write(' select a cell to put piece.'),nl,
						write('Column [A-I].'),nl,
						read_X(X),
						write('Row [1-9].'),nl,
						read_Y(Y),!.


ask_for_pick(X, Y, P):-	repeat,
						write('Player '), write(P),
						write(' select a cell to remove piece.'),nl,
						write('Column [A-I].'),nl,
						read_X(X),
						write('Row [1-9].'),nl,
						read_Y(Y),!.

%%%%%%%%%%%%%%%%%%%%%%%%%
%Check correct positions%
%%%%%%%%%%%%%%%%%%%%%%%%%

read_X(X2):- repeat,get_code(X),get_code(_), conv_col(X,X2),!.				%only accepts one valid input				
read_Y(Y2):- repeat,get_code(Y),get_code(_), conv_row(Y,Y2),!.

conv_col(X,X2):- uppercase(X), X2 is X-64.									%converts letters into numbers
conv_col(X,X2):- lowercase(X), X2 is X-96.
conv_col(X,X2):- write('That column doesnt exist, choose again.'),nl,fail.

conv_row(Y, Y2):- num(Y), Y2 is Y-48.
conv_row(Y, Y2):- write('That row doesnt exist, choose again.'),nl,fail.

uppercase(X):- X>=65, X=<73.		% accepts upper and lowercase letters
lowercase(X):- X>=97, X=<105.
num(Y):- Y>=49, Y=<57.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Outputs - board refreshing%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%Putting a piece on board%
%%%%%%%%%%%%%%%%%%%%%%%%%%

put_piece(B, P, X, Y, NB):-	refresh_put(B, P, X, Y, NB).

refresh_put([BoardH|BoardT], P, X, 9, [NboardH|BoardT]):-	refresh_put2(BoardH, P, X, NboardH).

refresh_put([BoardH|BoardT], P, X, Y, [BoardH|NboardT]):- 	Y1 is Y+1, refresh_put(BoardT, P, X, Y1, NboardT).

refresh_put2([0|BoardT], white, 1, [2|BoardT]).
refresh_put2([1|BoardT], white, 1, [3|BoardT]).
refresh_put2([0|BoardT], black, 1, [1|BoardT]).
refresh_put2([2|BoardT], black, 1, [4|BoardT]).

refresh_put2([BoardH|BoardT], P, X, [BoardH|NboardT]):- X1 is X-1, refresh_put2(BoardT, P, X1, NboardT).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Removing a piece from board%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

remove_piece(B, P, Xi, Yi, NB):- refresh_remove(B, P, Xi, Yi, NB).

refresh_remove([BoardH|BoardT], P, X, 9, [NboardH|BoardT]):-	refresh_remove2(BoardH, P, X, NboardH).

refresh_remove([BoardH|BoardT], P, X, Y, [BoardH|NboardT]):- 	Y1 is Y+1, refresh_remove(BoardT, P, X, Y1, NboardT).

refresh_remove2([2|BoardT], white, 1, [0|BoardT]).
refresh_remove2([3|BoardT], white, 1, [1|BoardT]).
refresh_remove2([1|BoardT], black, 1, [0|BoardT]).
refresh_remove2([4|BoardT], black, 1, [2|BoardT]).

refresh_remove2([BoardH|BoardT], P, X, [BoardH|NboardT]):- X1 is X-1, refresh_remove2(BoardT, P, X1, NboardT).
%%%%%%%%%%%%%
%Evaluations%
%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Check if player is puting in valid position%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%
%For the 1st move%
%%%%%%%%%%%%%%%%%%

evaluate_put(B, P, X, Y):-	get_cell(B, X, Y, Piece),
							evaluate_put_piece_player(Piece, P, 1).

%%%%%%%%%%%%%%%%%%%%%
%For all other moves%
%%%%%%%%%%%%%%%%%%%%%

evaluate_put(B, P, Xi, Yi, Xf, Yf):- 	get_cell(B, Xf, Yf, Piece),
										evaluate_put_piece_player(Piece, P, 0),
										evaluate_horse_movement(Xi, Yi, Xf, Yf).
										

evaluate_put_piece_player(Piece, Player, First):- Piece = 0.
evaluate_put_piece_player(Piece, white, First):- Piece = 1.
evaluate_put_piece_player(Piece, black, First):- 	(
														Piece = 2, First = 0;
														write('1st movement of black cant be put on white piece'),nl,fail
													). %1st movement of black cant be put on white piece

evaluate_put_piece_player(Piece, black, First):- Piece = 1, write('Black player, please put on white piece or blank cell.'), nl, fail.
evaluate_put_piece_player(Piece, black, First):- Piece = 3, write('Black player, please put on white piece or blank cell.'), nl, fail.
evaluate_put_piece_player(Piece, black, First):- Piece = 4, write('Black player, please put on white piece or blank cell.'), nl, fail.

evaluate_put_piece_player(Piece, white, First):- Piece = 2, write('White player, please put on black piece or blank cell.'), nl, fail.
evaluate_put_piece_player(Piece, white, First):- Piece = 3, write('White player, please put on black piece or blank cell.'), nl, fail.
evaluate_put_piece_player(Piece, white, First):- Piece = 4, write('White player, please put on black piece or blank cell.'), nl, fail.

evaluate_horse_movement(Xi, Yi, Xf, Yf):- X1 is Xi+2, Y1 is Yi+1, Xf=X1, Yf=Y1.
evaluate_horse_movement(Xi, Yi, Xf, Yf):- X1 is Xi+2, Y1 is Yi-1, Xf=X1, Yf=Y1.

evaluate_horse_movement(Xi, Yi, Xf, Yf):- X1 is Xi-2, Y1 is Yi+1, Xf=X1, Yf=Y1.
evaluate_horse_movement(Xi, Yi, Xf, Yf):- X1 is Xi-2, Y1 is Yi-1, Xf=X1, Yf=Y1.

evaluate_horse_movement(Xi, Yi, Xf, Yf):- X1 is Xi+1, Y1 is Yi+2, Xf=X1, Yf=Y1.
evaluate_horse_movement(Xi, Yi, Xf, Yf):- X1 is Xi+1, Y1 is Yi-2, Xf=X1, Yf=Y1.

evaluate_horse_movement(Xi, Yi, Xf, Yf):- X1 is Xi-1, Y1 is Yi+2, Xf=X1, Yf=Y1.
evaluate_horse_movement(Xi, Yi, Xf, Yf):- X1 is Xi-1, Y1 is Yi-2, Xf=X1, Yf=Y1.

evaluate_horse_movement(Xi, Yi, Xf, Yf):- write('Please choose a valid cell (chess horse movement).'),nl,fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Check if player is picking his piece%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

evaluate_pick(B, P, Xi, Yi):-	get_cell(B, Xi, Yi, Piece),
								evaluate_pick_piece_player(Piece, P).

evaluate_pick_piece_player(Piece, white):- Piece = 2.
evaluate_pick_piece_player(Piece, white):- Piece = 3.
evaluate_pick_piece_player(Piece, black):- Piece = 1.
evaluate_pick_piece_player(Piece, black):- Piece = 4.

evaluate_pick_piece_player(Piece, Player):- Piece = 0, write('Cant pick empty cell.'), nl, fail.
evaluate_pick_piece_player(Piece, black):- Piece = 2, write('Black player, please pick black piece.'), nl, fail.
evaluate_pick_piece_player(Piece, black):- Piece = 3, write('Black player, please pick black piece.'), nl, fail.
evaluate_pick_piece_player(Piece, white):- Piece = 1, write('White player, please pick white piece.'), nl, fail.
evaluate_pick_piece_player(Piece, white):- Piece = 4, write('White player, please pick white piece.'), nl, fail.

%%%%%%%%%%%%%%%%%%%
%Get cell contents%
%%%%%%%%%%%%%%%%%%%

get_cell([BoardH|BoardT], X, 9, Piece):-
										get_cell2(BoardH, X, 9, Piece).

get_cell([BoardH|BoardT], X, Y, Piece):- Y1 is Y+1,
										get_cell(BoardT, X, Y1, Piece).

get_cell2([Piece|BoardT], 1, 9, Piece).

get_cell2([BoardH|BoardT], X, 9, Piece):- X1 is X-1,
											get_cell2(BoardT, X1, 9, Piece).

%%%%%%%%%%%%%%%%%%%%%%%%
%Change turn and player%
%%%%%%%%%%%%%%%%%%%%%%%%

change_turn(Turn, NextTurn, Player, black):- Player = white, NextTurn is Turn+1.
change_turn(Turn, NextTurn, Player, white):- Player = black, NextTurn is Turn+1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Check end game conditions%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%If game is on check%
%%%%%%%%%%%%%%%%%%%%%

check_end_game(Turn, Board, Player, 2, End2):-	(
													fiveAlign(Board, white), End2 is 1;
													End2 is 0
												).

check_end_game(Turn, Board, Player, 4, End2):-	(
													fiveAlign(Board, black), End2 is 3;
													End2 is 0
												).

%%%%%%%%%%%%%%%%%%%%%%%%
%Game ends on checkmate%
%%%%%%%%%%%%%%%%%%%%%%%%

check_end_game(Turn, Board, Player, End, End2):-	Player == white,
													(
														fiveAlign(Board, Player), End2 is 2;
														End2 is End
													).

check_end_game(Turn, Board, Player, End, End2):-	Player == black,
													(
														fiveAlign(Board, Player), End2 is 4;
														End2 is End
													).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Confirm if there is a sequence of 5 pieces to end the game%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fiveAlign(Board, Player):-
							fiveInARow(9, Board, Player);
							fiveInACol(9, Board ,Player).
%%%%%%%%%%
%In a row%
%%%%%%%%%%

fiveInARow(Row, Board, Player):-	
							Row >= 0,
							Row1 is Row-1,
						(	
							validateFiveInARow(Row, Board, Player);
							fiveInARow(Row1, Board, Player)
						).

validateFiveInARow(Row, Col, Board, Acc, Player):-
						Col >= 0,
						Col1 is Col-1,
						get_cell(Board, Col, Row, Piece),
						(
							pieceIsOwnedByPlayer(Piece, Player) -> 
								Acc1 is Acc + 1; 
							Acc1 is Acc
						),
						(
							Acc1 >= 5; 
							validateFiveInARow(Row, Col1, Board, Acc1, Player)
						).

validateFiveInARow(Row, Board, Player):-
						validateFiveInARow(Row, 9, Board, 0, Player).



%%%%%%%%%%%%%
%In a column%
%%%%%%%%%%%%%

fiveInACol(Col, Board, Player):-
							Col >= 0,
							Col1 is Col-1,
						(	
							validateFiveInACol(Col, Board, Player);
							fiveInACol(Col1, Board, Player)
						).

validateFiveInACol(Col, Board, Player):-
						validateFiveInACol(9, Col, Board, 0, Player).

validateFiveInACol(Row, Col, Board, Acc, Player):-
						Row >= 0,
						Row1 is Row-1,
						get_cell(Board, Col, Row, Piece),
						(
							pieceIsOwnedByPlayer(Piece, Player)->
								Acc1 is Acc + 1;
							Acc1 is Acc
						),
						(
							Acc1 >= 5;
							validateFiveInACol(Row1, Col, Board, Acc1, Player)
						).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Check if the piece on selected cell, belongs to the current player%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pieceIsOwnedByPlayer(Piece, Player):-
	((Piece =:= 1; Piece =:= 4), Player == black);
	((Piece =:= 2; Piece =:= 3), Player == white).