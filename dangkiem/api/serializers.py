from rest_framework import serializers
from django.contrib.auth.models import User
from .models import *
import random
from datetime import timedelta
from django.utils import timezone


# ========================================
# 1. CUSTOMER SERIALIZERS
# ========================================

class CustomerSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source='user.username', read_only=True)
    email = serializers.EmailField(source='user.email', read_only=True)
    
    class Meta:
        model = Customer
        fields = '__all__'
        read_only_fields = ['user', 'created_at', 'updated_at', 'total_orders', 
                           'completed_orders', 'total_spent', 'loyalty_points']


class CustomerRegisterSerializer(serializers.Serializer):
    """Đăng ký khách hàng mới qua OTP"""
    phone = serializers.CharField(max_length=20)
    otp_code = serializers.CharField(max_length=6)
    full_name = serializers.CharField(max_length=200, required=False)
    
    def validate_phone(self, value):
        # Validate phone format (VN)
        if not value.startswith('0') or len(value) not in [10, 11]:
            raise serializers.ValidationError("Số điện thoại không hợp lệ")
        return value
    
    def validate(self, data):
        # Verify OTP
        phone = data['phone']
        otp_code = data['otp_code']
        
        otp = OTP.objects.filter(
            phone=phone,
            otp_code=otp_code,
            purpose='register',
            is_verified=False,
            expires_at__gt=timezone.now()
        ).first()
        
        if not otp:
            raise serializers.ValidationError("OTP không hợp lệ hoặc đã hết hạn")
        
        data['otp'] = otp
        return data
    
    def create(self, validated_data):
        phone = validated_data['phone']
        full_name = validated_data.get('full_name', '')
        otp = validated_data['otp']
        
        # Kiểm tra phone đã tồn tại chưa
        existing_customer = Customer.objects.filter(phone=phone).first()
        if existing_customer:
            raise serializers.ValidationError("Số điện thoại đã được đăng ký")
        
        # Tạo User
        username = phone  # Dùng phone làm username
        user = User.objects.create_user(
            username=username,
            password=None  # Không cần password (dùng OTP)
        )
        user.set_unusable_password()
        user.save()
        
        # Tạo Customer Profile
        customer = Customer.objects.create(
            user=user,
            full_name=full_name or phone,
            phone=phone,
            phone_verified=True
        )
        
        # Mark OTP as verified
        otp.is_verified = True
        otp.verified_at = timezone.now()
        otp.save()
        
        return customer


class RequestOTPSerializer(serializers.Serializer):
    """Yêu cầu OTP"""
    phone = serializers.CharField(max_length=20)
    purpose = serializers.ChoiceField(choices=['register', 'login'], default='login')
    
    def validate_phone(self, value):
        if not value.startswith('0') or len(value) not in [10, 11]:
            raise serializers.ValidationError("Số điện thoại không hợp lệ")
        return value
    
    def create_otp(self):
        phone = self.validated_data['phone']
        purpose = self.validated_data['purpose']
        
        # ✅ Check if phone exists for LOGIN purpose
        if purpose == 'login':
            from .models import Customer
            customer_exists = Customer.objects.filter(phone=phone).exists()
            if not customer_exists:
                raise serializers.ValidationError({
                    'phone': 'Số điện thoại chưa được đăng ký. Vui lòng đăng ký tài khoản mới.'
                })
        
        # ✅ Check if phone already registered for REGISTER purpose
        if purpose == 'register':
            from .models import Customer
            customer_exists = Customer.objects.filter(phone=phone).exists()
            if customer_exists:
                raise serializers.ValidationError({
                    'phone': 'Số điện thoại đã được đăng ký. Vui lòng đăng nhập.'
                })
        
        # Generate 6-digit OTP
        otp_code = str(random.randint(100000, 999999))
        
        # Xóa các OTP cũ chưa verify
        OTP.objects.filter(phone=phone, purpose=purpose, is_verified=False).delete()
        
        # Tạo OTP mới
        otp = OTP.objects.create(
            phone=phone,
            otp_code=otp_code,
            purpose=purpose,
            expires_at=timezone.now() + timedelta(minutes=5)
        )
        
        # TODO: Gửi SMS thực tế
        print(f"[SMS] Gửi OTP {otp_code} đến {phone}")
        
        return otp


