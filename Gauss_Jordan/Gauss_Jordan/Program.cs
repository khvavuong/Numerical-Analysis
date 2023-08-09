using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GiaiHeKhuGauss
{
    class Gauss
    {
        int n;
        double[,] a;
        double[] x;
        public void Nhap()
        {
            Console.Write("So luong phuong trinh cua he: ");
            n = int.Parse(Console.ReadLine());
            a = new double[n, n + 1];
            x = new double[n];
            Console.WriteLine("Nhap cac phan tu theo thu tu dong: ");
            for (int i = 0; i < n; i++)
            {
                Console.Write("Dong thu " + (i + 1) + " : ");
                //nhap cac phan tu cach nhau bang phim Tab
                string[] tmp = Console.ReadLine().Split('\t');
                for (int j = 0; j <= n; j++)
                {
                    a[i, j] = double.Parse(tmp[j]);
                }
            }
        }
        public void InHe()
        {
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j <= n; j++)
                    Console.Write("{0,-10}", a[i, j]);
                Console.WriteLine();
            }
        }
        public void SapThuTu()
        {
            //sap xep thu tu cac phuong trinh
            for (int i = 0; i < n - 1; i++)
                for (int k = i + 1; k < n; k++)
                    if (a[i, i] < a[k, i])
                        for (int j = 0; j <= n; j++)
                        {
                            double t = a[i, j];
                            a[i, j] = a[k, j];
                            a[k, j] = t;
                        }
        }
        public void KhuGauss()
        {
            //muc dich sap thu tu de tim ma tran bac thang cho de
            //tim ma tran bac thang la phep khu gauss
            for (int i = 0; i < n - 1; i++)
                for (int k = i + 1; k < n; k++)
                {
                    double t = a[k, i] / a[i, i];
                    for (int j = 0; j <= n; j++)
                        a[k, j] = a[k, j] - t * a[i, j];
                }
        }
        public void GiaiHe()
        {
            for (int i = n - 1; i >= 0; i--)
            {
                x[i] = a[i, n];
                for (int j = 0; j < n; j++)
                    if (i != j)
                        x[i] = x[i] - a[i, j] * x[j];
                x[i] = x[i] / a[i, i];
            }
            for (int i = 0; i < n; i++)
                Console.WriteLine(x[i]);
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine("Giải hệ phương trình tuyến tính bằng phép khử Gauss");
            Gauss gauss = new Gauss();
            gauss.Nhap();
            Console.WriteLine("Hệ phương trình vừa nhập: ");
            gauss.InHe();
            Console.WriteLine("Sắp thứ tự hệ: ");
            gauss.SapThuTu();
            gauss.InHe();
            Console.WriteLine("Hệ sau khi khử Gauss: ");
            gauss.KhuGauss();
            gauss.InHe();
            Console.WriteLine("Kết quả tìm nghiệm của hệ: ");
            gauss.GiaiHe();

            Console.ReadLine();
        }
    }
}