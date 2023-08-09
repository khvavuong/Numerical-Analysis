#include <iostream>
#include <math.h>
#include <iomanip>

#define delta 1e-6
#define eps 1e-7

using namespace std;

double f( double x)
{
    double f = pow(x, 3) + 2*x - 11;
    return f;
}

double f1(double x)
{
    double dy = f(x+delta) - f(x-delta);
    double dx = 2*delta;
    double f1 = dy/dx;

    return f1; 
}

double f2(double x)
{
    double dy = f1(x+delta) - f1(x-delta);
    double dx = 2*delta;
    double f2 = dy/dx;

    return f2;
}

bool kiemtra(double a, double b)
{
	if ( (f(a)*f(b) < 0) && (f1(a)*f1(b) > 0) && (f2(a)*f2(b) > 0))
	{
		return true;
	} else {
		return false;
	}
}

double m1(double a, double b)
{
    if (fabs(f1(a)) < fabs(f1(b))) 
    {
        return fabs(f1(a));
    } else {
        return fabs(f1(b));
    }
}


int main()
{
    double a, b; 
    double x0, x, d;
    do
    {
	    cout << "Nhap a = ";
        cin >> a;
        cout << "Nhap b = ";
        cin >> b;
    } while(kiemtra(a,b) == 0);

    if (f(a)*f2(a) > 0)
    {
        d = a;
        x0 = b;
    } else {
        d = b;
        x0 = a;
    }
	
    int i = 0;

    while ( fabs(f(x0)/m1(a,b)) > eps )
    {
        x = x0 - (((d - x0) / (f(d) - f(x0)))*f(x0));
        x0 = x;
        i++;
        cout << "Lap lan " << i << ": x = " << fixed << setprecision(12) << x << endl; 
    }

    cout << "Tong so lan lap la " << i << endl;
    cout << "Nghiem tim duoc la: x = " << fixed << setprecision(12) << x;
	
}
