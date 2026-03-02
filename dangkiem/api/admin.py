from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from .models import *

# ========================================
# EXTEND USER ADMIN
# ========================================

class CustomerInline(admin.StackedInline):
    model = Customer
    can_delete = False
    verbose_name_plural = 'Customer Profile'
    fk_name = 'user'


class StaffInline(admin.StackedInline):
    model = Staff
    can_delete = False
    verbose_name_plural = 'Staff Profile'
    fk_name = 'user'


class CustomUserAdmin(BaseUserAdmin):
    """Extend Django User Admin"""
    inlines = []
    
    def get_inline_instances(self, request, obj=None):
        if not obj:
            return []
        
        # Hiển thị inline phù hợp
        inlines = []
        if hasattr(obj, 'customer_profile'):
            inlines.append(CustomerInline(self.model, self.admin_site))
        if hasattr(obj, 'staff_profile'):
            inlines.append(StaffInline(self.model, self.admin_site))
        
        return inlines
    
    list_display = ['username', 'email', 'first_name', 'last_name', 'get_user_type', 'is_staff', 'is_superuser']
    list_filter = ['is_staff', 'is_superuser', 'is_active', 'groups']
    
    def get_user_type(self, obj):
        if obj.is_superuser:
            return '🔴 Admin'
        elif hasattr(obj, 'staff_profile'):
            return '🟡 Staff'
        elif hasattr(obj, 'customer_profile'):
            return '🟢 Customer'
        return '⚪ Unknown'
    get_user_type.short_description = 'User Type'


# Unregister default User admin và register custom
admin.site.unregister(User)
admin.site.register(User, CustomUserAdmin)


# ========================================
# CUSTOMER
# ========================================

@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ['id', 'full_name', 'phone', 'user', 'phone_verified', 'total_orders', 'loyalty_points', 'created_at']
    list_filter = ['phone_verified', 'email_verified', 'membership_tier', 'created_at']
    search_fields = ['full_name', 'phone', 'user__username', 'user__email']
    readonly_fields = ['created_at', 'updated_at', 'total_orders', 'completed_orders', 'total_spent', 'loyalty_points']
    
    fieldsets = (
        ('User Account', {
            'fields': ('user',)
        }),
        ('Thông tin cá nhân', {
            'fields': ('full_name', 'phone', 'avatar_url', 'date_of_birth', 'gender')
        }),
        ('Địa chỉ', {
            'fields': ('address', 'city', 'district', 'ward')
        }),
        ('Social Login', {
            'fields': ('google_id', 'facebook_id', 'apple_id')
        }),
        ('Verification', {
            'fields': ('phone_verified', 'email_verified')
        }),
        ('Statistics', {
            'fields': ('total_orders', 'completed_orders', 'total_spent', 'loyalty_points', 'membership_tier')
        }),
        ('Settings', {
            'fields': ('preferred_language', 'timezone')
        }),
        ('System', {
            'fields': ('created_at', 'updated_at')
        }),
    )


# ========================================
# STAFF
# ========================================

@admin.register(Role)
class RoleAdmin(admin.ModelAdmin):
    list_display = ['id', 'code', 'name', 'level', 'status']
    list_filter = ['status', 'level']
    search_fields = ['code', 'name']
    readonly_fields = ['created_at', 'updated_at']


@admin.register(Station)
class StationAdmin(admin.ModelAdmin):
    list_display = ['id', 'station_code', 'station_name', 'phone', 'daily_capacity', 'status']
    list_filter = ['status', 'created_at']
    search_fields = ['station_code', 'station_name', 'address', 'phone']
    readonly_fields = ['created_at', 'updated_at']


@admin.register(Staff)
class StaffAdmin(admin.ModelAdmin):
    list_display = ['id', 'employee_code', 'full_name', 'user', 'role', 'station', 'rating_average', 'status']
    list_filter = ['status', 'role', 'station', 'created_at']
    search_fields = ['employee_code', 'full_name', 'phone', 'user__username']
    readonly_fields = ['created_at', 'updated_at', 'tasks_total', 'tasks_completed', 'rating_average']
    
    fieldsets = (
        ('User Account', {
            'fields': ('user',)
        }),
        ('Thông tin nhân viên', {
            'fields': ('employee_code', 'full_name', 'phone', 'avatar_url')
        }),
        ('Công việc', {
            'fields': ('role', 'station', 'position', 'hire_date')
        }),
        ('Thông tin cá nhân', {
            'fields': ('birth_date', 'gender', 'address')
        }),
        ('Performance', {
            'fields': ('tasks_total', 'tasks_completed', 'rating_average')
        }),
        ('Status', {
            'fields': ('status',)
        }),
        ('System', {
            'fields': ('created_at', 'updated_at')
        }),
    )


