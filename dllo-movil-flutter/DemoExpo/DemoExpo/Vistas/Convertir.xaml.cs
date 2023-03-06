using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace DemoExpo.Vistas
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class Convertir : ContentPage
    {
        double Tierra;
        double Marte;

        public Convertir()
        {
            InitializeComponent();
        }

        private void Calcular()
        {
            Tierra= Convert.ToDouble( txttierra.Text);
            Marte = (Tierra/9.81)*3.711;
            lblresultado.Text = Marte.ToString("0.##") + " kg";
        }

        private void Validar() 
        {
            if (!string.IsNullOrEmpty(txttierra.Text))
            {
                Calcular();
            }
            else 
            {
                DisplayAlert("Error", "Ingrese una cantidad", "OK");
            }
        }

        private void btnvolver_Clicked(object sender, EventArgs e)
        {
            Navigation.PopAsync();
        }

        private void btncalcular_Clicked(object sender, EventArgs e)
        {
            Validar();
        }
    }
}