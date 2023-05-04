
is_friend(X,Y):-
    friend(X,Y);
    friend(Y,X).
%!  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

friendList(Person, List) :-
    friendList(Person, [], List),
    chacker(_, List),
    !.

friendList(Person, Coun, List) :-
    friend(Person, Friend),
    \+ chacker(Friend, Coun),  % ensure that the same friend is not added twice
    friendList(Person, [Friend | Coun], List).

friendList(_, List, List).

chacker(X, [X|_]).
chacker(X, [_|Tail]) :- chacker(X, Tail).

%!  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

friendListCount(Person, Result) :-
    friendListCount(Person, [],0, Result).

friendListCount(Person, Coun,No, Result) :-
    friend(Person, Friend),
    \+ chacker(Friend, Coun),  % ensure that the same friend is not added twice
    NewNo is No+1,
    friendListCount(Person, [Friend | Coun],NewNo, Result).

friendListCount(_, _,NewNO,NewNO).


% If a person has no friends, it returns zero
friendListCount(Person, 0) :-
    \+ friend(Person, _).


% ! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



peopleYouMayKnow(Person, Friend) :-
    friend(Person, MutualFriend),
    %finding the person that is a friend of the person's friend
    friend(MutualFriend, Friend),
    \+ friend(Person, Friend), %Checks if person and friend are not already friends
    Friend \= Person. %Makes sure that the friend is not the same person

%!  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


peopleYouMayKnowList(Person,List) :-
     peopleYouMayKnowList(Person,[],List).

peopleYouMayKnowList(Person,Coun,List) :-
    friend(Person, MutualFriend),
    %finding the person that is a friend of the person's friend
    friend(MutualFriend, Friend),
    %Checks if person and friend are not already friends
    Friend \= Person,
    \+ chacker(Friend, Coun),  % ensure that the same friend is not added twice    %Adds friend to the list of potential friends
    peopleYouMayKnowList(Person,[Friend|Coun],List).

peopleYouMayKnowList(_,Coun,Coun).
% !
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indirect_friend(Name, Friend) :-
    friend(Name, Friend).
indirect_friend(Name, Friend) :-
    friend(Name, Intermediate),
    indirect_friend(Intermediate, Friend),
    \+ friend(Name, Friend).

% Define the predicate to find possible friends without direct mutual friends
peopleYouMayKnow_indirect(Name, Friend) :-
    indirect_friend(Name, Friend),
    \+ friend(Name, Friend),
     Name \= Friend.