# ========================================
# VEHICLE
# ========================================

@admin.register(VehicleType)
class VehicleTypeAdmin(admin.ModelAdmin):
    list_display = ['id', 'type_code', 'type_name', 'base_price', 'status']
    list_filter = ['status']
    search_fields = ['type_code', 'type_name']
    readonly_fields = ['created_at', 'updated_at']


@admin.register(Vehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ['id', 'license_plate', 'customer', 'vehicle_type', 'brand', 'model', 'status']
    list_filter = ['status', 'vehicle_type', 'manufacture_year']
    search_fields = ['license_plate', 'brand', 'model', 'chassis_number', 'engine_number']
    readonly_fields = ['created_at', 'updated_at']


# ========================================
# PRICING
# ========================================

@admin.register(Pricing)
class PricingAdmin(admin.ModelAdmin):
    list_display = ['id', 'vehicle_type', 'inspection_fee', 'total_amount', 'effective_from', 'status']
    list_filter = ['status', 'vehicle_type']
    readonly_fields = ['total_amount', 'created_at', 'updated_at']


# ========================================
# ORDER
# ========================================

class OrderStatusHistoryInline(admin.TabularInline):
    model = OrderStatusHistory
    extra = 0
    readonly_fields = ['created_at']
    can_delete = False


class OrderChecklistInline(admin.TabularInline):
    model = OrderChecklist
    extra = 0
    readonly_fields = ['checked_at']


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ['id', 'order_code', 'customer', 'vehicle', 'station', 'status', 'created_at']
    list_filter = ['status', 'priority', 'inspection_result', 'station', 'created_at']
    search_fields = ['order_code', 'customer__full_name', 'vehicle__license_plate']
    readonly_fields = ['order_code', 'created_at', 'updated_at']
    inlines = [OrderStatusHistoryInline, OrderChecklistInline]


@admin.register(OrderStatusHistory)
class OrderStatusHistoryAdmin(admin.ModelAdmin):
    list_display = ['id', 'order', 'from_status', 'to_status', 'changed_by', 'created_at']
    list_filter = ['from_status', 'to_status', 'created_at']
    search_fields = ['order__order_code']
    readonly_fields = ['created_at']


# ========================================
# CHECKLIST
# ========================================

@admin.register(ChecklistItem)
class ChecklistItemAdmin(admin.ModelAdmin):
    list_display = ['id', 'item_key', 'item_label', 'category', 'display_order', 'require_photo', 'status']
    list_filter = ['category', 'require_photo', 'status']
    search_fields = ['item_key', 'item_label']
    readonly_fields = ['created_at', 'updated_at']
    ordering = ['display_order']


@admin.register(OrderChecklist)
class OrderChecklistAdmin(admin.ModelAdmin):
    list_display = ['id', 'order', 'checklist_item', 'result', 'measured_value', 'checked_at']
    list_filter = ['result', 'checked_at']
    search_fields = ['order__order_code', 'checklist_item__item_label']
    readonly_fields = ['checked_at']


# ========================================
# PAYMENT
# ========================================

@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ['id', 'transaction_code', 'order', 'amount', 'payment_method', 'status', 'paid_at']
    list_filter = ['status', 'payment_method', 'created_at']
    search_fields = ['transaction_code', 'order__order_code']
    readonly_fields = ['transaction_code', 'created_at', 'updated_at']


# ========================================
# RATING
# ========================================

@admin.register(Rating)
class RatingAdmin(admin.ModelAdmin):
    list_display = ['id', 'order', 'customer', 'staff', 'overall_rating', 'created_at']
    list_filter = ['overall_rating', 'service_rating', 'staff_rating', 'facility_rating', 'created_at']
    search_fields = ['order__order_code', 'customer__full_name', 'staff__full_name']
    readonly_fields = ['created_at']


# ========================================
# OTP
# ========================================

@admin.register(OTP)
class OTPAdmin(admin.ModelAdmin):
    list_display = ['id', 'phone', 'otp_code', 'purpose', 'is_verified', 'expires_at', 'created_at']
    list_filter = ['purpose', 'is_verified', 'created_at']
    search_fields = ['phone', 'otp_code']
    readonly_fields = ['created_at', 'verified_at']
