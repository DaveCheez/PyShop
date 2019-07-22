import django.urls

assert isinstance(django.urls.path, object)
app_name: str = 'core'

from .views import (
    ItemDetailView,
    CheckoutView,
    HomeView,
    OrderSummaryView,
    add_to_cart,
    remove_from_cart,
    remove_single_item_from_cart,
    PaymentView,
    AddCouponView,
    RequestRefundView
)

urlpatterns = [
    django.urls.path('', HomeView.as_view( ), name='home'),
    django.urls.path('checkout/', CheckoutView.as_view( ), name='checkout'),
    django.urls.path('order-summary/', OrderSummaryView.as_view( ), name='order-summary'),
    django.urls.path('product/<slug>/', ItemDetailView.as_view( ), name='product'),
    django.urls.path('add-to-cart/<slug>/', add_to_cart, name='add-to-cart'),
    django.urls.path('add-coupon/', AddCouponView.as_view( ), name='add-coupon'),
    django.urls.path('remove-from-cart/<slug>/', remove_from_cart, name='remove-from-cart'),
    django.urls.path('remove-item-from-cart/<slug>/', remove_single_item_from_cart, name='remove-single-item-from-cart'),
    django.urls.path('payment/<payment_option>/', PaymentView.as_view( ), name='payment'),
    django.urls.path('request-refund/', RequestRefundView.as_view( ), name='request-refund')
]