class VerifyOTPSerializer(serializers.Serializer):
    """Verify OTP và login"""
    phone = serializers.CharField(max_length=20)
    otp_code = serializers.CharField(max_length=6)
    
    def validate(self, data):
        phone = data['phone']
        otp_code = data['otp_code']
        
        # Verify OTP
        otp = OTP.objects.filter(
            phone=phone,
            otp_code=otp_code,
            purpose='login',
            is_verified=False,
            expires_at__gt=timezone.now()
        ).first()
        
        if not otp:
            raise serializers.ValidationError("OTP không hợp lệ hoặc đã hết hạn")
        
        # Tìm Customer
        customer = Customer.objects.filter(phone=phone).first()
        if not customer:
            raise serializers.ValidationError("Số điện thoại chưa được đăng ký")
        
        data['otp'] = otp
        data['customer'] = customer
        return data


# ========================================
# 2. STAFF SERIALIZERS
# ========================================

class StaffSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source='user.username', read_only=True)
    role_name = serializers.CharField(source='role.name', read_only=True)
    station_name = serializers.CharField(source='station.station_name', read_only=True)
    
    class Meta:
        model = Staff
        fields = '__all__'
        read_only_fields = ['user', 'created_at', 'updated_at', 'tasks_total', 
                           'tasks_completed', 'rating_average']


class StaffLoginSerializer(serializers.Serializer):
    """Đăng nhập nhân viên bằng username/password"""
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)
    
    def validate(self, data):
        username = data['username']
        password = data['password']
        
        # Tìm User
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            raise serializers.ValidationError("Tên đăng nhập hoặc mật khẩu không đúng")
        
        # Check password
        if not user.check_password(password):
            raise serializers.ValidationError("Tên đăng nhập hoặc mật khẩu không đúng")
        
        # Check có phải Staff không
        if not hasattr(user, 'staff_profile'):
            raise serializers.ValidationError("Tài khoản không có quyền truy cập")
        
        if user.staff_profile.status != 'active':
            raise serializers.ValidationError("Tài khoản đã bị khóa")
        
        data['user'] = user
        data['staff'] = user.staff_profile
        return data


# ========================================
# 3. OTHER SERIALIZERS
# ========================================

class VehicleTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = VehicleType
        fields = '__all__'


class VehicleSerializer(serializers.ModelSerializer):
    vehicle_type_name = serializers.CharField(source='vehicle_type.type_name', read_only=True)
    
    class Meta:
        model = Vehicle
        fields = '__all__'
        read_only_fields = ['customer', 'created_at', 'updated_at']


class StationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Station
        fields = '__all__'


class PricingSerializer(serializers.ModelSerializer):
    vehicle_type_name = serializers.CharField(source='vehicle_type.type_name', read_only=True)
    
    class Meta:
        model = Pricing
        fields = '__all__'
        read_only_fields = ['total_amount', 'created_at', 'updated_at']


class OrderSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(source='customer.full_name', read_only=True)
    vehicle_plate = serializers.CharField(source='vehicle.license_plate', read_only=True)
    station_name = serializers.CharField(source='station.station_name', read_only=True)
    staff_name = serializers.CharField(source='assigned_staff.full_name', read_only=True)
    
    class Meta:
        model = Order
        fields = '__all__'
        read_only_fields = ['order_code', 'created_at', 'updated_at']


class ChecklistItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChecklistItem
        fields = '__all__'


class OrderChecklistSerializer(serializers.ModelSerializer):
    item_label = serializers.CharField(source='checklist_item.item_label', read_only=True)
    
    class Meta:
        model = OrderChecklist
        fields = '__all__'
        read_only_fields = ['checked_at']


class PaymentSerializer(serializers.ModelSerializer):
    order_code = serializers.CharField(source='order.order_code', read_only=True)
    
    class Meta:
        model = Payment
        fields = '__all__'
        read_only_fields = ['transaction_code', 'created_at', 'updated_at']


class RatingSerializer(serializers.ModelSerializer):
    order_code = serializers.CharField(source='order.order_code', read_only=True)
    
    class Meta:
        model = Rating
        fields = '__all__'
        read_only_fields = ['created_at']
