from rest_framework import viewsets, status
from rest_framework.decorators import api_view, action, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.authtoken.models import Token
from django.contrib.auth import login, logout
from django.contrib.auth.models import User
from django.utils import timezone
from .models import *
from .serializers import *


# ========================================
# UNIFIED LOGIN - API ĐĂNG NHẬP THỐNG NHẤT
# ========================================

@api_view(['POST'])
@permission_classes([AllowAny])
def unified_login(request):
    """
    API đăng nhập thống nhất cho Customer, Staff và Admin
    POST /api/login/
    
    CUSTOMER (Phone + Password):
    Body: {"phone": "0912345678", "password": "password123"}
    
    CUSTOMER (Phone + OTP):
    Body: {"phone": "0912345678", "otp_code": "123456"}
    
    CUSTOMER (Social Login):
    Body: {"provider": "google", "token": "google_access_token"}
    Body: {"provider": "facebook", "token": "facebook_access_token"}
    Body: {"provider": "apple", "token": "apple_id_token"}
    
    STAFF (Phone + Password):
    Body: {"phone": "0912345678", "password": "password123"}
    
    ADMIN (Username + Password):
    Body: {"username": "admin", "password": "admin123"}
    
    Response:
    {
        "success": true,
        "message": "Đăng nhập thành công",
        "token": "abc123...",
        "user_type": "customer" | "staff" | "admin",
        "user_data": {...}
    }
    """
    
    phone = request.data.get('phone')
    password = request.data.get('password')
    username = request.data.get('username')
    otp_code = request.data.get('otp_code')
    provider = request.data.get('provider')  # google, facebook, apple
    social_token = request.data.get('token')
    
    # ========================================
    # 1. ADMIN LOGIN (Username + Password)
    # ========================================
    if username and password:
        return handle_admin_login(request, username, password)
    
    # ========================================
    # 2. SOCIAL LOGIN (Customer only)
    # ========================================
    elif provider and social_token:
        return handle_social_login(request, provider, social_token)
    
    # ========================================
    # 3. PHONE + PASSWORD (Customer or Staff)
    # ========================================
    elif phone and password:
        return handle_phone_password_login(request, phone, password)
    
    # ========================================
    # 4. PHONE + OTP (Customer only)
    # ========================================
    elif phone and otp_code:
        return handle_otp_login(request, phone, otp_code)
    
    # ========================================
    # Invalid request
    # ========================================
    else:
        return Response({
            'non_field_errors': ['Vui lòng nhập đầy đủ thông tin đăng nhập']
        }, status=status.HTTP_400_BAD_REQUEST)


# ========================================
# HELPER FUNCTIONS
# ========================================

def handle_admin_login(request, username, password):
    """
    Xử lý đăng nhập Admin
    """
    try:
        user = User.objects.get(username=username)
        
        # Verify password
        if not user.check_password(password):
            return Response({
                'non_field_errors': ['Tên đăng nhập hoặc mật khẩu không đúng']
            }, status=status.HTTP_400_BAD_REQUEST)
        
        # Kiểm tra quyền admin
        if not user.is_superuser and not user.is_staff:
            return Response({
                'non_field_errors': ['Bạn không có quyền truy cập Admin']
            }, status=status.HTTP_403_FORBIDDEN)
        
        # Login
        login(request, user, backend='django.contrib.auth.backends.ModelBackend')
        token, created = Token.objects.get_or_create(user=user)
        
        return Response({
            'success': True,
            'message': 'Đăng nhập thành công',
            'token': token.key,
            'user_type': 'admin',
            'admin': {
                'id': user.id,
                'username': user.username,
                'email': user.email or '',
                'is_superuser': user.is_superuser,
                'is_staff': user.is_staff
            }
        }, status=status.HTTP_200_OK)
        
    except User.DoesNotExist:
        return Response({
            'non_field_errors': ['Tên đăng nhập hoặc mật khẩu không đúng']
        }, status=status.HTTP_400_BAD_REQUEST)


