import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smartshop/common/widget/routes/routes.dart';
import 'package:smartshop/features/authentication/screen/forget_password/forget_password.dart';
import 'package:smartshop/features/authentication/screen/login/login.dart';
import 'package:smartshop/features/authentication/screen/onboarding/onboarding.dart';
import 'package:smartshop/features/authentication/screen/signup/signup.dart';
import 'package:smartshop/features/personailzation/screens/Profile/profile.dart';
import 'package:smartshop/features/personailzation/screens/Setting/Setting.dart';
import 'package:smartshop/features/personailzation/screens/address/address.dart';
import 'package:smartshop/features/shop/screens/cart/cart.dart';
import 'package:smartshop/features/shop/screens/checkout/checkout.dart';
import 'package:smartshop/features/shop/screens/home/home.dart';
import 'package:smartshop/features/shop/screens/order/order.dart';
import 'package:smartshop/features/shop/screens/store/store.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    // GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingScreen()),
    // GetPage(
    //     name: TRoutes.productReviews, page: () => const ProductReviewScreen(product: Pro,)),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupPage()),
    // GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginPage()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPageScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
    // Add more GetPage entries as needed
  ];
}
