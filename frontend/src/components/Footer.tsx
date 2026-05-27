import app from '../assets/Download_on_the_App_Store_Badge.svg.png'
import google from '../assets/Google_Play_Store_badge_EN.svg.png'

export default function Footer() {
  const footerLinks = [
    {
      title: 'ĐẶT PHÒNG',
      links: ['Sửa / đóng booking ↗', 'Xem hóa đơn ↗', 'Chính sách hủy phòng', 'Ưu đãi thành viên']
    },
    {
      title: 'DỊCH VỤ',
      links: ['FAQs ↗', 'Hợp tác ↗', 'Dịch vụ đưa đón', 'Tổ chức sự kiện']
    },
    {
      title: 'LUMINA SUITES',
      links: ['Về chúng tôi ↗', 'Tuyển dụng ↗', 'Nhà đầu tư ↗', 'Phát triển bền vững']
    },
    {
      title: 'KHÁM PHÁ',
      links: ['Reviews ↗', 'Cẩm nang du lịch ↗', 'Không gian cư trú', 'Quà tặng đặc biệt']
    }
  ]

  const socialIcons = [
    {
      name: 'Facebook',
      color: '#1877F2',
      path: 'M86.48 123.17V77.34h15.38l2.3-17.86H86.48v-11.4c0-5.17 1.44-8.7 8.85-8.7h9.46v-16A126.56 126.56 0 0091 22.7c-13.62 0-23 8.3-23 23.61v13.17H52.62v17.86H68v45.83z'
    },
    {
      name: 'X',
      color: '#FFFFFF',
      path: 'M75.916 54.2 122.542 0h-11.05L71.008 47.06 38.672 0H1.376l48.898 71.164L1.376 128h11.05L55.18 78.303 89.328 128h37.296L75.913 54.2ZM60.782 71.79l-4.955-7.086-39.42-56.386h16.972L65.19 53.824l4.954 7.086 41.353 59.15h-16.97L60.782 71.793Z'
    },
    {
      name: 'LinkedIn',
      color: '#0077B5',
      path: 'M21.06 48.73h18.11V107H21.06zm9.06-29a10.5 10.5 0 11-10.5 10.49 10.5 10.5 0 0110.5-10.49M50.53 48.73h17.36v8h.24c2.42-4.58 8.32-9.41 17.13-9.41C103.6 47.28 107 59.35 107 75v32H88.89V78.65c0-6.75-.12-15.44-9.41-15.44s-10.87 7.36-10.87 15V107H50.53z'
    }
  ]

  return (
    <footer className="bg-gray-800 text-gray-400 font-light mt-20 border-t border-gray-800">
      {/* Main Footer Content */}
      <div className="max-w-7xl mx-auto px-8 py-16 grid grid-cols-1 lg:grid-cols-12 gap-12">
        {/* Left Links */}
        <div className="lg:col-span-8 grid grid-cols-2 sm:grid-cols-4 gap-8">
          {footerLinks.map((section, idx) => (
            <div key={idx}>
              <h3 className="text-white font-bold text-xs tracking-[0.2em] mb-6 uppercase">
                {section.title}
              </h3>
              <ul className="space-y-4 text-sm">
                {section.links.map((link, lIdx) => (
                  <li
                    key={lIdx}
                    className="hover:text-white hover:translate-x-1 transition-all cursor-pointer inline-block duration-300"
                  >
                    {link}
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>

        {/* Right Info */}
        <div className="lg:col-span-4 space-y-8 lg:pl-12 lg:border-l border-gray-800">
          <div>
            <h3 className="text-white font-bold text-sm mb-4 tracking-wider uppercase italic">
              Lumina Suites Guarantee
            </h3>
            <div className="space-y-2 text-sm leading-relaxed">
              <p>
                <span className="text-gray-500 uppercase text-[10px] block font-bold tracking-widest">
                  Địa chỉ
                </span>{' '}
                2 Công trường Lam Sơn, P. Bến Nghé, Quận 1, TP. HCM
              </p>
              <p>
                <span className="text-gray-500 uppercase text-[10px] block font-bold tracking-widest">
                  Liên lạc
                </span>{' '}
                (028) 3824 1234 • lumina-suites.org
              </p>
            </div>
          </div>

          <div>
            <h3 className="text-white font-bold text-xs tracking-[0.2em] mb-4 uppercase">
              Ứng dụng di động
            </h3>
            <div className="flex gap-3">
              <img
                src={app}
                alt="App Store"
                className="h-9 hover:opacity-80 transition-opacity cursor-pointer shadow-lg"
              />
              <img
                src={google}
                alt="Google Play"
                className="h-9 hover:opacity-80 transition-opacity cursor-pointer shadow-lg"
              />
            </div>
          </div>

          <div>
            <h3 className="text-white font-bold text-xs tracking-[0.2em] mb-4 uppercase">
              Theo dõi chúng tôi
            </h3>
            <div className="flex gap-4">
              {socialIcons.map((icon, idx) => (
                <div
                  key={idx}
                  className="w-10 h-10 border border-gray-700 flex items-center justify-center hover:bg-white hover:text-black transition-all duration-500 group cursor-pointer"
                >
                  <svg viewBox="0 0 128 128" className="size-5 fill-current">
                    <path d={icon.path}></path>
                  </svg>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Bottom Bar */}
      <div className="bg-black py-6 border-t border-gray-900">
        <div className="max-w-7xl mx-auto px-8 flex flex-col md:flex-row justify-between items-center gap-4 text-[11px] tracking-widest uppercase font-medium">
          <div className="flex gap-8">
            <span className="hover:text-white cursor-pointer transition-colors">
              Chính sách bảo mật
            </span>
            <span className="hover:text-white cursor-pointer transition-colors">
              Điều khoản sử dụng
            </span>
            <span className="hover:text-white cursor-pointer transition-colors">Cookie Policy</span>
          </div>
          <div className="text-gray-600">© 2026 LUMINA SUITES. ALL RIGHTS RESERVED.</div>
        </div>
      </div>
    </footer>
  )
}
