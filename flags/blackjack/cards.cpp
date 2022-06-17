/*
 * File:        cards.cpp
 * Author:      Todd A. Whittaker
 * Description: This file implements a set of operations on cards,
 *   decks, and hands.
 */

#include "cards.h"

//////////////////////////////////////////////////////////////////////
// Global funtions:
//   myrand -- for random numbers
//   operator<< for printing cards and card collections
//////////////////////////////////////////////////////////////////////

int myrand(int n)
{
  static int seed = 0;
  if (n != 0)
    seed = n;
  seed = (1299827*seed + 57) & (~(1<<31));
  return seed;
}

ostream & operator<<(ostream & os, const Card & c)
{
  return c.Print(os);
}

ostream & operator<<(ostream & os, const CardCollection & c)
{
  return c.Print(os);
}

//////////////////////////////////////////////////////////////////////
// class Card implementation
//////////////////////////////////////////////////////////////////////

const string Card::m_faces[14] = {
  "None", "A", "2", "3", "4", "5", "6",
  "7", "8", "9", "10", "J", "Q", "K"
};

const string Card::m_suits[5] = {
  "None", "Diamonds", "Hearts", "Clubs", "Spades"
};


Card::Card() : m_face(0), m_suit(0)
{
}

Card::Card(int face, int suit) : m_face(face), m_suit(suit)
{
}

int Card::Value() const
{
  return m_face > 10 ? 10 : m_face;
}

int Card::Face() const
{
  return m_face;
}

int Card::Suit() const
{
  return m_suit;
}

ostream & Card::Print(ostream & os) const
{
  string s("   ");
  s += m_faces[m_face];
  s += " of ";
  s += m_suits[m_suit];

  return os << s.c_str();
}

bool Card::operator<(const Card & other) const
{
  if (m_suit < other.m_suit)
    return true;
  else if (m_suit == other.m_suit && m_face < other.m_face)
    return true;
  return false;
}

//////////////////////////////////////////////////////////////////////
// class CardCollection implementation
//////////////////////////////////////////////////////////////////////

CardCollection::CardCollection(int size) : m_cards(size)
{
}

Card & CardCollection::operator[](int index)
{
  return m_cards[index];
}

void CardCollection::Add(const Card & c)
{
  m_cards.push_back(c);
}

void CardCollection::Remove(int index)
{
  vector<Card>::iterator i;
  i = m_cards.begin() + index;
  m_cards.erase(i);
}

void CardCollection::RemoveAll()
{
  m_cards.erase(m_cards.begin(), m_cards.end());
}

Card CardCollection::Pop()
{
  Card c(m_cards.back());
  m_cards.pop_back();
  return c;
}

int CardCollection::Size() const
{
  return m_cards.size();
}

ostream & CardCollection::Print(ostream & os) const
{
  int width = os.width();
  for (int i=0; i<Size(); ++i)
    cout << setw(width) << m_cards[i] << endl;
  return os;
}

CardCollection & CardCollection::Sort()
{
  sort(m_cards.begin(), m_cards.end());
  return *this;
}

//////////////////////////////////////////////////////////////////////
// class Hand implementation
//////////////////////////////////////////////////////////////////////

Hand::Hand() : CardCollection(0)
{
}

Hand & Hand::Receive(const Card & c)
{
  Add(c);
  return *this;
}

Hand & Hand::Discard(int index)
{
  Remove(index);
  return *this;
}

//////////////////////////////////////////////////////////////////////
// class Deck implementation
//////////////////////////////////////////////////////////////////////

Deck::Deck() : CardCollection(52)
{
  NewDeck();
}

Deck & Deck::Shuffle()
{
  int index;
  Card temp;
  for (int i=0; i<Size(); ++i)
  {
    index = myrand() % Size();
    temp = (*this)[i];
    (*this)[i] = (*this)[index];
    (*this)[index] = temp;
  }
  return *this;
}

Deck & Deck::NewDeck()
{
  RemoveAll();
  for (int j = 1; j <= 4; ++j)
    for (int i = 1; i <= 13; ++i)
      Add(Card(i,j));
  return *this;
}

Deck & Deck::Deal(Hand & h, int count)
{
  for (int i=0; i<count; ++i)
    h.Receive(Pop());
  return *this;
}
