from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import *

# Router cho ViewSets
router = DefaultRouter()
router.register('customers', CustomerViewSet, basename='customer')
router.register('staff', StaffViewSet, basename='staff')
router.register('vehicles', VehicleViewSet, basename='vehicle')
router.register('vehicle-types', VehicleTypeViewSet, basename='vehicle-type')
router.register('stations', StationViewSet, basename='station')
router.register('pricings', PricingViewSet, basename='pricing')
router.register('orders', OrderViewSet, basename='order')
router.register('checklist-items', ChecklistItemViewSet, basename='checklist-item')
router.register('order-checklists', OrderChecklistViewSet, basename='order-checklist')
router.register('payments', PaymentViewSet, basename='payment')
router.register('ratings', RatingViewSet, basename='rating')

urlpatterns = [
    # ========================================
    # UNIFIED LOGIN - API ĐĂNG NHẬP THỐNG NHẤT
    # ========================================
    path('login/', unified_login, name='unified-login'),
    path('register/', customer_register, name='customer-register'),
    
    # ========================================
    # OTP MANAGEMENT
    # ========================================
    path('auth/request-otp/', customer_request_otp, name='request-otp'),
    
    # ========================================
    # AUTHENTICATION UTILITIES
    # ========================================
    path('auth/logout/', user_logout, name='logout'),
    path('auth/me/', current_user, name='current-user'),
    
    # ViewSet routes
    path('', include(router.urls)),
]