using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using PerfumeSalon.Classes;

namespace PerfumeSalon.Pages
{
    /// <summary>
    /// Логика взаимодействия для AromaInfo.xaml
    /// </summary>
    /// 
    /*
     <Button.Template>
                                <ControlTemplate>
                                    <Image x:Name="imgFavorite" Source="/Resources/Favorite.png" Height="70" Width="70"/>
                                </ControlTemplate>
                            </Button.Template>
     
    */
    public partial class AromaInfo : Page
    {
        public static bool markedAsFavorite = false;
        public int id;
        public List<Product> products = new List<Product>();
        public List<NoteInAroma> notes = new List<NoteInAroma>();
        public List<Volume> volumes = new List<Volume>();
        public List<string> aromasGroups = new List<string>();
        public List<string> favoriteAromas = new List<string>();
        public static string description;
        public static int selectedVolume = 0;
        public AromaInfo(int id)
        {
            InitializeComponent();
            this.id = id;
        }

        private void btnFavorite_Click(object sender, RoutedEventArgs e)
        {
            if (UserId.userId == 0)
            {
                FrameClass.BodyFrame.Navigate(new Pages.LoginPage());
            }
            else
            {
                markedAsFavorite = !markedAsFavorite;
                if (markedAsFavorite)
                {
                    Uri uri = new Uri("/Resources/FavoriteMarked.png", UriKind.Relative);
                    BitmapImage bitmap = new BitmapImage(uri);
                    Image image = new Image();
                    image.Source = bitmap;
                    btnFavorite.Content = image;
                }
                else
                {
                    Uri uri = new Uri("/Resources/Favorite.png", UriKind.Relative);
                    BitmapImage bitmap = new BitmapImage(uri);
                    Image image = new Image();
                    image.Source = bitmap;
                    btnFavorite.Content = image;
                }
                dbProduct.ChangeMark(UserId.userId, products[0].Aroma);
            }
        }
        public void LoadImageToButton()
        {
            Uri uri = new Uri("/Resources/Favorite.png", UriKind.Relative);
            BitmapImage bitmap = new BitmapImage(uri);
            Image image = new Image();
            image.Source = bitmap;
            btnFavorite.Content = image;
        }
        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            LoadImageToButton();

            btnVolume5.Visibility = Visibility.Collapsed;
            btnVolume15.Visibility = Visibility.Collapsed;
            btnVolume30.Visibility = Visibility.Collapsed;
            btnVolume50.Visibility = Visibility.Collapsed;
            btnVolume100.Visibility = Visibility.Collapsed;

            products = dbProduct.LoadProductByAromaId(id);
            tbAroma.Text = products[0].Aroma;
            tbProductType.Text = products[0].Type;
            tbCategory.Text = products[0].Category;
            description = dbProduct.GetDescriptionByAromaId(id);
            int minVolume = products[0].Volume;
            selectedVolume = minVolume;
            aromasGroups = dbAromaGroup.GetAromaGroupByAromaId(id);
            volumes = dbProduct.LoadVolumeByAromaId(id);
            notes = dbProduct.LoadNotesByAromaId(id);
            foreach (string group in aromasGroups)
            {
                tbAromasGroups.Text += $"{group}, ";
            }
            foreach (Volume volume in volumes)
            {
                switch (volume.Value)
                {
                    case 5: btnVolume5.Visibility = Visibility.Visible; break;
                    case 15: btnVolume15.Visibility = Visibility.Visible; break;
                    case 30: btnVolume30.Visibility = Visibility.Visible; break;
                    case 50: btnVolume50.Visibility = Visibility.Visible; break;
                    case 100: btnVolume100.Visibility = Visibility.Visible; break;
                }
            }
            foreach (NoteInAroma note in notes)
            {
                switch (note.NoteClass)
                {
                    case 1:
                        tbTopNotes.Text += $"{note.Note}, ";
                        break;
                    case 2:
                        tbMidNotes.Text += $"{note.Note}, ";
                        break;
                    case 3:
                        tbBaseNotes.Text += $"{note.Note}, ";
                        break;
                }
            }
            tbAromasGroups.Text =  tbAromasGroups.Text.Remove(tbAromasGroups.Text.Length - 2);
            tbTopNotes.Text = tbTopNotes.Text.Remove(tbTopNotes.Text.Length - 2);
            tbMidNotes.Text = tbMidNotes.Text.Remove(tbMidNotes.Text.Length - 2);
            tbBaseNotes.Text = tbBaseNotes.Text.Remove(tbBaseNotes.Text.Length - 2);
            if (description.Length > 1)
            {
                tbDescription.Visibility = Visibility.Visible;
                tbDescription.Text = description;
            }

