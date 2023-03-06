using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using DemoExpo.Vistas;

namespace DemoExpo
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = new NavigationPage(new Menuprincipal());
        }

        protected override void OnStart()
        {
        }

        protected override void OnSleep()
        {
        }

        protected override void OnResume()
        {
        }
    }
}
