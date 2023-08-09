#include<bits/stdc++.h>
#define N 105

using namespace std;

long int n, kmax;
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

double vector_norm_row(double *temp) {
    double res = 0.0;
    for(int i = 0;i < n;i++)
        res = max(res, fabs(temp[i]));
    return res;
}

double vector_norm_col(double *temp) {
    double res = 0.0;
    for(int i = 0;i < n;i++)
        res = res + fabs(temp[i]);
    return res;
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

void row_solve_TN() {
    double temp;
    double z[N], t[N];
    for(int i = 0; i < n; i++) z[i] = x[i];
    for(int i = 0; i < n; i++) {
        temp = 0;
        for(int j = 0; j < n; j++)
            if (j != i) temp = temp + (a[i][j]/a[i][i]) * x[j];
            x[i] = b[i]/a[i][i] - temp;
        }
    for(int i = 0; i < n; i++) t[i] = z[i] - x[i];
    lamda = lamda_cal();
    kmax = int(log(epsi*(1 - lamda)/vector_norm_row(t))/log(lamda));
    cout << "Số lần lặp: " << kmax;
    for(int k = 0; k < kmax; k++) {
        for(int i = 0; i < n; i++) {
        temp = 0;
        for(int j = 0; j < n; j++)
        if (j != i) temp = temp + (a[i][j]/a[i][i]) * x[j];
        x[i] = b[i]/a[i][i] - temp;
    }
    }
    cout << fixed;
    cout << "\nNghiệm của phương trình: \n";
    for(int i = 0; i < n; i++) {
        cout << "x_" << i+1 << ": " << setw(20) << setprecision(20) << x[i] << endl;
    }
}

void C_matrix () {
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            if(j != i) c[i][j] = -a[i][j]/a[j][j];
            else c[i][j] = 0;
        }
    }
}

double s_cal() {
    double s, temp;
    C_matrix();
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
    C_matrix();
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

void col_solve_TN() {
    double temp;
    double y[N], z[N], t[N];
    for(int i = 0; i < n; i++) y[i] = a[i][i] * x[i];
    for(int i = 0; i < n; i++) z[i] = x[i];
    for(int i = 0; i < n; i++) {
        temp = 0;
        for(int j = 0; j < n; j++) {
            if (j != i) temp += (a[i][j]/a[j][j]) * y[j];
        }
        y[i] = b[i] - temp;
        x[i] = y[i]/a[i][i];
    }
    for(int i = 0; i < n; i++) t[i] = z[i] - x[i];
    s = s_cal();
    zeta = zeta_cal();
    kmax = int(log(epsi*(1 - s)*(1 - zeta)/vector_norm_col(t))/log(zeta));
    cout << "Số lần lặp: " << kmax;

    for(int k = 0; k < kmax; k++) {
        for(int i = 0; i < n; i++) {
            temp = 0;
            for(int j = 0; j < n; j++)
                if (j != i) temp += (a[i][j]/a[j][j]) * y[j];
        y[i] = b[i] - temp;
        }
    }
    for(int i = 0; i < n; i++) x[i] = y[i]/a[i][i];
    cout << fixed;
    cout << "\nNghiệm của phương trình: \n";
    for(int i = 0; i < n; i++)
        cout << "x_" << i+1 << ": " << setw(12) << setprecision(12) << x[i] << endl;
}


int main () {
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    input();
    if(row_diagonal() == 1) row_solve_TN();
    else if(col_diagonal() == 1) col_solve_TN();
    else cout << "Ma trận không chéo trội, phương pháp không hội tụ!";

    fclose(stdin);
    fclose (stdout);
    system("output.txt");
    return 0;
}
