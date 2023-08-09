#include<iostream>
#include<math.h> 
#include <iomanip>

using namespace std;
#define eps 1.e-7

double f(double x) 
{
	return pow(x, 3) + 2*x - 11;
}

int main() {
	double a, b; 	
	int n = 0;
	double c;
	cout<<"Nhap a: " ; cin>> a;
	cout<<"Nhap b: " ; cin>> b;

	while (fabs(b-a) > eps)
	{
		c = (double)((a+b)/2);	

		if(f(c)*f(a)<0)
		{
			b=c; 
		} else {
			a=c ;
		}
		n++; 
		cout << "Vong lap " << n << ": x = " << fixed << setprecision(15) << c << endl;
	}
	cout<<"nghiem tim duoc la "<< fixed << setprecision(15)<< c <<"\n"<<"so vong lap la "<<n;
}