            if (UserId.userId != 0)
            {
                favoriteAromas = dbProduct.GetAromaFromFavorites(UserId.userId);
                if (favoriteAromas.Count > 0)
                {
                    foreach (string a in favoriteAromas)
                    {
                        if (a == tbAroma.Text)
                        {
                            Uri uri = new Uri("/Resources/FavoriteMarked.png", UriKind.Relative);
                            BitmapImage bitmap = new BitmapImage(uri);
                            Image image = new Image();
                            image.Source = bitmap;
                            btnFavorite.Content = image;
                            markedAsFavorite = true;
                        }
                    }
                }
            }

            SelectedVolume(minVolume);
        }

        private void btnVolume5_Click(object sender, RoutedEventArgs e)
        {
            SelectedVolume(5);
        }

        private void btnVolume15_Click(object sender, RoutedEventArgs e)
        {
            SelectedVolume(15);
        }

        private void btnVolume30_Click(object sender, RoutedEventArgs e)
        {
            SelectedVolume(30);
        }

        private void btnVolume50_Click(object sender, RoutedEventArgs e)
        {
            SelectedVolume(50);
        }

        private void btnVolume100_Click(object sender, RoutedEventArgs e)
        {
            SelectedVolume(100);
        }

        private void SelectedVolume(int vol)
        {
            //#FF5F5F5F
            //Brush grey = new Brush();
            btnVolume5.Foreground = Brushes.LightGray;
            btnVolume5.BorderBrush = Brushes.LightGray;
            btnVolume15.Foreground = Brushes.LightGray;
            btnVolume15.BorderBrush = Brushes.LightGray;
            btnVolume30.Foreground = Brushes.LightGray;
            btnVolume30.BorderBrush = Brushes.LightGray;
            btnVolume50.Foreground = Brushes.LightGray;
            btnVolume50.BorderBrush = Brushes.LightGray;
            btnVolume100.Foreground = Brushes.LightGray;
            btnVolume100.BorderBrush = Brushes.LightGray;
            Uri uri;
            BitmapImage bitmap;
            switch (vol)
            {
                case 5:
                    selectedVolume = 5;
                    uri = new Uri("/Resources/Volumes/5.jpg", UriKind.Relative);
                    bitmap = new BitmapImage(uri);
                    imgAromaPic.Source = bitmap;
                    btnVolume5.Foreground = Brushes.Black;
                    btnVolume5.BorderBrush = Brushes.Black;
                    tbPrice.Text = dbProduct.GetPriceByVolume(id,5).ToString();
                    break;
                case 15:
                    selectedVolume = 15;
                    uri = new Uri("/Resources/Volumes/15.jpg", UriKind.Relative);
                    bitmap = new BitmapImage(uri);
                    imgAromaPic.Source = bitmap;
                    btnVolume15.Foreground = Brushes.Black;
                    btnVolume15.BorderBrush = Brushes.Black;
                    tbPrice.Text = dbProduct.GetPriceByVolume(id, 15).ToString();
                    break;
                case 30:
                    selectedVolume = 30;
                    uri = new Uri("/Resources/Volumes/30.jpg", UriKind.Relative);
                    bitmap = new BitmapImage(uri);
                    imgAromaPic.Source = bitmap;
                    btnVolume30.Foreground = Brushes.Black;
                    btnVolume30.BorderBrush = Brushes.Black;
                    tbPrice.Text = dbProduct.GetPriceByVolume(id, 30).ToString();
                    break;
                case 50:
                    selectedVolume = 50;
                    uri = new Uri("/Resources/Volumes/50.jpg", UriKind.Relative);
                    bitmap = new BitmapImage(uri);
                    imgAromaPic.Source = bitmap;
                    btnVolume50.Foreground = Brushes.Black;
                    btnVolume50.BorderBrush = Brushes.Black;
                    tbPrice.Text = dbProduct.GetPriceByVolume(id, 50).ToString();
                    break;
                case 100:
                    selectedVolume = 100;
                    uri = new Uri("/Resources/Volumes/100.jpg", UriKind.Relative);
                    bitmap = new BitmapImage(uri);
                    imgAromaPic.Source = bitmap;
                    btnVolume100.Foreground = Brushes.Black;
                    btnVolume100.BorderBrush = Brushes.Black;
                    tbPrice.Text = dbProduct.GetPriceByVolume(id, 100).ToString();
                    break;
            }
        }

        private void btnOrder_Click(object sender, RoutedEventArgs e)
        {
            if (UserId.userId == 0)
            {
                FrameClass.BodyFrame.Navigate(new Pages.LoginPage());
            }
            else
            {
                int productId = 0;
                foreach (Product p in products)
                {
                    if(p.Volume == selectedVolume) { productId = p.Id; }
                }
                dbBasket.AddProductToBasket(UserId.userId, productId);
            }
        }
    }
}
