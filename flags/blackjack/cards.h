
#ifndef _CARDS_H_
#define _CARDS_H_

#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

// Forward declarations of classes
class Card;
class CardCollection;
class Hand;
class Deck;

//////////////////////////////////////////////////////////////////////
// Global funtions:
//   myrand -- for random numbers
//   operator<< for printing cards and card collections
//////////////////////////////////////////////////////////////////////

int myrand(int n=0);
ostream & operator<<(ostream & os, const Card & c);
ostream & operator<<(ostream & os, const CardCollection & c);

//////////////////////////////////////////////////////////////////////
// class Card definition
//////////////////////////////////////////////////////////////////////

class Card
{
  public:
    Card();
    Card(int face, int suit);
    int Value() const;
    int Suit() const;
    int Face() const;
    bool operator<(const Card & other) const;
    ostream & Print(ostream & os) const;

  private:
    const static string m_faces[14];
    const static string m_suits[5];
    int m_face;
    int m_suit;
};

//////////////////////////////////////////////////////////////////////
// class CardCollection definition
//////////////////////////////////////////////////////////////////////

class CardCollection
{
  public:
    CardCollection(int size=0);
    Card & operator[](int index);
    int Size() const;
    CardCollection & Sort();
    ostream & Print(ostream & os) const;
  protected:
    void Add(const Card & c);
    void Remove(int index);
    Card Pop();
    void RemoveAll();
  private:
    vector<Card> m_cards;
};

//////////////////////////////////////////////////////////////////////
// class Hand definition
//////////////////////////////////////////////////////////////////////

class Hand : public CardCollection
{
  public:
    Hand();
    Hand & Receive(const Card & c);
    Hand & Discard(int index);
};

//////////////////////////////////////////////////////////////////////
// class Deck definition
//////////////////////////////////////////////////////////////////////

class Deck : public CardCollection
{
  public:
    Deck();
    Deck & Shuffle();
    Deck & NewDeck();
    Deck & Deal(Hand & h, int count=1);
};

#endif
