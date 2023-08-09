#include<bits/stdc++.h>
#define N 105

using namespace std;

long int n, k;
double a[N][N], b[N], c[N][N], x[N], y[N];
double epsi, lamda, s, zeta;

void input() {
    cin >> n;
    for(int i = 0; i < n; i++)
        for(int j = 0; j < n; j++)
            cin >> a[i][j];
    for(int i = 0; i < n; i++)
        cin >> b[i];
    for(int i = 0; i < n; i++)
        cin >> x[i];
    cin >> epsi;
}

bool row_diagonal () {
    double temp;
    for(int i = 0; i < n; i++) {
        temp = 0;
        for(int j = 0; j < n; j++)
            if  (j != i) temp = temp + fabs(a[i][j]);
        if (abs(a[i][i]) <= temp) return false;
    }
    return true;
}

bool col_diagonal () {
    double temp;
    for(int i = 0; i < n; i++) {
        temp = 0;
        for(int j = 0; j < n; j++)
            if (j != i) temp = temp + fabs(a[j][i]);
        if(abs(a[i][i]) <= temp) return false;
    }
    return true;
}

double lamda_cal () {
    double lamdaa = 0;
    double gamma, beta, temp;
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            if (i == j) c[i][j] = 0;
            else c[i][j] = -a[i][j]/a[i][i];
        }
    }
    for(int i = 0; i < n; i++) {
        gamma = 0;
        beta = 0;
        for(int j = 1; j <= i-1; j++)
            beta = beta + fabs(c[i][j]);
        for(int j = i; j <= n; j++)
            gamma = gamma + fabs(c[i][j]);
    temp = gamma/(1 - beta);
    if(temp > lamdaa) lamdaa = temp;
    }
    return lamdaa;
}

void C_col_matrix () {
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            if(j != i) c[i][j] = -a[i][j]/a[j][j];
            else c[i][j] = 0;
        }
    }
}

double s_cal() {
    double s, temp;
    C_col_matrix();
    for(int j = 0; j < n; j++) {
        temp = 0;
        for(int i = j+1; i < n; i++)
            temp = temp + fabs(c[i][j]);
    if(temp > s) s = temp;
    }
    return s;
}

double zeta_cal () {
    double zeta;
    double temp1, temp2, temp3;
    C_col_matrix();
    for(int j = 0; j < n; j++) {
        temp1 = 0, temp2 = 0;
        for(int i = 0; i < j; i++)
            temp1 = temp1 + fabs(c[i][j]);
        for(int i = j+1; i < n; i++)
            temp2 = temp2 + fabs(c[i][j]);
        temp3 = temp1/(1 - temp2);
        if(temp3 > zeta) zeta = temp3;
    }
    return zeta;
}

void row_solve () {
    double z[N];
    double temp, norm;
    lamda = lamda_cal();
    while (true) {
        k = k + 1;
        for(int i = 0; i < n; i++) z[i] = x[i];
        for(int i = 0; i < n; i++) {
            temp = 0;
            for(int j = 0; j < n; j++)
                if (j != i) temp = temp + (a[i][j]/a[i][i]) * x[j];
            x[i] = b[i]/a[i][i] - temp;
        }
        norm = 0;
        for(int i = 0; i < n; i++)
            if(fabs(z[i] - x[i]) > norm) norm = fabs(z[i] - x[i]);

        if(lamda*norm < epsi*(1- lamda)) break;
    }
    cout << fixed;
    cout << "Nghiệm của phương trình: \n";
    for(int i = 0; i < n; i++)
        cout << setw(10) << setprecision(10) << x[i] << endl;
    cout << "Số lần lặp: " << k;
}

void col_solve() {
    double z[N];
    double norm, temp;
    s = s_cal();
    zeta = zeta_cal();
    for(int i = 0; i < n; i++)
        y[i] = x[i] * a[i][i];
    while(true) {
        k = k + 1;
        for(int i = 0; i < n; i++) z[i] = y[i];
        for(int i = 0; i < n; i++) {
            temp = 0;
            for(int j = 0; j < n; j++) {
                if (j != i) temp += (a[i][j]/a[j][j]) * y[j];
            }
        y[i] = b[i] - temp;
        }
    //Xet chuan
    norm = 0;
    for(int i = 0; i < n; i++) {
        norm += fabs(y[i] - z[i]);
    }
    if(zeta * norm < epsi * (1 - s)* (1 - zeta)) break;
    }
    for(int i = 0; i < n; i++) {
        x[i] = y[i]/a[i][i];
    }
    cout << fixed;
    cout << "Nghiệm của phương trình: \n";
    for(int i = 0; i < n; i++)
        cout << setw(10) << setprecision(10) << x[i] << endl;
    cout << "Số lần lặp: " << k;
}

int main () {
    freopen("GS4.txt", "r", stdin);
    freopen("seidel.out", "w", stdout);
    input();

    if(row_diagonal() == 1) row_solve();
    else if(col_diagonal() == 1) col_solve();
    else cout << "Ma trận không chéo trội, phương pháp không hội tụ!";

    fclose(stdin);
    fclose (stdout);
    system("seidel.out");

    return 0;
}
