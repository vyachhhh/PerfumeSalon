using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using GalaSoft.MvvmLight.Command;

namespace PerfumeSalon.Classes
{
    public class CmdDelete
    { 
        public ICommand deleteProduct
        {
            get
            {
                return new RelayCommand<object>(DeleteProduct);
            }
        }
        public void DeleteProduct(object parameter)
        {
            var productId = Convert.ToInt32(parameter);
            dbBasket.DeleteProductFromBasket(UserId.userId, productId);
            Pages.BasketPage.products = dbBasket.GetProductFromBasket(UserId.userId);
            FrameClass.BodyFrame.Navigate(new Pages.BasketPage());
            //Pages.BasketPage.UpdateProducts();
        }
    }
}