def handle_phone_password_login(request, phone, password):
    """
    Xử lý đăng nhập bằng SĐT + Password
    Tự động phát hiện Customer hoặc Staff
    """
    # Tìm Customer
    try:
        customer = Customer.objects.get(phone=phone)
        user = customer.user
        
        # Verify password
        if not user.check_password(password):
            return Response({
                'non_field_errors': ['Số điện thoại hoặc mật khẩu không đúng']
            }, status=status.HTTP_400_BAD_REQUEST)
        
        # Login
        login(request, user, backend='django.contrib.auth.backends.ModelBackend')
        token, created = Token.objects.get_or_create(user=user)
        
        return Response({
            'success': True,
            'message': 'Đăng nhập thành công',
            'token': token.key,
            'user_type': 'customer',
            'user_data': CustomerSerializer(customer).data
        }, status=status.HTTP_200_OK)
        
    except Customer.DoesNotExist:
        pass
    
    # Tìm Staff
    try:
        staff = Staff.objects.get(phone=phone)
        user = staff.user
        
        # Verify password
        if not user.check_password(password):
            return Response({
                'non_field_errors': ['Số điện thoại hoặc mật khẩu không đúng']
            }, status=status.HTTP_400_BAD_REQUEST)
        
        # Login
        login(request, user, backend='django.contrib.auth.backends.ModelBackend')
        token, created = Token.objects.get_or_create(user=user)
        
        return Response({
            'success': True,
            'message': 'Đăng nhập thành công',
            'token': token.key,
            'user_type': 'staff',
            'user_data': StaffSerializer(staff).data
        }, status=status.HTTP_200_OK)
        
    except Staff.DoesNotExist:
        pass
    
    # Không tìm thấy
    return Response({
        'non_field_errors': ['Số điện thoại hoặc mật khẩu không đúng']
    }, status=status.HTTP_400_BAD_REQUEST)


