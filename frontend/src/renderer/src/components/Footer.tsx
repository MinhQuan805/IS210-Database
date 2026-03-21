import app from '../assets/Download_on_the_App_Store_Badge.svg.png'
import google from '../assets/Google_Play_Store_badge_EN.svg.png'

export default function Footer() {
  return (
    <footer>
      <div className="bg-gray-800 text-gray-300 px-8 py-5 mt-20 max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-10">
        {/* LEFT */}
        <div className="md:col-span-2 grid grid-cols-2 gap-10 md:px-20 md:border-r-5 md:border-gray-300">
          {/* Reservations */}
          <div>
            <h3 className="text-white font-semibold tracking-wide mb-4">ĐẶT PHÒNG</h3>
            <ul>
              <li className="hover:text-white cursor-pointer">Sửa / đóng booking ↗</li>
              <li className="hover:text-white cursor-pointer">Xem hóa đơn ↗</li>
            </ul>
          </div>

          {/* Customer Service */}
          <div>
            <h3 className="text-white font-semibold tracking-wide mb-4">DỊCH VỤ</h3>
            <ul>
              <li className="hover:text-white cursor-pointer">FAQs ↗</li>
              <li className="hover:text-white cursor-pointer">Hợp tác ↗</li>
            </ul>
          </div>

          {/* Corporate Sites */}
          <div>
            <h3 className="text-white font-semibold tracking-wide mb-4">LUMINA SUITES</h3>
            <ul>
              <li>Về chúng tôi ↗</li>
              <li>Tuyển dụng ↗</li>
              <li>Nhà đầu tư ↗</li>
            </ul>
          </div>

          {/* Explore More */}
          <div>
            <h3 className="text-white font-semibold tracking-wide mb-4">KHÁM PHÁ</h3>
            <ul>
              <li>Reviews ↗</li>
              <li>Du lịch ↗</li>
              <li>Cư trú ↗</li>
              <li>Quà tặng ↗</li>
            </ul>
          </div>
        </div>

        {/* RIGHT */}
        <div className="space-y-10">
          {/* Best Rate */}
          <div>
            <h3 className="text-white font-extrabold text-lg mb-4">
              THE LUMINA SUITES <br /> BEST RATE GUARANTEE
            </h3>
            <button className="border-2 border-gray-300 px-2 py-1 hover:bg-white hover:text-black transition">
              TÌM HIỂU THÊM
            </button>
          </div>

          {/* App */}
          <div>
            <h3 className="text-white font-semibold text-lg mb-4">TẢI MOBILE APP</h3>
            <div className="flex gap-4">
              <img src={app} alt="App Store" className="h-10 cursor-pointer" />
              <img src={google} alt="Google Play" className="h-10 cursor-pointer" />
            </div>
          </div>

          {/* Social */}
          <div>
            <h3 className="text-white font-semibold text-lg mb-4">MẠNG XÃ HỘI</h3>
            <div className="flex gap-5">
              {[
                <svg viewBox="0 0 128 128" className="size-8">
                  <rect
                    fill="#3d5a98"
                    x="4.83"
                    y="4.83"
                    width="118.35"
                    height="118.35"
                    rx="6.53"
                    ry="6.53"
                  ></rect>
                  <path
                    fill="#fff"
                    d="M86.48 123.17V77.34h15.38l2.3-17.86H86.48v-11.4c0-5.17 1.44-8.7 8.85-8.7h9.46v-16A126.56 126.56 0 0091 22.7c-13.62 0-23 8.3-23 23.61v13.17H52.62v17.86H68v45.83z"
                  ></path>
                </svg>,

                <svg viewBox="0 0 128 128" className="size-8">
                  <path
                    d="M75.916 54.2 122.542 0h-11.05L71.008 47.06 38.672 0H1.376l48.898 71.164L1.376 128h11.05L55.18 78.303 89.328 128h37.296L75.913 54.2ZM60.782 71.79l-4.955-7.086-39.42-56.386h16.972L65.19 53.824l4.954 7.086 41.353 59.15h-16.97L60.782 71.793Z"
                    fill="#ffffff"
                  ></path>
                </svg>,

                <svg viewBox="0 0 128 128" className="size-8">
                  <path
                    fill="#0076b2"
                    d="M116 3H12a8.91 8.91 0 00-9 8.8v104.42a8.91 8.91 0 009 8.78h104a8.93 8.93 0 009-8.81V11.77A8.93 8.93 0 00116 3z"
                  ></path>
                  <path
                    fill="#fff"
                    d="M21.06 48.73h18.11V107H21.06zm9.06-29a10.5 10.5 0 11-10.5 10.49 10.5 10.5 0 0110.5-10.49M50.53 48.73h17.36v8h.24c2.42-4.58 8.32-9.41 17.13-9.41C103.6 47.28 107 59.35 107 75v32H88.89V78.65c0-6.75-.12-15.44-9.41-15.44s-10.87 7.36-10.87 15V107H50.53z"
                  ></path>
                </svg>
              ].map((item, idx) => (
                <div
                  key={idx}
                  className="w-10 h-10 flex items-center justify-center cursor-pointer"
                >
                  {item}
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
      <div className="w-full bg-gray-900 flex items-center justify-center gap-5 py-3">
        {['Chính sách bảo mật', 'Điều khoản sử dụng', '© 2026 Lumina Suites'].map((e, idx) => (
          <div className="text-gray-100 hover:text-white hover:underline cursor-pointer" key={idx}>
            {e}
          </div>
        ))}
      </div>
    </footer>
  )
}
