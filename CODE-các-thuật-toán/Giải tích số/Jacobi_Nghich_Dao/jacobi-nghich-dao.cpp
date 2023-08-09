#include <iostream>
#include <math.h>
#include <fstream>
#include <iomanip>
using namespace std;

double chuanvc(double a[][10], int m){			//chuan vo cung
	double max = 0;
	for(int i = 0; i < m; i++){
		double sum = 0;
		for(int j = 0; j < m; j++)
			if(j != i) sum += fabs(a[i][j]);
		if(sum > max) max = sum;
	}
	return max;
}

double chuan1(double a[][10], int m){
	double max = 0;
	for(int j = 0; j < m; j++){
		double sum = 0;
		for(int i = 0; i < m; i++)
			if(i != j) sum += fabs(a[i][j]);
		if(sum > max) max = sum;
	}
	return max;
}

//B = I - TA
void ita(double I[][10], double T[][10], double A[][10], double B[][10], int m){
	for(int l = 0; l < m; l++) {
    	for(int j = 0; j < m; j++) {
        	double sum = 0;
        	for(int k = 0; k < m; k++)
        		sum += T[l][k] * A[k][j];
        	B[l][j] = I[l][j] - sum;
    	}
	}
}

//X = B*X0 + T
void bxd(double B[][10], double x0[][10], double T[][10],double x[][10], int m){
	for(int i = 0; i < m; i++) {
    	for(int j = 0; j < m; j++) {
        	double sum = 0;
        	x[i][j] = 0;
        	for(int k = 0; k < m; k++)
        		sum += B[i][k] * x0[k][j];
        	x[i][j] = sum + T[i][j];
    	}
	}
}

// ||X1 - X0||
double chuanhang(double x[][10], double x0[][10], int m){
	double max = 0;
	for(int i = 0; i < m; i++){
		double sum = 0;
		for(int j = 0; j < m; j++)
			sum += fabs(x[i][j] - x0[i][j]);
		if(sum > max) max = sum;}
	return max;
}

double chuancot(double x[][10], double x0[][10], int m){
	double max = 0;
	for(int i = 0; i < m; i++){
		double sum = 0;
		for(int j = 0; j < m; j++)
			sum += fabs(x[j][i] - x0[j][i]);
		if(sum > max) max = sum;}
	return max;
}

double max(double A[][10], int m){
	double max = 0;
	for(int i = 0; i < m; i++)
		if(fabs(A[i][i]) >= max) max = fabs(A[i][i]);
	return max;
}

double min(double A[][10], int m){
	double min = 0;
	for(int i = 0; i < m; i++)
		if(fabs(A[i][i]) >= min) min = fabs(A[i][i]);
	return min;
}


int main() {
	double A[10][10];
	int k, m, n, y;
	fstream file;
	string line;
	file.open("MT1.txt"); 
	for(int i = 0; getline(file, line); i++) {
		string e = "";
		k = 0;
		int l = 0;
		for(int j = 0; j < line.length(); ++j) {
			if(line[j] != ' ')
				e += line[j];
			if(line[j] == ' ' || j == line.length() - 1) {
				if(i == 0) m = n = atof(e.c_str());
				if(i > 0){
					A[i - 1][k] = atof(e.c_str());
					k++;}
				e = "";
			}
		}
	}
	cout << "Ma tran A" << endl;
	for(int i = 0; i < m; i++){
		for(int j = 0; j < m; j++)
			cout << setw(15) << right << A[i][j];
		cout << endl;}
	double E[10][10];										//Ma tran don vi I
	for(int i = 0; i < m; i++){
		for(int j = 0; j < m; j++)
			E[i][j] = 0;
		E[i][i] = 1;
	}
//Kiem tra tinh cheo troi
	k = 0;
	for(int i = 0; i < m; i++){
		double s = 0;
		for(int j = 0; j < m; j++)
			if(j != i) s += fabs(A[i][j]);
		if(fabs(A[i][i]) > s) k++;
	}
	if(k == m) {
		cout << "Ma tran cheo troi hang" << endl;
		y = 0;
	}
	else {
		k = 0;
		for(int i = 0; i < m; i++){
			double s = 0;
			for(int j = 0; j < m; j++)
				if(j != i) s += fabs(A[j][i]);
			if(fabs(A[i][i]) > s) k++;
		}
		if(k == m) {
			cout << "Ma tran cheo troi cot" << endl;
			y = 1;
		}
		else {
			cout << "Ma tran khong cheo troi" << endl;
			return 0;
		}
	}
	double eps;
	cout << "Sai so = ";
	cin >> eps;
	double x0[10][10];
	for(int i = 0; i < m; i++)
		for(int j = 0; j < m; j++) x0[i][j] = 0;
	
	double T[10][10];
	for(int i = 0; i < m; i++){
		for(int j = 0; j < m; j++)
			T[i][j] = 0;
		T[i][i] = 1/A[i][i];
	}
//Cheo troi hang
	if(y == 0){
		double B[10][10];
//B = I - T*A                // chuan vo cung la chuan hang
		ita(E, T, A, B, m);
		double q = chuanvc(B, m);
		double e0 = (eps*(1 - q))/q;
		double x[10][10];
		int z = 0;
		cout <<"He so co q="<< q << endl;
//Lap X = B*X0 + T
		do{
			bxd(B, x0, T, x, m);
			q = chuanhang(x, x0, m);
			for(int i = 0; i < m; i++)
				for(int j = 0; j < m; j++)
				x0[i][j] = x[i][j];
			z++;
			cout << setfill('_');
			cout << setw(50) << "_" << endl;
			cout << setfill(' ');
			cout << "Lan lap thu " << z << endl;
			for(int i = 0; i < m; i++){
				for(int j = 0; j < m; j++)
					cout << setw(15) << right << x[i][j];
				cout << endl;}
		}
		while(q > e0);
		cout << endl << "Thuc hien lap  " << z << " lan" << endl;
	}
//Cheo troi cot
	if(y == 1){
		double B1[10][10], B[10][10], p[6];
//B1 = I - A*T                      // chuan1 la chuan cot
		ita(E, A, T, B1, m);
		double q = chuan1(B1, m);
		double e0 = (eps*(1-q)*min(A, m))/(q*max(A, m));
		double x[10][10];
		int z = 0;
		cout <<"He so co q="<< q << endl;
		
//B = I - T*A
		ita(E, T, A, B, m);
//Lap X = B*X0 + T
		do{
			bxd(B, x0, T, x, m);
			q = chuancot(x, x0, m);
			for(int i = 0; i < m; i++)
				for(int j = 0; j < m; j++)
				x0[i][j] = x[i][j];
			z++;
			cout << setfill('_');
			cout << setw(50) << "_" << endl;
			cout << setfill(' ');
			cout << "Lan lap thu " << z << endl;
			for(int i = 0; i < m; i++){
				for(int j = 0; j < m; j++)
					cout << setw(15) << right << x[i][j];
				cout << endl;}
		}
		while(q > e0);
		cout << endl << "Thuc hien lap " << z << " lan" << endl;
	}
 	return 0;
}