def handle_otp_login(request, phone, otp_code):
    """
    Xử lý đăng nhập bằng OTP (chỉ dành cho Customer)
    """
    serializer = VerifyOTPSerializer(data={'phone': phone, 'otp_code': otp_code})
    if serializer.is_valid():
        customer = serializer.validated_data['customer']
        otp = serializer.validated_data['otp']
        
        # Mark OTP as verified
        otp.is_verified = True
        otp.verified_at = timezone.now()
        otp.save()
        
        # Login
        user = customer.user
        login(request, user, backend='django.contrib.auth.backends.ModelBackend')
        
        # Create/get token
        token, created = Token.objects.get_or_create(user=user)
        
        return Response({
            'success': True,
            'message': 'Đăng nhập thành công',
            'token': token.key,
            'user_type': 'customer',
            'user_data': CustomerSerializer(customer).data
        }, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


def handle_social_login(request, provider, social_token):
    """
    Xử lý đăng nhập Social (Google, Facebook, Apple)
    Chỉ dành cho Customer
    """
    # Validate provider
    if provider not in ['google', 'facebook', 'apple']:
        return Response({
            'non_field_errors': ['Provider không hợp lệ']
        }, status=status.HTTP_400_BAD_REQUEST)
    
    # TODO: Verify social token with provider API
    # For now, we'll implement a basic version
    # In production, you need to verify token with Google/Facebook/Apple API
    
    try:
        # Get user info from social provider
        social_user_info = verify_social_token(provider, social_token)
        
        if not social_user_info:
            return Response({
                'non_field_errors': ['Token không hợp lệ hoặc đã hết hạn']
            }, status=status.HTTP_400_BAD_REQUEST)
        
        social_id = social_user_info['id']
        email = social_user_info.get('email')
        name = social_user_info.get('name', '')
        avatar = social_user_info.get('avatar')
        
        # Find or create customer by social ID
        customer = None
        user = None
        
        if provider == 'google':
            customer = Customer.objects.filter(google_id=social_id).first()
        elif provider == 'facebook':
            customer = Customer.objects.filter(facebook_id=social_id).first()
        elif provider == 'apple':
            customer = Customer.objects.filter(apple_id=social_id).first()
        
        # Customer exists - login
        if customer:
            user = customer.user
        
        # Create new customer
        else:
            # Create User
            username = f"{provider}_{social_id}"
            user = User.objects.create_user(
                username=username,
                email=email or f"{username}@social.login",
                password=None  # No password for social login
            )
            
            # Create Customer
            customer = Customer.objects.create(
                user=user,
                full_name=name,
                phone='',  # Will be updated later if needed
                avatar_url=avatar,
                phone_verified=False,
                email_verified=True if email else False
            )
            
            # Set social ID
            if provider == 'google':
                customer.google_id = social_id
            elif provider == 'facebook':
                customer.facebook_id = social_id
            elif provider == 'apple':
                customer.apple_id = social_id
            customer.save()
        
        # Login
        login(request, user, backend='django.contrib.auth.backends.ModelBackend')
        token, created = Token.objects.get_or_create(user=user)
        
        return Response({
            'success': True,
            'message': 'Đăng nhập thành công',
            'token': token.key,
            'user_type': 'customer',
            'user_data': CustomerSerializer(customer).data,
            'is_new_user': not customer.phone  # Cần cập nhật SĐT
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({
            'non_field_errors': [f'Đăng nhập social thất bại: {str(e)}']
        }, status=status.HTTP_400_BAD_REQUEST)


def verify_social_token(provider, token):
    """
    Verify social token with provider API
    Returns user info or None
    
    TODO: Implement real verification in production
    """
    # DEVELOPMENT ONLY - Skip verification
    # In production, you must verify token with:
    # - Google: https://www.googleapis.com/oauth2/v3/tokeninfo?access_token={token}
    # - Facebook: https://graph.facebook.com/me?access_token={token}
    # - Apple: Verify JWT token
    
    # For development, return mock data
    if token == 'DEVELOPMENT_TOKEN':
        return {
            'id': f'dev_{provider}_123456',
            'email': f'user@{provider}.com',
            'name': f'Test User ({provider})',
            'avatar': None
        }
    
    # In production, implement real verification here
    return None


# ========================================
# OTP MANAGEMENT
# ========================================

@api_view(['POST'])
@permission_classes([AllowAny])
def customer_request_otp(request):
    """
    Yêu cầu OTP để đăng nhập
    POST /api/auth/request-otp/
    Body: {"phone": "0912345678", "purpose": "register" | "login"}
    """
    serializer = RequestOTPSerializer(data=request.data)
    if serializer.is_valid():
        otp = serializer.create_otp()
        return Response({
            'success': True,
            'message': f'OTP đã được gửi đến {otp.phone}',
            'expires_at': otp.expires_at,
            'debug_otp': otp.otp_code  # TODO: Xóa trong production
        }, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# ========================================
# CUSTOMER REGISTRATION
# ========================================

@api_view(['POST'])
@permission_classes([AllowAny])
def customer_register(request):
    """
    Đăng ký tài khoản Customer mới
    POST /api/register/
    
    Body: {
        "phone": "0912345678",
        "password": "password123",
        "full_name": "Nguyễn Văn A",
        "email": "email@example.com"  // Optional
    }
    
    Response:
    {
        "success": true,
        "message": "Đăng ký thành công",
        "token": "abc123...",
        "user_type": "customer",
        "user_data": {...}
    }
    """
    phone = request.data.get('phone')
    password = request.data.get('password')
    full_name = request.data.get('full_name')
    email = request.data.get('email', '')
    
    # Validate
    if not phone or not password or not full_name:
        return Response({
            'non_field_errors': ['Vui lòng nhập đầy đủ: số điện thoại, mật khẩu, và họ tên']
        }, status=status.HTTP_400_BAD_REQUEST)
    
    # Check if phone exists
    if Customer.objects.filter(phone=phone).exists():
        return Response({
            'phone': ['Số điện thoại đã được đăng ký']
        }, status=status.HTTP_400_BAD_REQUEST)
    
    # Check password strength (at least 6 characters)
    if len(password) < 6:
        return Response({
            'password': ['Mật khẩu phải có ít nhất 6 ký tự']
        }, status=status.HTTP_400_BAD_REQUEST)
    
    try:
        # Create User
        username = f"customer_{phone}"
        user = User.objects.create_user(
            username=username,
            email=email,
            password=password
        )
        
        # Create Customer
        customer = Customer.objects.create(
            user=user,
            full_name=full_name,
            phone=phone,
            phone_verified=False,
            email_verified=False
        )
        
        # Auto login
        login(request, user, backend='django.contrib.auth.backends.ModelBackend')
        token, created = Token.objects.get_or_create(user=user)
        
        return Response({
            'success': True,
            'message': 'Đăng ký thành công',
            'token': token.key,
            'user_type': 'customer',
            'user_data': CustomerSerializer(customer).data
        }, status=status.HTTP_201_CREATED)
        
    except Exception as e:
        return Response({
            'non_field_errors': [f'Đăng ký thất bại: {str(e)}']
        }, status=status.HTTP_400_BAD_REQUEST)


# ========================================
# AUTHENTICATION UTILITIES
# ========================================

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def user_logout(request):
    """
    Đăng xuất (cho cả Customer và Staff)
    POST /api/auth/logout/
    Headers: Authorization: Token abc123...
    """
    # Xóa token
    try:
        request.user.auth_token.delete()
    except:
        pass
    
    # Logout session
    logout(request)
    
    return Response({
        'success': True,
        'message': 'Đăng xuất thành công'
    }, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def current_user(request):
    """
    Lấy thông tin user hiện tại
    GET /api/auth/me/
    Headers: Authorization: Token abc123...
    """
    user = request.user
    
    # Xác định user type
    if user.is_superuser:
        user_type = 'admin'
        profile_data = {
            'username': user.username,
            'email': user.email,
            'is_superuser': True
        }
    elif hasattr(user, 'staff_profile'):
        user_type = 'staff'
        profile_data = StaffSerializer(user.staff_profile).data
    elif hasattr(user, 'customer_profile'):
        user_type = 'customer'
        profile_data = CustomerSerializer(user.customer_profile).data
    else:
        user_type = 'unknown'
        profile_data = {}
    
    return Response({
        'user_type': user_type,
        'profile': profile_data
    })


# ========================================
# CUSTOMER VIEWSET
# ========================================

class CustomerViewSet(viewsets.ModelViewSet):
    """
    ViewSet cho Customer
    GET /api/customers/          - List customers
    GET /api/customers/{id}/     - Get customer detail
    PUT /api/customers/{id}/     - Update customer
    """
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        user = self.request.user
        
        # Admin: xem tất cả
        if user.is_superuser or user.is_staff:
            return Customer.objects.all()
        
        # Customer: chỉ xem chính mình
        if hasattr(user, 'customer_profile'):
            return Customer.objects.filter(id=user.customer_profile.id)
        
        return Customer.objects.none()
    
    @action(detail=False, methods=['get'])
    def me(self, request):
        """GET /api/customers/me/ - Lấy thông tin customer hiện tại"""
        if not hasattr(request.user, 'customer_profile'):
            return Response({'error': 'Không phải customer'}, status=403)
        
        serializer = self.get_serializer(request.user.customer_profile)
        return Response(serializer.data)
    
    @action(detail=False, methods=['put'])
    def update_profile(self, request):
        """PUT /api/customers/update-profile/ - Cập nhật thông tin"""
        if not hasattr(request.user, 'customer_profile'):
            return Response({'error': 'Không phải customer'}, status=403)
        
        customer = request.user.customer_profile
        serializer = self.get_serializer(customer, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=400)


# ========================================
# STAFF VIEWSET
# ========================================

class StaffViewSet(viewsets.ReadOnlyModelViewSet):
    """
    ViewSet cho Staff (Read-only cho API)
    Tạo/sửa Staff qua Django Admin
    """
    queryset = Staff.objects.all()
    serializer_class = StaffSerializer
    permission_classes = [IsAuthenticated]
    
    @action(detail=False, methods=['get'])
    def me(self, request):
        """GET /api/staff/me/ - Lấy thông tin staff hiện tại"""
        if not hasattr(request.user, 'staff_profile'):
            return Response({'error': 'Không phải staff'}, status=403)
        
        serializer = self.get_serializer(request.user.staff_profile)
        return Response(serializer.data)


# ========================================
# VEHICLE VIEWSET
# ========================================

class VehicleViewSet(viewsets.ModelViewSet):
    queryset = Vehicle.objects.all()
    serializer_class = VehicleSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        user = self.request.user
        
        # Admin/Staff: xem tất cả
        if user.is_superuser or hasattr(user, 'staff_profile'):
            return Vehicle.objects.all()
        
        # Customer: chỉ xem xe của mình
        if hasattr(user, 'customer_profile'):
            return Vehicle.objects.filter(customer=user.customer_profile)
        
        return Vehicle.objects.none()
    
    def perform_create(self, serializer):
        # Tự động set customer
        if hasattr(self.request.user, 'customer_profile'):
            serializer.save(customer=self.request.user.customer_profile)
        else:
            serializer.save()


# ========================================
# OTHER VIEWSETS
# ========================================

class VehicleTypeViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = VehicleType.objects.filter(status='active')
    serializer_class = VehicleTypeSerializer
    permission_classes = [AllowAny]


class StationViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Station.objects.filter(status='active')
    serializer_class = StationSerializer
    permission_classes = [AllowAny]


class PricingViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Pricing.objects.filter(status='active')
    serializer_class = PricingSerializer
    permission_classes = [AllowAny]


class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        user = self.request.user
        
        # Admin/Staff: xem tất cả
        if user.is_superuser or hasattr(user, 'staff_profile'):
            return Order.objects.all()
        
        # Customer: chỉ xem đơn của mình
        if hasattr(user, 'customer_profile'):
            return Order.objects.filter(customer=user.customer_profile)
        
        return Order.objects.none()
    
    def perform_create(self, serializer):
        # Tự động set customer
        if hasattr(self.request.user, 'customer_profile'):
            serializer.save(customer=self.request.user.customer_profile)
        else:
            serializer.save()


class ChecklistItemViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = ChecklistItem.objects.filter(status='active')
    serializer_class = ChecklistItemSerializer
    permission_classes = [AllowAny]


class OrderChecklistViewSet(viewsets.ModelViewSet):
    queryset = OrderChecklist.objects.all()
    serializer_class = OrderChecklistSerializer
    permission_classes = [IsAuthenticated]


class PaymentViewSet(viewsets.ModelViewSet):
    queryset = Payment.objects.all()
    serializer_class = PaymentSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        user = self.request.user
        
        # Admin/Staff: xem tất cả
        if user.is_superuser or hasattr(user, 'staff_profile'):
            return Payment.objects.all()
        
        # Customer: chỉ xem payment của mình
        if hasattr(user, 'customer_profile'):
            return Payment.objects.filter(order__customer=user.customer_profile)
        
        return Payment.objects.none()


class RatingViewSet(viewsets.ModelViewSet):
    queryset = Rating.objects.all()
    serializer_class = RatingSerializer
    permission_classes = [IsAuthenticated]
    
    def perform_create(self, serializer):
        # Tự động set customer
        if hasattr(self.request.user, 'customer_profile'):
            serializer.save(customer=self.request.user.customer_profile)
        else:
            serializer.save()