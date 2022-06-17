#include <cstdlib>  // for rand()
#include <ctime>    // for time()
#include <fstream>  // for file I/O
#include <iostream> // cin & cout
#include <iomanip>  // why indeed?
#include <stdlib.h> // atoi()
#include <string>   // for strings
#include "cards.h"

char * g_author = "Adam Nichols";

//function prototypes
char GetYesNo(char * prompt);
char GetFlag(char * prompt);
int PlayAGame(int);
int countHand(Hand & theHand);        //calculates the count for the hand
void AtEndOfDeck(Deck & theDeck);     //if we're at the end of the deck
                                      //get out a new deck, and shuffle them
void ShowEntireHand(Hand & theHand);  //shows all the cards in a players
                                      //hand (and the count)

// returns the number of rounds won
// takes in the number of rounds to play
int PlayAGame(int roundsToPlay) {
  int gamesPlayed=0, gamesWon=0;
  Deck theDeck;
  Hand playersHand;
  Hand dealersHand;
  
  theDeck.Shuffle();  //shuffles the deck, do it's random;

  do {
    theDeck.Deal(playersHand, 1);
    AtEndOfDeck(theDeck);
    theDeck.Deal(dealersHand, 1);
    AtEndOfDeck(theDeck);
    theDeck.Deal(playersHand, 1);
    AtEndOfDeck(theDeck);
    theDeck.Deal(dealersHand, 1);
    AtEndOfDeck(theDeck);

    cout << "Dealer is showing:\n" << dealersHand[1] << endl << endl;
	cout << "Player's hand:\n";
	ShowEntireHand(playersHand);

    while(countHand(playersHand) <= 21 && GetYesNo("Do you want another card?") == 'y')
      theDeck.Deal(playersHand, 1), AtEndOfDeck(theDeck), 
      cout << "Dealer is showing:\n" << dealersHand[1] << endl << endl,
      cout << "Player's hand:\n", ShowEntireHand(playersHand);
    if(countHand(playersHand)>21)
      cout << "Player busts!";

    if(countHand(playersHand) <= 21) {
      if (countHand(dealersHand) < 17 && countHand(playersHand) <= 21)
        cout << endl << endl << "Dealer hits:";
      else
        cout << endl << endl << "Dealer stays.";
      while(countHand(dealersHand) < 17 && countHand(playersHand) <= 21)
        theDeck.Deal(dealersHand, 1) , AtEndOfDeck(theDeck) , cout
          << endl << dealersHand[dealersHand.Size() - 1];
    }
    if(countHand(dealersHand)>21)
      cout << "\nDealer busts!";

    cout << "\n\nDealer's hand:\n";
    ShowEntireHand(dealersHand);
    if(countHand(dealersHand)>21 || (countHand(playersHand) > countHand(dealersHand) &&  countHand(playersHand) <= 21))
      cout << "You win!\n", gamesWon++;
    else
      cout << "You lose.\n";
    gamesPlayed++;
    cout << "Your record is " << gamesWon << "/" << gamesPlayed << "\n\n\n\n";
    while (dealersHand.Size() > 0)
      dealersHand.Discard(dealersHand.Size() - 1);

    while (playersHand.Size() > 0)
      playersHand.Discard(playersHand.Size() - 1);

  } while (gamesPlayed < roundsToPlay);
  return gamesWon;
}

void AtEndOfDeck(Deck & theDeck) {
  if(theDeck.Size() == 0)
    theDeck.NewDeck().Shuffle();
}

int countHand (Hand & theHand) {
  int count=0;
  int i=0, size=theHand.Size(), hitAce=0;

  while (i < theHand.Size()) {
   count += theHand[i].Value();
   i++;
  }

  while(size > 0) {
    if (theHand[size - 1].Face() == 1)
      hitAce = 1;
    size--;
  }

  if(hitAce)               //if there is an ace in the hand
    if(count<=11)        //and the count is less than 12
      count += 10;     //count the ace as 11 instead of 1

  return count;
}

void ShowEntireHand (Hand & theHand) {
  cout << theHand;
  cout << "   Count is: " << countHand(theHand) << endl << endl;
}

char GetFlag(char * prompt) {
  char ch;
  cout << prompt << " (y/n)" << endl;
  do
  {
    cin >> ch;
    ch = tolower(ch);
    if (!(ch == 'y' || ch == 'n') && !cin.eof())
      cout << "Please use 'y' or 'n'" << endl
           << prompt << " (y/n)" << endl;
  } while (!(ch == 'y' || ch == 'n') && !cin.eof());
  cout << endl;
  if (cin.eof())
    ch = 'n';
  return ch;
}

char GetYesNo(char * prompt) {
  char ch;
  cout << prompt << " (y/n)" << endl;
  do {
    cin >> ch;
    ch = tolower(ch);
    if (!(ch == 'y' || ch == 'n') && !cin.eof())
      cout << "Please use 'y' or 'n'" << endl
           << prompt << " (y/n)" << endl;
  } while (!(ch == 'y' || ch == 'n') && !cin.eof());
  cout << endl;
  if (cin.eof())
    ch = 'n';
  return ch;
}


int main() {
  int roundsToPlay = 20, roundsToWin=0, roundsWon;
  ifstream inFile("level.txt"), flagFile("flag.txt");
  ofstream outFile;
  string command, tempString;
  char flag[256];
  srand((unsigned)time(0)); 
  myrand(rand());

  if(inFile.is_open()) {
    inFile >> tempString;
    roundsToWin = atoi(tempString.c_str());
    inFile.close();
  } else {
    cerr << "Unable to open the level file for reading.\n";
  }

  if(roundsToWin > roundsToPlay) {
    cerr << "Rounds to win was above rounds to play!  roundsToWin=" << roundsToWin << "\n";
    roundsToWin = roundsToPlay;
  }  

  if(flagFile.is_open()) {
    flagFile.getline(flag, 256);
    inFile.close();
  } else {
    cerr << "Unable to open the flag file for reading!\n";
  }

  cout << "Blackjack is currently owned by: " << flag << "\n";
  cout << endl << "BlackJack! by " << g_author << endl << endl;
  roundsWon = PlayAGame(roundsToPlay);
  if(roundsWon >= roundsToWin) {
    cout << "Congratulations.  Please enter your team's flag: ";
    // this eats everything up to the \n that's in the input stream
    cin.ignore(80, '\n');
    cin.getline(flag, 256);
    command = "echo " + (string)flag + " > flag.txt";
    system(command.c_str());
    outFile.open("level.txt");
    if(outFile.is_open()) {
      outFile << ++roundsToWin << endl;
      outFile.close();
    } else {
      cerr << "Unable to open the level file for writing.\n";
    }
  }
  cout << "Goodbye!" << endl;

  return 0;
}
