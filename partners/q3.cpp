#include <iostream>
using namespace std;

int DM[5050];
// fun1 corresponds to the MIPS subroutine
void fun1(int t0, int &t1)
{
  int t2 = 40;
  int t3 = (t0 < t2) ? 1 : 0;
  if (t3 != 0)
  {
    t1 = 0;
  }
  else
  {
    t1 = t0 - t2;
  }
}

// fun2 corresponds to the second subroutine
void fun2(int t0, int t1, int t2, int &t3)
{
  int t4;
  t3 = t0 * t1;
  t4 = t2 * t1;
  t3 = t3 + t4;
}

int main()
{
  // data at addresses
  DM[5000] = 12;
  DM[5004] = 15;
  DM[5008] = 8;

  int t0 = DM[5000];
  int t1 = DM[5004];
  int t2 = DM[5008];
  // sum = DM[5000] + DM[5004] + DM[5008]
  int t3 = t0 + t1 + t2;
  DM[5000] = t3;

  // load again after storing
  t0 = DM[5000];
  // modifies t1 depending on t0
  fun1(t0, t1);
  t2 = t1;
  t1 = 10;
  // t3 = t0t1 + t2t1
  fun2(t0, t1, t2, t3);

  DM[5040] = t3; // store result
  t1 = 2;        // label Done
  return 0;
}