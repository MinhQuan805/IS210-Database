import { Search, User, ClipboardList } from 'lucide-react'

import { Link } from 'react-router-dom'

import { useAuthStore } from '@renderer/stores/auth-store'

import { ThemeSwitch } from '@renderer/components/theme-switch'
import { Button } from '@renderer/components/ui'
import UserAvatar from '@renderer/admin/components/layout/UserAvatar'

export default function Navbar() {
  const { user } = useAuthStore()

  return (
    <div className="fixed top-0 left-0 w-full h-14 bg-background z-50 flex items-center justify-end px-6 shadow-md">
      {/* TITLE CENTER */}
      <div className="absolute left-1/2 -translate-x-1/2 text-main text-2xl font-bold tracking-widest">
        <a href="/">LUMINA SUITES®</a>
      </div>

      {/* RIGHT MENU */}
      <div className="flex items-center gap-1">
        <ThemeSwitch />

        <Link to="/search/">
          <Button variant="ghost" className="rounded-full">
            <Search />
          </Button>
        </Link>

        <Link to="/bookingdetail">
          <Button variant="ghost" className="rounded-full">
            <ClipboardList />
          </Button>
        </Link>

        {!user ? (
          <Link to="/sign-in">
            <User className="size-5!" />
          </Link>
        ) : (
          <Link to="/admin">
            <UserAvatar
              user={{ name: user.name, email: user.email, avatar: '' }}
              showMetadata={false}
              className="size-5!"
            />
          </Link>
        )}
      </div>
    </div>
  )
}
