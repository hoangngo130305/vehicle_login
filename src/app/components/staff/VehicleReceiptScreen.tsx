import { useNavigate, useParams } from 'react-router';
import { ArrowLeft, Camera, Check, AlertTriangle, FileText, CheckCircle, X, User, Edit3, CreditCard, Banknote, QrCode } from 'lucide-react';
import { useState } from 'react';
import { toast } from 'sonner';
import { useStaffOrders } from '@/app/contexts/StaffOrdersContext';

interface ChecklistItem {
  checked: boolean;
  photo: string | null;
}

interface CustomerInfo {
  fullName: string;
  idNumber: string;
  phone: string;
  address: string;
}

export default function VehicleReceiptScreen() {
  const navigate = useNavigate();
  const { orderId } = useParams();
  const { getOrderById } = useStaffOrders();
  const order = getOrderById(orderId || '');

  // 1. Thông tin khách hàng (tự động điền vào biên bản ủy quyền)
  const [customerInfo, setCustomerInfo] = useState<CustomerInfo>({
    fullName: '',
    idNumber: '',
    phone: '',
    address: '',
  });

  // 2. 6 ảnh thực tế của xe (RIÊNG BIỆT)
  const [vehiclePhotos, setVehiclePhotos] = useState({
    front: null as string | null,
    back: null as string | null,
    left: null as string | null,
    right: null as string | null,
    interior: null as string | null,
    dashboard: null as string | null,
  });

  // 3. Checklist kiểm tra (có ảnh kèm theo)
  const [checklist, setChecklist] = useState<Record<string, ChecklistItem>>({
    exterior: { checked: false, photo: null },
    tires: { checked: false, photo: null },
    lights: { checked: false, photo: null },
    mirrors: { checked: false, photo: null },
    windshield: { checked: false, photo: null },
    interior: { checked: false, photo: null },
    engine: { checked: false, photo: null },
    fuel: { checked: false, photo: null },
  });

  // 4. Ghi chú chung
  const [generalNote, setGeneralNote] = useState('');

  // 5. Chữ ký khách hàng
  const [customerSignature, setCustomerSignature] = useState<string | null>(null);

  // 6. Phương thức thanh toán
  const [paymentMethod, setPaymentMethod] = useState<'qr' | 'cash'>('qr');

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [paymentRequested, setPaymentRequested] = useState(false); // Đã gửi yêu cầu thanh toán
  const [paymentCompleted, setPaymentCompleted] = useState(false); // Khách đã thanh toán
  const [receiptSaved, setReceiptSaved] = useState(false); // Đã lưu biên bản

  if (!order) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center p-5">
        <div className="text-center">
          <AlertTriangle size={64} className="text-red-500 mx-auto mb-4" />
          <h2 className="text-xl font-bold text-gray-900 mb-2">Không tìm thấy đơn hàng</h2>
          <button
            onClick={() => navigate('/staff/orders')}
            className="px-6 py-2.5 bg-green-600 text-white rounded-xl font-semibold hover:bg-green-700 transition-colors"
          >
            Quay lại danh sách
          </button>
        </div>
      </div>
    );
  }

  // Handler cho 6 ảnh xe
  const handleVehiclePhotoCapture = (position: keyof typeof vehiclePhotos) => {
    toast.success(`Chụp ảnh ${getPhotoLabel(position)} thành công!`);
    setVehiclePhotos({
      ...vehiclePhotos,
      [position]: `https://picsum.photos/400/300?random=vehicle-${position}-${Date.now()}`,
    });
  };

  const handleRemoveVehiclePhoto = (position: keyof typeof vehiclePhotos, e: React.MouseEvent) => {
    e.stopPropagation();
    setVehiclePhotos({
      ...vehiclePhotos,
      [position]: null,
    });
    toast.success('Đã xóa ảnh');
  };

  const getPhotoLabel = (key: string) => {
    const labels: Record<string, string> = {
      front: 'phía trước',
      back: 'phía sau',
      left: 'bên trái',
      right: 'bên phải',
      interior: 'nội thất',
      dashboard: 'bảng điều khiển',
    };
    return labels[key] || key;
  };

  // Handler cho checklist photos
  const handleChecklistPhotoCapture = (itemKey: string) => {
    toast.success(`Chụp ảnh thành công!`);
    setChecklist({
      ...checklist,
      [itemKey]: {
        ...checklist[itemKey],
        photo: `https://picsum.photos/400/300?random=checklist-${itemKey}-${Date.now()}`,
      },
    });
  };

  const handleChecklistToggle = (itemKey: string) => {
    setChecklist({
      ...checklist,
      [itemKey]: {
        ...checklist[itemKey],
        checked: !checklist[itemKey].checked,
      },
    });
  };

  const handleRemoveChecklistPhoto = (itemKey: string, e: React.MouseEvent) => {
    e.stopPropagation();
    setChecklist({
      ...checklist,
      [itemKey]: {
        ...checklist[itemKey],
        photo: null,
      },
    });
    toast.success('Đã xóa ảnh');
  };

  // Handler cho chữ ký khách hàng
  const handleCustomerSignature = () => {
    toast.success('Đã lưu chữ ký khách hàng!');
    setCustomerSignature(`signature-${Date.now()}`);
  };

  // Validate form
  const validateForm = () => {
    // Validate thông tin khách hàng
    if (!customerInfo.fullName.trim() || !customerInfo.idNumber.trim() || 
        !customerInfo.phone.trim() || !customerInfo.address.trim()) {
      toast.error('Vui lòng điền đầy đủ thông tin khách hàng!');
      return false;
    }

    // Validate 6 ảnh xe
    const vehiclePhotoCount = Object.values(vehiclePhotos).filter(p => p !== null).length;
    if (vehiclePhotoCount < 6) {
      toast.error('Vui lòng chụp đầy đủ 6 ảnh xe!');
      return false;
    }

    // Validate checklist
    const checklistCount = Object.values(checklist).filter(c => c.checked).length;
    if (checklistCount < 6) {
      toast.error('Vui lòng kiểm tra ít nhất 6 hạng mục!');
      return false;
    }

    // Validate ảnh checklist (các item đã check phải có ảnh)
    const checkedItemsWithoutPhoto = Object.values(checklist).filter(c => c.checked && !c.photo).length;
    if (checkedItemsWithoutPhoto > 0) {
      toast.error('Vui lòng chụp ảnh cho tất cả các hạng mục đã kiểm tra!');
      return false;
    }

    // Validate chữ ký
    if (!customerSignature) {
      toast.error('Vui lòng yêu cầu khách hàng ký chữ ký!');
      return false;
    }

    return true;
  };

  // BƯỚC 1A: Gửi yêu cầu thanh toán QR
  const handleRequestPayment = () => {
    if (!validateForm()) return;

    toast.success('🎉 Đã gửi yêu cầu thanh toán QR!');
    toast.info('Khách hàng sẽ nhận được mã QR thanh toán trên app.');
    setPaymentRequested(true);

    // Simulate payment completion after 3s
    setTimeout(() => {
      toast.success('💳 Khách hàng đã thanh toán QR thành công!');
      setPaymentCompleted(true);
    }, 3000);
  };

  // BƯỚC 1B: Xác nhận thu tiền mặt
  const handleCashPayment = () => {
    if (!validateForm()) return;

    if (confirm(`Xác nhận đã thu tiền mặt ${order.total} từ khách hàng?`)) {
      toast.success('💵 Đã xác nhận thu tiền mặt!');
      setPaymentRequested(true);
      setPaymentCompleted(true);
    }
  };

  // BƯỚC 2: Lưu biên bản (sau khi thanh toán xong)
  const handleSaveReceipt = () => {
    setIsSubmitting(true);
    // Simulate saving to server
    setTimeout(() => {
      setIsSubmitting(false);
      setReceiptSaved(true);
      toast.success('✅ Lưu biên bản nhận xe thành công!');
      
      // Navigate back after saving
      setTimeout(() => {
        navigate(`/staff/order/${orderId}`);
      }, 2000);
    }, 1500);
  };

  const vehiclePhotoPositions = [
    { key: 'front' as const, label: 'Phía trước', icon: '🚗' },
    { key: 'back' as const, label: 'Phía sau', icon: '🚙' },
    { key: 'left' as const, label: 'Bên trái', icon: '🚘' },
    { key: 'right' as const, label: 'Bên phải', icon: '🚖' },
    { key: 'interior' as const, label: 'Nội thất', icon: '💺' },
    { key: 'dashboard' as const, label: 'Bảng điều khiển', icon: '🎛️' },
  ];

  const checklistItems = [
    { key: 'exterior', label: 'Ngoại thất không trầy xước' },
    { key: 'tires', label: 'Lốp xe còn tốt' },
    { key: 'lights', label: 'Đèn chiếu sáng hoạt động' },
    { key: 'mirrors', label: 'Gương chiếu hậu đầy đủ' },
    { key: 'windshield', label: 'Kính chắn gió nguyên vẹn' },
    { key: 'interior', label: 'Nội thất sạch sẽ' },
    { key: 'engine', label: 'Động cơ hoạt động bình thường' },
    { key: 'fuel', label: 'Xác nhận mức nhiên liệu' },
  ];

  const checkedCount = Object.values(checklist).filter(c => c.checked).length;
  const photoCount = Object.values(checklist).filter(c => c.checked && c.photo).length;
  const vehiclePhotoCount = Object.values(vehiclePhotos).filter(p => p !== null).length;

  return (
    <div className="min-h-screen bg-gray-50 pb-24 max-w-md mx-auto">
      {/* Header - Sticky */}
      <div className="sticky top-0 z-40 bg-white px-5 pt-12 pb-6 rounded-b-[2rem] shadow-md border-b border-gray-100 relative overflow-hidden">
        {/* Decorative Circle Patterns */}
        <div className="absolute inset-0 opacity-[0.06]">
          <div className="absolute top-6 right-8 w-24 h-24 border-2 border-blue-600 rounded-full"></div>
          <div className="absolute top-10 right-24 w-16 h-16 border-2 border-green-600 rounded-full"></div>
          <div className="absolute bottom-2 left-6 w-28 h-28 border-2 border-blue-600 rounded-full"></div>
          <div className="absolute bottom-4 left-28 w-10 h-10 border border-green-600 rounded-full"></div>
        </div>

        <div className="relative z-10">
          <button
            onClick={() => navigate(`/staff/order/${orderId}`)}
            className="flex items-center gap-2 text-gray-600 mb-4 -ml-1 hover:text-gray-900 transition-colors"
          >
            <ArrowLeft size={20} strokeWidth={2.5} />
            <span className="text-sm font-semibold">Quay lại</span>
          </button>
          <div>
            <h1 className="text-gray-900 text-xl font-bold mb-1 tracking-tight">Biên bản NHẬN xe</h1>
            <p className="text-gray-500 text-sm">{order.vehicle} • {order.customer}</p>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="px-5 py-4 space-y-4">
        {/* Vehicle Info Summary */}
        <div className="bg-gradient-to-br from-green-600 to-green-700 rounded-2xl p-4 text-white shadow-lg">
          <div className="space-y-2">
            <div className="flex justify-between items-center">
              <span className="text-green-100 text-sm">Khách hàng:</span>
              <span className="font-semibold">{order.customer}</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-green-100 text-sm">Loại xe:</span>
              <span className="font-semibold">{order.vehicleType}</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-green-100 text-sm">Hãng xe:</span>
              <span className="font-semibold">{order.brand}</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-green-100 text-sm">Tổng chi phí:</span>
              <span className="font-bold text-lg">{order.total}</span>
            </div>
          </div>
        </div>

        {/* 1. Thông tin khách hàng */}
        <div className="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
          <h3 className="font-bold text-gray-900 mb-3 flex items-center gap-2">
            <User size={18} className="text-blue-600" />
            1. Thông tin khách hàng
          </h3>
          <p className="text-xs text-blue-600 mb-3 bg-blue-50 p-2 rounded-lg">
            💡 Thông tin này sẽ tự động điền vào biên bản ủy quyền
          </p>
          <div className="space-y-3">
            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-1.5">
                Họ và tên <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={customerInfo.fullName}
                onChange={(e) => setCustomerInfo({ ...customerInfo, fullName: e.target.value })}
                placeholder="Nhập họ và tên đầy đủ"
                className="w-full px-4 py-2.5 rounded-xl border-2 border-gray-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none text-sm"
              />
            </div>
            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-1.5">
                CMND/CCCD <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={customerInfo.idNumber}
                onChange={(e) => setCustomerInfo({ ...customerInfo, idNumber: e.target.value })}
                placeholder="Nhập số CMND/CCCD"
                className="w-full px-4 py-2.5 rounded-xl border-2 border-gray-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none text-sm"
              />
            </div>
            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-1.5">
                Số điện thoại <span className="text-red-500">*</span>
              </label>
              <input
                type="tel"
                value={customerInfo.phone}
                onChange={(e) => setCustomerInfo({ ...customerInfo, phone: e.target.value })}
                placeholder="Nhập số điện thoại"
                className="w-full px-4 py-2.5 rounded-xl border-2 border-gray-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none text-sm"
              />
            </div>
            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-1.5">
                Địa chỉ <span className="text-red-500">*</span>
              </label>
              <textarea
                value={customerInfo.address}
                onChange={(e) => setCustomerInfo({ ...customerInfo, address: e.target.value })}
                placeholder="Nhập địa chỉ đầy đủ"
                className="w-full h-20 px-4 py-2.5 rounded-xl border-2 border-gray-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none resize-none text-sm"
              />
            </div>
          </div>
        </div>

        {/* 2. 6 ảnh thực tế của xe */}
        <div className="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
          <h3 className="font-bold text-gray-900 mb-3 flex items-center gap-2">
            <Camera size={18} className="text-green-600" />
            2. Chụp 6 ảnh thực tế của xe ({vehiclePhotoCount}/6)
          </h3>
          <p className="text-xs text-orange-600 mb-3 bg-orange-50 p-2 rounded-lg">
            ⚠️ Bắt buộc chụp đầy đủ 6 ảnh để lưu biên bản
          </p>
          <div className="grid grid-cols-2 gap-3">
            {vehiclePhotoPositions.map((pos) => (
              <div key={pos.key} className="space-y-2">
                <div
                  className={`relative w-full aspect-video rounded-xl border-2 border-dashed overflow-hidden ${
                    vehiclePhotos[pos.key]
                      ? 'border-green-500 bg-green-50'
                      : 'border-gray-300 bg-gray-50'
                  } transition-colors flex flex-col items-center justify-center gap-1`}
                >
                  {vehiclePhotos[pos.key] ? (
                    <>
                      <img
                        src={vehiclePhotos[pos.key]!}
                        alt={pos.label}
                        className="absolute inset-0 w-full h-full object-cover"
                      />
                      <div className="absolute inset-0 bg-green-600/20 flex items-center justify-center pointer-events-none">
                        <Check size={32} className="text-white drop-shadow-lg" />
                      </div>
                      <button
                        onClick={(e) => handleRemoveVehiclePhoto(pos.key, e)}
                        className="absolute top-2 right-2 w-6 h-6 bg-red-500 hover:bg-red-600 rounded-full flex items-center justify-center transition-colors shadow-lg z-10"
                      >
                        <X size={14} className="text-white" />
                      </button>
                    </>
                  ) : (
                    <button
                      onClick={() => handleVehiclePhotoCapture(pos.key)}
                      className="absolute inset-0 w-full h-full flex flex-col items-center justify-center gap-1"
                    >
                      <Camera size={24} className="text-gray-400" />
                      <span className="text-2xl">{pos.icon}</span>
                    </button>
                  )}
                </div>
                <p className="text-xs text-center font-medium text-gray-700">{pos.label}</p>
              </div>
            ))}
          </div>
        </div>

        {/* 3. Checklist kiểm tra (có ảnh kèm theo) */}
        <div className="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
          <h3 className="font-bold text-gray-900 mb-3 flex items-center gap-2">
            <Check size={18} className="text-purple-600" />
            3. Checklist kiểm tra ({checkedCount}/{checklistItems.length})
          </h3>
          <p className="text-xs text-purple-600 mb-3 bg-purple-50 p-2 rounded-lg">
            💡 Mỗi hạng mục đã check phải có ảnh kèm theo
          </p>
          <div className="space-y-3">
            {checklistItems.map((item) => (
              <div
                key={item.key}
                className={`rounded-xl border-2 transition-all ${
                  checklist[item.key].checked
                    ? 'border-purple-500 bg-purple-50'
                    : 'border-gray-200 bg-white'
                }`}
              >
                {/* Checkbox */}
                <label
                  className="flex items-center gap-3 p-3 cursor-pointer"
                >
                  <input
                    type="checkbox"
                    checked={checklist[item.key].checked}
                    onChange={() => handleChecklistToggle(item.key)}
                    className="w-5 h-5 text-purple-600 rounded border-gray-300 focus:ring-purple-500 cursor-pointer"
                  />
                  <span className={`text-sm flex-1 ${checklist[item.key].checked ? 'text-purple-900 font-semibold' : 'text-gray-700'}`}>
                    {item.label}
                  </span>
                  {checklist[item.key].checked && (
                    <Check size={18} className="text-purple-600" />
                  )}
                </label>

                {/* Photo Upload - Only show if checked */}
                {checklist[item.key].checked && (
                  <div className="px-3 pb-3">
                    {checklist[item.key].photo ? (
                      <div className="relative rounded-lg overflow-hidden border-2 border-purple-400">
                        <img
                          src={checklist[item.key].photo!}
                          alt={item.label}
                          className="w-full h-32 object-cover"
                        />
                        <button
                          onClick={(e) => handleRemoveChecklistPhoto(item.key, e)}
                          className="absolute top-2 right-2 w-7 h-7 bg-red-500 hover:bg-red-600 rounded-full flex items-center justify-center transition-colors shadow-lg"
                        >
                          <X size={16} className="text-white" />
                        </button>
                        <div className="absolute bottom-2 left-2 bg-purple-600 text-white text-xs px-2 py-1 rounded-lg font-semibold flex items-center gap-1">
                          <Check size={12} />
                          Đã chụp
                        </div>
                      </div>
                    ) : (
                      <button
                        onClick={() => handleChecklistPhotoCapture(item.key)}
                        className="w-full h-32 rounded-lg border-2 border-dashed border-gray-300 bg-gray-50 hover:bg-gray-100 transition-colors flex flex-col items-center justify-center gap-2"
                      >
                        <Camera size={24} className="text-gray-400" />
                        <span className="text-sm text-gray-600 font-medium">Chụp ảnh</span>
                      </button>
                    )}
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>

        {/* 4. Ghi chú chung */}
        <div className="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
          <h3 className="font-bold text-gray-900 mb-3 flex items-center gap-2">
            <FileText size={18} className="text-gray-600" />
            4. Ghi chú chung (tùy chọn)
          </h3>
          <textarea
            value={generalNote}
            onChange={(e) => setGeneralNote(e.target.value)}
            placeholder="Nhập ghi chú thêm về tình trạng xe..."
            className="w-full h-24 px-4 py-3 rounded-xl border-2 border-gray-200 focus:border-green-500 focus:ring-2 focus:ring-green-200 outline-none resize-none text-sm"
          />
        </div>

        {/* 5. Chữ ký khách hàng */}
        <div className="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
          <h3 className="font-bold text-gray-900 mb-3 flex items-center gap-2">
            <Edit3 size={18} className="text-orange-600" />
            5. Chữ ký khách hàng
          </h3>
          <p className="text-xs text-orange-600 mb-3 bg-orange-50 p-2 rounded-lg">
            ⚠️ Yêu cầu khách hàng ký vào biên bản ủy quyền
          </p>
          <div className="space-y-3">
            <div className={`border-2 border-dashed rounded-xl p-8 text-center transition-all ${
              customerSignature 
                ? 'border-green-500 bg-green-50' 
                : 'border-gray-300 bg-gray-50'
            }`}>
              {customerSignature ? (
                <div className="space-y-2">
                  <CheckCircle size={48} className="text-green-600 mx-auto" />
                  <p className="text-green-900 font-bold">Đã ký xác nhận</p>
                  <p className="text-green-700 text-sm">Khách hàng đã ký biên bản</p>
                </div>
              ) : (
                <div className="space-y-2">
                  <div className="w-16 h-16 bg-gray-200 rounded-full flex items-center justify-center mx-auto text-3xl">
                    ✍️
                  </div>
                  <p className="text-gray-700 font-semibold">Chưa có chữ ký</p>
                  <p className="text-gray-500 text-sm">Nhấn nút bên dưới để xác nhận</p>
                </div>
              )}
            </div>
            <button
              onClick={handleCustomerSignature}
              className="w-full py-3 bg-orange-600 text-white rounded-xl font-semibold hover:bg-orange-700 transition-colors"
            >
              {customerSignature ? 'Ký lại' : 'Xác nhận chữ ký'}
            </button>
          </div>
        </div>

        {/* 6. Phương thức thanh toán */}
        {!paymentRequested && (
          <div className="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
            <h3 className="font-bold text-gray-900 mb-3 flex items-center gap-2">
              <CreditCard size={18} className="text-blue-600" />
              6. Phương thức thanh toán
            </h3>
            <p className="text-xs text-blue-600 mb-3 bg-blue-50 p-2 rounded-lg">
              💡 Chọn phương thức thanh toán phù hợp
            </p>
            <div className="grid grid-cols-2 gap-3">
              <button
                onClick={() => setPaymentMethod('qr')}
                className={`p-4 rounded-xl border-2 transition-all ${
                  paymentMethod === 'qr'
                    ? 'border-blue-500 bg-blue-50'
                    : 'border-gray-200 bg-white'
                }`}
              >
                <QrCode size={32} className={`mx-auto mb-2 ${paymentMethod === 'qr' ? 'text-blue-600' : 'text-gray-400'}`} />
                <p className={`text-sm font-semibold text-center ${paymentMethod === 'qr' ? 'text-blue-900' : 'text-gray-700'}`}>
                  VietQR
                </p>
                <p className="text-xs text-gray-500 text-center mt-1">Quét mã thanh toán</p>
              </button>
              <button
                onClick={() => setPaymentMethod('cash')}
                className={`p-4 rounded-xl border-2 transition-all ${
                  paymentMethod === 'cash'
                    ? 'border-green-500 bg-green-50'
                    : 'border-gray-200 bg-white'
                }`}
              >
                <Banknote size={32} className={`mx-auto mb-2 ${paymentMethod === 'cash' ? 'text-green-600' : 'text-gray-400'}`} />
                <p className={`text-sm font-semibold text-center ${paymentMethod === 'cash' ? 'text-green-900' : 'text-gray-700'}`}>
                  Tiền mặt
                </p>
                <p className="text-xs text-gray-500 text-center mt-1">Thu tiền trực tiếp</p>
              </button>
            </div>
          </div>
        )}

        {/* Validation Summary Card */}
        <div className="bg-gradient-to-br from-blue-50 to-green-50 rounded-2xl p-4 border-2 border-blue-200">
          <h3 className="font-bold text-gray-900 mb-3 flex items-center gap-2">
            <CheckCircle size={18} className="text-blue-600" />
            Tình trạng hoàn thành
          </h3>
          <div className="space-y-2">
            {/* Customer Info Progress */}
            <div className="flex items-center justify-between p-2.5 bg-white rounded-lg">
              <span className="text-sm text-gray-700 font-medium">1. Thông tin khách hàng</span>
              <div className="flex items-center gap-2">
                {customerInfo.fullName && customerInfo.idNumber && customerInfo.phone && customerInfo.address ? (
                  <CheckCircle size={18} className="text-green-600" />
                ) : (
                  <div className="w-4.5 h-4.5 rounded-full border-2 border-gray-300"></div>
                )}
              </div>
            </div>

            {/* Vehicle Photos Progress */}
            <div className="flex items-center justify-between p-2.5 bg-white rounded-lg">
              <span className="text-sm text-gray-700 font-medium">2. Ảnh xe (6 ảnh)</span>
              <div className="flex items-center gap-2">
                <span className={`text-sm font-bold ${vehiclePhotoCount === 6 ? 'text-green-600' : 'text-gray-400'}`}>
                  {vehiclePhotoCount}/6
                </span>
                {vehiclePhotoCount === 6 ? (
                  <CheckCircle size={18} className="text-green-600" />
                ) : (
                  <div className="w-4.5 h-4.5 rounded-full border-2 border-gray-300"></div>
                )}
              </div>
            </div>

            {/* Checklist Progress */}
            <div className="flex items-center justify-between p-2.5 bg-white rounded-lg">
              <span className="text-sm text-gray-700 font-medium">3. Checklist + Ảnh</span>
              <div className="flex items-center gap-2">
                <span className={`text-sm font-bold ${photoCount === checkedCount && checkedCount >= 6 ? 'text-green-600' : 'text-gray-400'}`}>
                  {photoCount}/{checkedCount}
                </span>
                {photoCount === checkedCount && checkedCount >= 6 ? (
                  <CheckCircle size={18} className="text-green-600" />
                ) : (
                  <div className="w-4.5 h-4.5 rounded-full border-2 border-gray-300"></div>
                )}
              </div>
            </div>

            {/* Signature Progress */}
            <div className="flex items-center justify-between p-2.5 bg-white rounded-lg">
              <span className="text-sm text-gray-700 font-medium">5. Chữ ký khách hàng</span>
              <div className="flex items-center gap-2">
                {customerSignature ? (
                  <CheckCircle size={18} className="text-green-600" />
                ) : (
                  <div className="w-4.5 h-4.5 rounded-full border-2 border-gray-300"></div>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Action Buttons */}
        {!paymentRequested ? (
          // BƯỚC 1: Chọn phương thức thanh toán
          paymentMethod === 'qr' ? (
            <button
              onClick={handleRequestPayment}
              className="w-full flex items-center justify-center gap-2 py-4 bg-blue-600 text-white rounded-2xl font-bold hover:bg-blue-700 transition-colors shadow-lg shadow-blue-600/20"
            >
              <QrCode size={20} />
              <span>Gửi yêu cầu thanh toán QR</span>
            </button>
          ) : (
            <button
              onClick={handleCashPayment}
              className="w-full flex items-center justify-center gap-2 py-4 bg-green-600 text-white rounded-2xl font-bold hover:bg-green-700 transition-colors shadow-lg shadow-green-600/20"
            >
              <Banknote size={20} />
              <span>Xác nhận thu tiền mặt</span>
            </button>
          )
        ) : !paymentCompleted ? (
          // Đang chờ khách thanh toán QR
          <div className="bg-orange-50 rounded-2xl p-4 border-2 border-orange-200">
            <div className="flex items-start gap-3">
              <div className="w-5 h-5 border-2 border-orange-600 border-t-transparent rounded-full animate-spin mt-0.5"></div>
              <div className="flex-1">
                <p className="text-orange-900 font-bold">Đã gửi yêu cầu thanh toán QR</p>
                <p className="text-orange-700 text-sm mt-1">Đang chờ khách hàng quét mã thanh toán...</p>
              </div>
            </div>
          </div>
        ) : !receiptSaved ? (
          // BƯỚC 2: Lưu biên bản (sau khi thanh toán xong)
          <>
            <div className="bg-green-50 rounded-2xl p-4 border-2 border-green-200">
              <div className="flex items-center gap-3">
                <CheckCircle size={24} className="text-green-600" />
                <div>
                  <p className="text-green-900 font-bold">Thanh toán thành công!</p>
                  <p className="text-green-700 text-sm">
                    {paymentMethod === 'qr' ? 'Đã nhận thanh toán QR' : 'Đã thu tiền mặt'} {order.total}
                  </p>
                  <p className="text-green-700 text-sm">Bây giờ bạn có thể lưu biên bản</p>
                </div>
              </div>
            </div>

            <button
              onClick={handleSaveReceipt}
              disabled={isSubmitting}
              className="w-full flex items-center justify-center gap-2 py-4 bg-green-600 text-white rounded-2xl font-bold hover:bg-green-700 transition-colors shadow-lg shadow-green-600/20 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isSubmitting ? (
                <>
                  <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                  <span>Đang lưu...</span>
                </>
              ) : (
                <>
                  <FileText size={20} />
                  <span>Lưu biên bản nhận xe</span>
                </>
              )}
            </button>
          </>
        ) : (
          // Hoàn thành
          <div className="bg-purple-50 rounded-2xl p-4 border-2 border-purple-200">
            <div className="flex items-center gap-3">
              <CheckCircle size={24} className="text-purple-600" />
              <div>
                <p className="text-purple-900 font-bold">🎉 Hoàn thành!</p>
                <p className="text-purple-700 text-sm">Đang chuyển hướng...</p>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
